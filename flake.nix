{
  description = "Bleeding edge Emacs overlay";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
    }:
    let
      inherit (nixpkgs) lib;

      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      importPkgs =
        path: attrs:
        import path (
          attrs
          // {
            config.allowAliases = false;
            overlays = [ self.overlays.default ];
          }
        );

      manualPackageNames =
        let
          dir = ./manual-packages;
          entries = builtins.readDir dir;

          filePkgs = lib.mapAttrsToList (name: _: lib.removeSuffix ".nix" name) (
            lib.filterAttrs (
              name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
            ) entries
          );

          dirPkgs = lib.attrNames (
            lib.filterAttrs (
              name: type: type == "directory" && builtins.pathExists (dir + "/${name}/package.nix")
            ) entries
          );
        in
        lib.unique (filePkgs ++ dirPkgs);

      manualPackagePathFor =
        name:
        let
          dir = ./manual-packages;
        in
        if builtins.pathExists (dir + "/${name}.nix") then
          dir + "/${name}.nix"
        else if builtins.pathExists (dir + "/${name}/package.nix") then
          dir + "/${name}/package.nix"
        else
          throw "Cannot find manual package file for ${name}";

      manualPackagesFor =
        system:
        let
          pkgs = importPkgs nixpkgs { inherit system; };

          emacs = pkgs.emacs-git;

          epkgs = pkgs.emacsPackagesFor emacs;

          manualScope =
            pkgs
            // epkgs
            // {
              inherit emacs;
            };

          callManualPackage = pkgs.lib.callPackageWith manualScope;
        in
        lib.genAttrs manualPackageNames (name: callManualPackage (manualPackagePathFor name) { });

      packages' = forAllSystems (
        system:
        let
          pkgs = importPkgs nixpkgs { inherit system; };
          inherit (pkgs) lib;

          overlayAttributes = lib.pipe (import ./. pkgs pkgs) [
            builtins.attrNames
            (lib.partition (n: lib.isDerivation pkgs.${n}))
          ];

          attributesToAttrset =
            attributes:
            lib.pipe attributes [
              (map (n: lib.nameValuePair n pkgs.${n}))
              lib.listToAttrs
            ];
        in
        {
          lib = attributesToAttrset overlayAttributes.wrong;
          packages = attributesToAttrset overlayAttributes.right;
        }
      );

    in
    {
      # self: super: must be named final: prev: for nix flake check.
      overlays = {
        default = final: prev: import ./overlays final prev;
        emacs = final: prev: import ./overlays/emacs.nix final prev;
        package = final: prev: import ./overlays/package.nix final prev;
        manual-packages = final: prev: import ./overlays/manual-packages.nix final prev;
      };

      overlay = self.overlays.default;

      inherit manualPackageNames;

      packages = forAllSystems (system: packages'.${system}.packages // manualPackagesFor system);

      # Non-derivation helper outputs from the overlay.
      lib = forAllSystems (system: packages'.${system}.lib);

      hydraJobs = lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (
        system:
        let
          mkHydraJobs =
            pkgs:
            let
              inherit (pkgs) lib;

              filterNonDrvAttrs =
                s:
                lib.mapAttrs (_: v: if lib.isDerivation v then v else filterNonDrvAttrs v) (
                  lib.filterAttrs (
                    _: v: lib.isDerivation v || (builtins.typeOf v == "set" && !builtins.hasAttr "__functor" v)
                  ) s
                );

              mkEmacsSet = emacs: filterNonDrvAttrs (pkgs.recurseIntoAttrs (pkgs.emacsPackagesFor emacs));
            in
            {
              emacsen = {
                inherit (pkgs) emacs-git emacs-git-pgtk;
                inherit (pkgs) emacs-igc emacs-igc-pgtk;
              };

            };
        in
        {
          stable = mkHydraJobs (importPkgs nixpkgs-stable { inherit system; });

          unstable = mkHydraJobs (importPkgs nixpkgs { inherit system; });
        }
      );
    };
}

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

      manualPackageDiscovery = import ./manual-packages/discover { inherit lib; };

      manualPackageNames = manualPackageDiscovery.packageNames;

      manualPackageOutputsFor =
        system:
        let
          pkgs = importPkgs nixpkgs { inherit system; };

          epkgs = pkgs.emacsPackages;
        in
        # These flat flake package outputs are for local builds and the manual
        # updater. Downstream users should consume manual packages through the
        # generic overlay API: pkgs.emacsPackagesFor <chosen-emacs>.
        lib.genAttrs manualPackageNames (
          name:
          if builtins.hasAttr name epkgs then
            epkgs.${name}
          else
            throw "Manual Emacs package '${name}' was not found in pkgs.emacsPackages"
        );

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

      packages = forAllSystems (system: packages'.${system}.packages // manualPackageOutputsFor system);

      # Non-derivation helper outputs from the overlay.
      lib = forAllSystems (system: packages'.${system}.lib // { inherit manualPackageNames; });

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

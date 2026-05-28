{
  pkgs,
  emacs,
  eself,
  esuper,
}:

let
  lib = pkgs.lib;

  discovery = import ./discover { inherit lib; };

  scope =
    pkgs
    // eself
    // {
      inherit emacs pkgs;
    };

  callPackage = lib.callPackageWith scope;

  packageFor = name: {
    inherit name;
    value = callPackage (discovery.packagePathFor name) { };
  };

in

builtins.listToAttrs (map packageFor discovery.packageNames)

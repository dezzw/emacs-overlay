{
  pkgs,
  emacs,
  eself,
  esuper,
}:

let
  lib = pkgs.lib;

  dir = ./.;

  entries = builtins.readDir dir;

  scope =
    pkgs
    // eself
    // {
      inherit emacs;
    };

  callPackage = lib.callPackageWith scope;

  isPackageFile = name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix";

  isPackageDir =
    name: type: type == "directory" && builtins.pathExists (dir + "/${name}/package.nix");

  filePackages = lib.mapAttrsToList (name: _type: {
    name = lib.removeSuffix ".nix" name;
    value = callPackage (dir + "/${name}") { };
  }) (lib.filterAttrs isPackageFile entries);

  dirPackages = lib.mapAttrsToList (name: _type: {
    inherit name;
    value = callPackage (dir + "/${name}/package.nix") { };
  }) (lib.filterAttrs isPackageDir entries);

in

builtins.listToAttrs (filePackages ++ dirPackages)

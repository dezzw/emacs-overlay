{
  lib,
  dir ? ../.,
}:

let
  entries = builtins.readDir dir;

  isPackageFile =
    name: type:
    type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix";

  isPackageDir =
    name: type: type == "directory" && builtins.pathExists (dir + "/${name}/package.nix");

  filePackageNames = lib.mapAttrsToList (name: _type: lib.removeSuffix ".nix" name) (
    lib.filterAttrs isPackageFile entries
  );

  dirPackageNames = lib.attrNames (lib.filterAttrs isPackageDir entries);

  packageNames = lib.unique (filePackageNames ++ dirPackageNames);

  packagePathFor =
    name:
    if builtins.pathExists (dir + "/${name}.nix") then
      dir + "/${name}.nix"
    else if builtins.pathExists (dir + "/${name}/package.nix") then
      dir + "/${name}/package.nix"
    else
      throw "Cannot find manual package file for ${name}";
in

{
  inherit packageNames packagePathFor;
}

{ pkgs, lib }:

let
  inherit (import ./repos/fromElisp { inherit pkgs; }) fromElisp;

  normalizePackageValue =
    value:
    if builtins.isString value then
      [ value ]
    else if builtins.isList value then
      lib.flatten value
    else
      [ ];

  parsePackagesFromSetup =
    configText:
    let
      inherit (builtins) head tail;

      recurse =
        inSetup: item:
        if !(builtins.isList item) || item == [ ] then
          [ ]
        else if !inSetup && head item == "setup" then
          recurse true (tail item)
        else if inSetup && head item == ":package" then
          normalizePackageValue (tail item)
        else
          builtins.concatMap (recurse inSetup) item;
    in
    lib.unique ([ "setup" ] ++ recurse false (fromElisp configText));

in
{
  inherit parsePackagesFromSetup;
}

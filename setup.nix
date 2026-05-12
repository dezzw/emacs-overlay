{ pkgs }:

let
  parse = pkgs.callPackage ./parse.nix { };
in

{
  config,
  extraEmacsPackages ? epkgs: [ ],
  package ? pkgs.emacs,
  override ? self: super: { },
}:

let
  lib = pkgs.lib;

  /*
    Accept:
      config = ./init.el;
      config = ./lisp;
      config = [ ./init.el ./lisp ];
      config = ''
        (setup magit (:package magit))
      '';
  */

  isElispFile =
    path:
    let
      s = toString path;
    in
    lib.hasSuffix ".el" s;

  filesFromPath =
    path:
    let
      type = lib.filesystem.pathType path;
    in
    if type == "regular" then
      lib.optional (isElispFile path) path
    else if type == "directory" then
      builtins.filter isElispFile (lib.filesystem.listFilesRecursive path)
    else
      [ ];

  configToFiles =
    config:
    let
      type = builtins.typeOf config;
    in
    if type == "path" then
      filesFromPath config
    else if type == "list" then
      lib.concatMap configToFiles config
    else
      [ ];

  configToText =
    config:
    let
      type = builtins.typeOf config;
    in
    if type == "string" && builtins.hasContext config then
      builtins.readFile config
    else if type == "string" then
      config
    else if type == "path" || type == "list" then
      builtins.concatStringsSep "\n" (map builtins.readFile (configToFiles config))
    else if lib.isDerivation config then
      builtins.readFile "${config}"
    else
      throw "Unsupported config type for emacsWithPackagesFromSetup: ${type}";

  configFiles = lib.sort (a: b: toString a < toString b) (configToFiles config);

  configText =
    let
      type = builtins.typeOf config;
    in
    if type == "path" || type == "list" then
      builtins.concatStringsSep "\n" (map builtins.readFile configFiles)
    else
      configToText config;

  packageNames = parse.parsePackagesFromSetup configText;

  emacsPackages = (pkgs.emacsPackagesFor package).overrideScope (
    self: super: if builtins.isFunction (override super) then override self super else override super
  );

  packageFromName =
    epkgs: name:
    epkgs.${name} or (throw "Emacs package '${name}' declared by setup.el :package was not found.");

in
emacsPackages.emacsWithPackages (
  epkgs:
  let
    setupPkgs = builtins.map (packageFromName epkgs) packageNames;
    extraPkgs = extraEmacsPackages epkgs;
  in
  setupPkgs ++ extraPkgs
)

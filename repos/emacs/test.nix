{
  pkgs ? import <nixpkgs> { overlays = [ (import ../../default.nix) ]; },
}:

let
  mkTestBuild =
    package:
    let
      emacsPackages = pkgs.emacsPackagesFor package;
      emacsWithPackages = emacsPackages.emacsWithPackages;
    in
    emacsWithPackages (epkgs: [ ]);
in
{
  emacs-git = mkTestBuild pkgs.emacs-git;
  emacs-git-pgtk = mkTestBuild pkgs.emacs-git-pgtk;

  emacs-igc = mkTestBuild pkgs.emacs-igc;
  emacs-igc-pgtk = mkTestBuild pkgs.emacs-igc-pgtk;
}

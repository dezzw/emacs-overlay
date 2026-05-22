self: super:

{
  emacsPackagesFor =
    emacs:
    (super.emacsPackagesFor emacs).overrideScope (
      eself: esuper:
      import ../manual-packages {
        pkgs = self;
        inherit emacs eself esuper;
      }
    );
}

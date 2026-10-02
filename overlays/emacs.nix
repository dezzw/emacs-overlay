self: super:
let
  mkGitEmacs =
    namePrefix: jsonFile:
    { ... }@args:
    let
      repoMeta = super.lib.importJSON jsonFile;
      fetcher =
        if repoMeta.type == "savannah" then
          super.fetchgit
        else if repoMeta.type == "github" then
          super.fetchFromGitHub
        else
          throw "Unknown repository type ${repoMeta.type}!";
    in
    builtins.foldl' (drv: fn: fn drv) super.emacs ([

      (
        drv:
        drv.override (
          {
            srcRepo = true;
          }
          // args
        )
      )

      (
        drv:
        drv.overrideAttrs (old: {
          name = "${namePrefix}-${repoMeta.version}";
          inherit (repoMeta) version;
          src = fetcher (
            builtins.removeAttrs repoMeta [
              "type"
              "version"
            ]
          );

          # fixes segfaults that only occur on aarch64-linux (#264)
          configureFlags =
            old.configureFlags
            ++ super.lib.optionals (super.stdenv.isLinux && super.stdenv.isAarch64) [
              "--enable-check-lisp-object-type"
            ];

          postPatch = old.postPatch + ''
            substituteInPlace lisp/loadup.el \
            --replace-warn '(emacs-repository-get-version)' '"${repoMeta.rev}"' \
            --replace-warn '(emacs-repository-get-branch)' '"master"'
          '';
        })
      )

      (
        drv:
        drv.overrideAttrs (
          old:
          {
            patches =
              let
                inherit (super.lib) versionOlder versionAtLeast optionals;
                inapplicablePatches =
                  optionals (versionAtLeast old.version "31") [
                    "fix-off-by-one-mistake-80851-CVE-2026-6861.patch"
                    "nullify-read-symbol-shorthands-around-risky-intern-calls-80574.patch"
                    "01_all_treesit-0.26.patch?id=d0f47979806d9be5a190fdb4ffa1bde439b2d616"
                    "02_all_ts-query-pred.patch?id=86190bf195b3e17108372d8ad89eb57037180dd2"
                    "CVE-2026-79992.patch"
                    "/nix/store/jm6hjlhhy87gwyx6dk659qq7krpc3liw-inhibit-lexical-cookie-warning-67916.patch"
                  ]
                  ++ optionals (versionOlder "31.1" old.version) [
                    "CVE-2024-53920.patch"
                  ];
                isApplicable = patch: !(builtins.elem patch.name or patch inapplicablePatches);
              in
              builtins.filter isApplicable old.patches;
          }
        )
      )

      # reconnect pkgs to the built emacs
      (
        drv:
        let
          result = drv.overrideAttrs (old: {
            passthru = old.passthru // {
              pkgs = self.emacsPackagesFor result;
            };
          });
        in
        result
      )
    ]);

  emacs-git =
    let
      base = (mkGitEmacs "emacs-git" ../repos/emacs/emacs-master.json) {
        withGTK3 = true;
        withXwidgets = true;
      };
      emacs = emacs-git;
    in
    base.overrideAttrs (oa: {
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

  emacs-git-pgtk =
    let
      base = (mkGitEmacs "emacs-git-pgtk" ../repos/emacs/emacs-master.json) {
        withPgtk = true;
        withXwidgets = true;
      };
      emacs = emacs-git-pgtk;
    in
    base.overrideAttrs (oa: {
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

  emacs-igc =
    let
      base = (mkGitEmacs "emacs-igc" ../repos/emacs/emacs-feature_igc3.json) {
        withGTK3 = true;
        withXwidgets = true;
      };
      emacs = emacs-igc;
    in
    base.overrideAttrs (oa: {
      configureFlags = oa.configureFlags ++ [ "--with-mps=yes" ];
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

  emacs-igc-pgtk =
    let
      base = (mkGitEmacs "emacs-igc-pgtk" ../repos/emacs/emacs-feature_igc3.json) {
        withPgtk = true;
        withXwidgets = true;
      };
      emacs = emacs-igc-pgtk;
    in
    base.overrideAttrs (oa: {
      configureFlags = oa.configureFlags ++ [ "--with-mps=yes" ];
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

in
{
  inherit emacs-git emacs-git-pgtk;

  inherit emacs-igc emacs-igc-pgtk;

  emacsWithPackagesFromSetup = import ../setup.nix { pkgs = self; };
}

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
            withXwidgets = false;
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
        drv.overrideAttrs (old: {
          patches =
            let
              isApplicable =
                patch:
                if super.lib.versionOlder old.version "31" then
                  true
                else
                  !(
                    builtins.elem patch.name or "" [
                      "fix-off-by-one-mistake-80851-CVE-2026-6861.patch"
                      "01_all_treesit-0.26.patch?id=d0f47979806d9be5a190fdb4ffa1bde439b2d616"
                      "02_all_ts-query-pred.patch?id=86190bf195b3e17108372d8ad89eb57037180dd2"
                    ]
                    || builtins.elem patch [
                      "/nix/store/jm6hjlhhy87gwyx6dk659qq7krpc3liw-inhibit-lexical-cookie-warning-67916.patch"
                    ]
                  );
            in
            builtins.filter isApplicable old.patches;
        })
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
      base = (mkGitEmacs "emacs-git" ../repos/emacs/emacs-master.json) { };
      emacs = emacs-git;
    in
    base.overrideAttrs (oa: {
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

  emacs-git-pgtk =
    let
      base = (mkGitEmacs "emacs-git-pgtk" ../repos/emacs/emacs-master.json) { withPgtk = true; };
      emacs = emacs-git-pgtk;
    in
    base.overrideAttrs (oa: {
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

  emacs-igc =
    let
      base = (mkGitEmacs "emacs-igc" ../repos/emacs/emacs-feature_igc3.json) { };
      emacs = emacs-igc;
    in
    base.overrideAttrs (oa: {
      buildInputs = oa.buildInputs ++ [ super.mps ];
      configureFlags = oa.configureFlags ++ [ "--with-mps=yes" ];
      passthru = oa.passthru // {
        pkgs = oa.passthru.pkgs.overrideScope (eself: esuper: { inherit emacs; });
      };
    });

  emacs-igc-pgtk =
    let
      base = (mkGitEmacs "emacs-igc-pgtk" ../repos/emacs/emacs-feature_igc3.json) { withPgtk = true; };
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

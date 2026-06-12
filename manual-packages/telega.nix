{
  fetchFromGitHub,
  gcc,
  gnumake,
  lib,
  melpaBuild,
  pkg-config,
  tdlib,
  visual-fill-column,
  writeText,
  zlib,
}:

let
  pname = "telega";
  version = "1778678932";

  telegaSrc = fetchFromGitHub {
    owner = "LuciusChen";
    repo = "telega.el";
    rev = "ab1b4ac20c71607350d108f9ea49726615ce5312";
    hash = "sha256-MqdHdPnOS/HanI+B0OFQ+gMuCyGHoozI0BmJvdJ81rw=";
  };

  tdlib-head = tdlib.overrideAttrs (_old: {
    version = "head-20260518";
    src = fetchFromGitHub {
      owner = "tdlib";
      repo = "td";
      rev = "062f26052623dbecedb42075cab78a759e9f9987";
      hash = "sha256-aBU67zvJaOWpC0v+2KalT8vA9wNm6kF0Yxd6UjUdySo=";
    };
    preConfigure = ''
      rm -rf build
    '';
    enableParallelBuilding = true;
    preBuild = ''
      export CMAKE_BUILD_PARALLEL_LEVEL=2
    '';
    makeFlags = [ "-j2" ];
  });
in

melpaBuild {
  inherit pname version;

  src = telegaSrc;

  ignoreCompilationError = true;
  packageRequires = [ visual-fill-column ];

  buildInputs = [
    tdlib-head
    zlib
  ];

  nativeBuildInputs = [
    gnumake
    gcc
    pkg-config
  ];

  postPatch = ''
    substituteInPlace telega-customize.el \
      --replace-fail '(defcustom telega-server-libs-prefix "/usr/local"' \
                     '(defcustom telega-server-libs-prefix "${tdlib-head}"'
    substituteInPlace telega-customize.el \
      --replace-fail '(defcustom telega-server-command "telega-server"' \
                     "(defcustom telega-server-command \"$out/share/emacs/site-lisp/elpa/telega-${version}/telega-server\""
  '';

  preBuild = ''
    make -C server clean
    make -C server install \
      LIBS_PREFIX=${tdlib-head} \
      INSTALL_PREFIX=$out/share/emacs/site-lisp/elpa/telega-${version}
  '';

  recipe = writeText "telega-recipe" ''
    (telega :repo "LuciusChen/telega.el"
            :fetcher github
            :files (:defaults "Makefile" "etc" "server" "contrib"))
  '';

  meta = {
    description = "GNU Emacs client for Telegram";
    homepage = "https://github.com/LuciusChen/telega.el";
    license = lib.licenses.gpl3Plus;
    maintainers = [ ];
    platforms = lib.platforms.unix;
  };
}

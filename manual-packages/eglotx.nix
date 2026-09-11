{
  lib,
  melpaBuild,
  fetchFromGitHub,
  eglot,
  jsonrpc,

}:

melpaBuild {
  pname = "eglotx";
  version = "1778678932";

  src = fetchFromGitHub {
    owner = "cxa";
    repo = "eglotx";
    rev = "35375c8d4aac8d4515cc8e43ab052a053b897eb5";
    hash = "sha256-It4GlU2XLGLmKTEn7AVw543dMrL7NnEAuZVhycEdcaU=";
  };

  packageRequires = [
    eglot
    jsonrpc
  ];

  meta = with lib; {
    description = "Fork of eglotx";
    homepage = "https://github.com/cxa/eglotx";
    license = licenses.gpl3Plus;
  };
}

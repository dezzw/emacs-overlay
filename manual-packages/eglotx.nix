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
    rev = "58033308a8c4611d9dd99cbebf8aa8d1fad40cb2";
    hash = "sha256-rbOIXVuAZ2BNwQSbGkf3LWTB44VglirsjtL9iI9PbtQ=";
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

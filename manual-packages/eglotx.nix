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
    rev = "d6f56bf343c0c137eec52c2a819dc01e648c9cb3";
    hash = "sha256-5BGQ4uDCsK3fk0M3Ow4p3ofI4VSMY7sweJ3tB4DuNfc=";
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

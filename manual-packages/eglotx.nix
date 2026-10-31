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
    rev = "1c4dc8a5dad33b001c4474878b5eaa011e79451e";
    hash = "sha256-GG0HqmLt1pPM27lneEeu7TGfaMXNizESaKSlv8th5/M=";
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

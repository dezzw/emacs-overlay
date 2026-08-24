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
    rev = "2d5d2fbbd0ebbf2d07972a6b260ff6d9023a4586";
    hash = "sha256-kSoZZ2sUX/a8mlBFfKCorSbUQjrQN8OTitD8/5s1ybE=";
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

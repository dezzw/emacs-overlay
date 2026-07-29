{
  lib,
  melpaBuild,
  fetchFromGitHub,
}:

melpaBuild rec {
  pname = "eglotx";
  version = "";

  src = fetchFromGitHub {
    owner = "cxa";
    repo = "eglotx";
    rev = "PUT_COMMIT_SHA_HERE";
    hash = "sha256-PUT_HASH_HERE";
  };

  meta = with lib; {
    description = "Fork of eglotx";
    homepage = "https://github.com/cxa/eglotx";
    license = licenses.gpl3Plus;
  };
}

{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "symbol-overlay";
  version = "1734330146";

  src = fetchFromGitHub {
    owner = "roife";
    repo = "symbol-overlay";
    rev = "00203ddc4363d906976f7b2153dc8dd6ae78373b";
    hash = "sha256-sYfY+vExSOaEg/uUPwxK8TjodPqH6Bz39NFYsDM0twg=";
  };
}

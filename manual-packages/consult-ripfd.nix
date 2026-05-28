{
  consult,
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "consult-ripfd";
  version = "1776979063";

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "consult-ripfd";
    rev = "98776211c6a9969565f3e65dcbd40924198fb03e";
    hash = "sha256-+Rhs/d1XpeSs8y7XocYyGIZlz3eOnligfTUgefKDhMw=";
  };

  packageRequires = [ consult ];
}

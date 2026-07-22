{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "org-modern-indent";
  version = "1767410992";

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "org-modern-indent";
    rev = "86bd83ee1ad95f123810eb3b116beb543db1960a";
    hash = "sha256-vQzYk5qejCBehpbxkMceOMsmeLyjnAstpezZw/ZR1jQ=";
  };
}

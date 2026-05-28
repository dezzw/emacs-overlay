{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "leetcode-emacs";
  ename = "leetcode";
  version = "1757296184";

  src = fetchFromGitHub {
    owner = "ginqi7";
    repo = "leetcode-emacs";
    rev = "9b0b008a349c376aad1b43fa4514ef8dc1c29a1b";
    hash = "sha256-VLVJJ7z/QG18htxbgTqj1ob1Ills7mseSv03zsRFlUc=";
  };
}

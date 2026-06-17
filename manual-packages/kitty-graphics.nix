{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "kitty-graphics";
  version = "1779376154";

  src = fetchFromGitHub {
    owner = "cashmeredev";
    repo = "kitty-graphics.el";
    rev = "a3158119297e1690f4578fe6bb3f5d9ddca813a4";
    hash = "sha256-Qa4v+nWpqJRJc5J57IeoSSh4kdXoktpT7RZkqD0HYtg=";
  };
}

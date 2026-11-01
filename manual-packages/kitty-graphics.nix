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
    rev = "727ed2ebd18a53c7eb394b376a24b4868d36c52b";
    hash = "sha256-mTYpV/FO1ANdyxQrlr4Q360cvS4s56Wfktm2Vq1fBmI=";
  };
}

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
    rev = "be88100e6bc715b0391aa60936609ba3b79a80c6";
    hash = "sha256-58ZLdwxamLTrt1BcjDuh8RJ7cqbzMitnmGZvCcX/wL8=";
  };
}

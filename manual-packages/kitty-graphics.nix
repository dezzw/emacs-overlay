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
    rev = "72191f6b96091ac8b31517f3b7475cd42d7d92b7";
    hash = "sha256-Q44pRyvJWZ9NGg2kcu1gwna2+nbrwZsqsBKvDO5ds04=";
  };
}

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
    rev = "586ff4b36f2ae44b12d35b0d4f256da23bc71f08";
    hash = "sha256-YqZ82zg303Ss2qlDTMM3xy8lG0BO8+/vdXMO6FxVX5E=";
  };
}

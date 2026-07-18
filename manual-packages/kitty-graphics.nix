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
    rev = "d9f0e93699683593308aff6def59767f991915e1";
    hash = "sha256-kw5zDhxkOpUkz60GESG5JIZyBKEOo5jl1yznMvaBm2A=";
  };
}

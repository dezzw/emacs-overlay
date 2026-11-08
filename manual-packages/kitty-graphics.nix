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
    rev = "7f3a3a187d01e464920248651bccd6094bdd8bf5";
    hash = "sha256-coi/HAZ6GGzf1W2vsmW/X5m3iSXylZ9FHD2zScdnwug=";
  };
}

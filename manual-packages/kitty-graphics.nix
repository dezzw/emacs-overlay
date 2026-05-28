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
    rev = "ddce1cc6cf69c187370ebb8dd7b146c1c0eafe88";
    hash = "sha256-uDENwNjeqSTzPebWgwHOtWBH06cedikUDvStNxBSV5E=";
  };
}

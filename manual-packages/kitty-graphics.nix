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
    rev = "6dcb5656e8ea2ed0a35aed08a33207fddac796c6";
    hash = "sha256-FslIkZtBwSi9ruTZWr+P5etwUUO+XgjYfDjbYMndWzc=";
  };
}

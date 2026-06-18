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
    rev = "056fb063f08310fd5021cf52bda04fb107bc8617";
    hash = "sha256-EO4xLxQckVGyDByMz8RHp1NuPsUdxyVdDxE+LzVz/RM=";
  };
}

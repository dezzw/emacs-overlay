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
    rev = "43840da38f76f603f8001038de0ebea89554435e";
    hash = "sha256-mtOroJua/M1m3jVHaxPriWkSxXfnIfBgJAkAWzzT8FA=";
  };
}

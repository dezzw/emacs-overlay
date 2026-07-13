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
    rev = "eaa8a217c94b71cfd07c3b14e35f929951ce8e68";
    hash = "sha256-/iWoLIQ/dFUugSTDo/3YQR9LJziRYJ8c6ewnYfHhc/A=";
  };
}

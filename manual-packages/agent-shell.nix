{
  lib,
  melpaBuild,
  fetchFromGitHub,
  shell-maker,
  acp,
}:

melpaBuild {
  pname = "agent-shell";
  version = "1778678932";

  src = fetchFromGitHub {
    owner = "dezzw";
    repo = "agent-shell";
    rev = "cb75b2ca78d2ca99d64db5719162695f38c67602";
    hash = "sha256-dw0mb0OmW2bVZreARZjV+Iy5xFN83lIf3xM7Pj4ccok=";
  };

  packageRequires = [
    shell-maker
    acp
  ];

  meta = with lib; {
    description = "Fork of agent-shell";
    homepage = "https://github.com/dezzw/agent-shell";
    license = licenses.gpl3Plus;
  };
}

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
    rev = "2c0afdd53cd55c189371fa5bad253565b5eca62b";
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

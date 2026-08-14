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
    rev = "ee3fa3ad40588745368b39a4ecaf7bd11bb9808c";
    hash = "sha256-amQAyo89x9dAzNynksDn6Ovp2zh/iwgP0EQcbtVvizo=";
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

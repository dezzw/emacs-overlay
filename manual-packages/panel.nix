{
  async,
  fetchFromGitHub,
  melpaBuild,
  nerd-icons,
  plz,
}:

melpaBuild {
  pname = "panel";
  version = "1775569210";

  src = fetchFromGitHub {
    owner = "LuciusChen";
    repo = "panel";
    rev = "8c9e9adb30206e59f165693885c56dc3a0b002ca";
    hash = "sha256-CezeGodMZG64FSNkC8ojfQA3/t/TcbSyR/oQNS0AqBE=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

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
    rev = "07a4cb052e06596d59543ee7f79bdc9371132ddd";
    hash = "sha256-gMISF3YDdxtAtAqjeh0GG4o9uGleBh7sSrgQ8fMK/NM=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

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
    rev = "0cc87915b9a61b8cf50c96e8d23d5605da60a1d3";
    hash = "sha256-1aTNDiHPZQgIS6JM2VQfXqKG7RU4q/RRNk0qSgWqIZU=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

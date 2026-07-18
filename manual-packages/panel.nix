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
    rev = "714756932dab1228cfa836c754b3c4e91ef5bb2d";
    hash = "sha256-Mm9ns4pKS+9tcot1jrV2WVcFO9iSjw+QQAWQGJt3waI=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

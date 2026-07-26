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
    rev = "e4ddbec00c3b973644c557a491a3f55356ab136c";
    hash = "sha256-J6YiSvWMBTP3X5sJZSU78WFKGO2QsW9OmSBtRS9kSgk=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

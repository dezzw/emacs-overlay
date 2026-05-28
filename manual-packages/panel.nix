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
    rev = "a19f230fc8b0fcdfe78337a23a3ef019bb874cae";
    hash = "sha256-eO5/G9B6wI06ZHMJoOHWZJkk9dr5kCJqxTmgDuP8ZCM=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

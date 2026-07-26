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
    rev = "aada318ea3d0e67e6f108143a29a0dc1bbd499f9";
    hash = "sha256-awsR93KWzS6g6TyPpMxBOXAPoA8rTKe6IgeNJEkrAVY=";
  };

  packageRequires = [
    async
    nerd-icons
    plz
  ];
}

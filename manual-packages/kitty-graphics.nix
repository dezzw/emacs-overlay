{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "kitty-graphics";
  version = "1779376154";

  src = fetchFromGitHub {
    owner = "cashmeredev";
    repo = "kitty-graphics.el";
    rev = "d9e1c25083d46968e11953cdc1d6294f2bfdfe58";
    hash = "sha256-ehQgeVLvHK075VIgrHnMSjkj4gRpcGCU9LJdXyE4pBY=";
  };
}

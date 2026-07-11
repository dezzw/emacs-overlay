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
    rev = "4c0ce4c229c6bc15e934d29c94bd4eccd2f92772";
    hash = "sha256-Tzmb1TLjqgxknhChCTyy0A9eUnonBKArxNeu4lu5JdM=";
  };
}

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
    rev = "60766623dd01d9b78aa506977083300d68de08ef";
    hash = "sha256-wctqnbM7vdQndXl6uArLdfMHYdU6tdN7MWp2Rxdz668=";
  };
}

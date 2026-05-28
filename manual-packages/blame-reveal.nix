{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "blame-reveal";
  version = "1777978026";

  src = fetchFromGitHub {
    owner = "LuciusChen";
    repo = "blame-reveal";
    rev = "815e0ae2fc2c9c7805a1249158fe55fd00e99808";
    hash = "sha256-wFeKgFqpgsJdNI7+UoKQ0cZNhijOcaws3LTHe9OIncY=";
  };
}

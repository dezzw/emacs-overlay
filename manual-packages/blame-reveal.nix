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
    rev = "7645a1f49c9b716ab5e0edaabe2f76b328af4ea0";
    hash = "sha256-DFfyd9zGs9FhEoER9j3Gcavut0Gp5omCUbIM9aIdwio=";
  };
}

{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "emt";
  version = "1735748514";

  src = fetchFromGitHub {
    owner = "roife";
    repo = "emt";
    rev = "a7f68cef086ce9b2f3477d572add60ba28e54b1d";
    hash = "sha256-nAVLHoPKP9nIO3ZgSPQ87lh6UTzph4+JPqEbogXrRVQ=";
  };
}

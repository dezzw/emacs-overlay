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
    rev = "b7f46fae280dba3269e9110f3cb61d2dd4fa67cc";
    hash = "sha256-ewHZxytYw2NPkhF4zdl/fRSiBSN2jZAkdM4Ykb1x90Q=";
  };
}

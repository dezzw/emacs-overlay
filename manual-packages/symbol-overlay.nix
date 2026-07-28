{
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "symbol-overlay";
  version = "1734330146";

  src = fetchFromGitHub {
    owner = "roife";
    repo = "symbol-overlay";
    rev = "14e4022aeb6ad8a5bdd66ab9535c0815b8c54afe";
    hash = "sha256-NCIWVb83p3ZShe8SMVWMcPQRxBOVoD6JpACC+CNBbuA=";
  };
}

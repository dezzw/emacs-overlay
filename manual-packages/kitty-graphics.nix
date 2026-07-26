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
    rev = "13666d4eb2ef4eeed24697c0326368eff3667dce";
    hash = "sha256-3P4NQJpC0R1DRQ1oV1vbN1VD+Tb0wcMIvN1yA/pa/Rc=";
  };
}

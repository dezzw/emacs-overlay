{
  fetchgit,
  melpaBuild,
}:

# update-skip: setup.el is hosted on Codeberg, not GitHub.

melpaBuild {
  pname = "setup";
  version = "1761595148";

  src = fetchgit {
    url = "https://codeberg.org/pkal/setup.el.git";
    rev = "de9b86c6f29cf9888e911924ffc4ce47312320c3";
    hash = "sha256-lLeKsLFf1+Bjk6ETq+0Nncw6DPOVxE49cAexdLAr/5U=";
  };
}

{
  lib,
  melpaBuild,
  fetchFromGitHub,
}:

melpaBuild {
  pname = "region-pin";
  version = "20260817";

  src = fetchFromGitHub {
    owner = "vmargb";
    repo = "region-pin";
    rev = "75df76c0e0ab9a55b38363f16d27ae56d36c00f7";
    hash = "sha256-YEiifoRr27twod2CdJHJLUyvYiQlq2ppOn4faqnbcxQ=";
  };

  meta = with lib; {
    description = "Pins any highlighted block of code into a floating preview in your window.";
    homepage = "https://github.com/vmargb/region-pin";
    license = licenses.gpl3Plus;
  };
}

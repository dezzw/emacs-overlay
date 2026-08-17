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
    rev = "a6fc98ee2bf75b34c473cf843f45c837f1cfaebb";
    hash = "sha256-qZKLiAgcqVdatZ50k8XXTARdh35PZw6cFKR855vnyjA=";
  };

  meta = with lib; {
    description = "Pins any highlighted block of code into a floating preview in your window.";
    homepage = "https://github.com/vmargb/region-pin";
    license = licenses.gpl3Plus;
  };
}

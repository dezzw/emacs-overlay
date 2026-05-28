{
  fetchFromGitHub,
  melpaBuild,
  nerd-icons,
}:

melpaBuild {
  pname = "miniline";
  version = "1769526729";

  src = fetchFromGitHub {
    owner = "dezzw";
    repo = "miniline.el";
    rev = "f56b21a754215167eea98474003feb3637cfc4c9";
    hash = "sha256-rylYBmnXdW72ZcV9Gbr5dIfuNfd/MR/7KZWquV+gmWI=";
  };

  packageRequires = [ nerd-icons ];
}

{
  f,
  fetchFromGitHub,
  melpaBuild,
}:

melpaBuild {
  pname = "image-slicing";
  version = "1776417006";

  src = fetchFromGitHub {
    owner = "ginqi7";
    repo = "image-slicing";
    rev = "477ac4c71e88d8f3dd3c6554933b18a0e9d3aea7";
    hash = "sha256-Lyj9MuHdRXg65eowCWDLj4mDxQNzk0B7CUSCl2p2AxY=";
  };

  packageRequires = [ f ];
}

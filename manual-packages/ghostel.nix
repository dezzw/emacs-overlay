{
  lib,
  fetchFromGitHub,
  melpaBuild,
  nix-update-script,
  stdenv,
  zig_0_15,
  emacs,
}:

let
  zig = zig_0_15;

  pname = "ghostel";
  version = "0-unstable-2026-05-25";

  src = fetchFromGitHub {
    owner = "dakra";
    repo = "ghostel";
    rev = "4c11d7051bf5811f4c8ed490e8e23398a43d8b7e";
    hash = "sha256-xWJ0LiiNcPelap/8WzRiJg8fAGT7VDZOfglrNeQ/Ovc=";
  };

  module = stdenv.mkDerivation (finalAttrs: {
    inherit pname version src;

    deps = zig.fetchDeps {
      inherit (finalAttrs) pname version src;
      fetchAll = true;
      hash = "sha256-ghN/UMACgkFQQEr4nH5gbbJbt/+2bz6tL2bJpbw9mGE=";
    };

    nativeBuildInputs = [
      zig
    ];

    env.EMACS_INCLUDE_DIR = "${emacs}/include";

    postConfigure = ''
      cp -rLT ${finalAttrs.deps} "$ZIG_GLOBAL_CACHE_DIR/p"
      chmod -R u+w "$ZIG_GLOBAL_CACHE_DIR/p"
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib
      cp zig-out/lib/libghostel-module${stdenv.hostPlatform.extensions.sharedLibrary} $out/lib/

      runHook postInstall
    '';
  });

  libExt = stdenv.hostPlatform.extensions.sharedLibrary;
in

melpaBuild {
  inherit pname version src;

  files = ''
    (:defaults "etc" "ghostel-module${libExt}")
  '';

  preBuild = ''
    install ${module}/lib/libghostel-module${libExt} ghostel-module${libExt}
  '';

  passthru = {
    updateScript = nix-update-script {
      extraArgs = [ "--version=branch=main" ];
    };

    inherit module;
  };

  meta = {
    description = "Terminal emulator powered by libghostty";
    homepage = "https://github.com/dakra/ghostel";
    license = lib.licenses.gpl3Plus;
    maintainers = [ ];
  };
}

{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, cargo
, rustc
, pkg-config
, desktop-file-utils
, appstream-glib
, makeWrapper
, meson
, ninja
, libadwaita
, gtk4
}:
let

  src = fetchFromGitHub {
    owner = "AaronErhardt";
    repo = "tuxedo-rs";
    rev = "f356f05d8fe40de3c5121c11a5a9b37047501440";
    hash = "sha256-RVauCQn8T6q+c7z0nYGtxdV/89IWAGSsqHL2xm0OTgI=";
  };

  sourceRoot = "source/tailor_gui";

  name = "tailor_gui";

  # NOTE: OfBorg doesn't like importTOML from a subdirectory
  version = "0.2.1";
in
stdenv.mkDerivation {

  inherit src sourceRoot name version;

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src sourceRoot;
    name = "${name}-${version}";
    hash = "sha256-mJuCG6mPoMWinUgur+VFSx8D2WhR9KzEJsjxpzz94T8=";
  };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    pkg-config
    desktop-file-utils
    appstream-glib
    makeWrapper
  ];

  buildInputs = [
    cargo
    rustc
    meson
    ninja
    libadwaita
    gtk4
  ];

  postFixup = ''
    wrapProgram $out/bin/tailor_gui --set XDG_DATA_DIRS "$out/share/gsettings-schemas/tailor_gui"
  '';

  meta = with lib; {
    description = "Rust GUI for interacting with hardware from TUXEDO Computers";
    longDescription = ''
      An alternative to the TUXEDO Control Center (https://www.tuxedocomputers.com/en/TUXEDO-Control-Center.tuxedo),
      written in Rust.
    '';
    homepage = "https://github.com/AaronErhardt/tuxedo-rs";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ mrcjkb ];
  };
}

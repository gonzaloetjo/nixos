{ lib
, fetchFromGitHub
, rustPlatform
}:
let

  src = fetchFromGitHub {
    owner = "AaronErhardt";
    repo = "tuxedo-rs";
    rev = "f356f05d8fe40de3c5121c11a5a9b37047501440";
    hash = "sha256-RVauCQn8T6q+c7z0nYGtxdV/89IWAGSsqHL2xm0OTgI=";
  };

in
rustPlatform.buildRustPackage {

  pname = "tuxedo-rs";

  inherit src;

  # NOTE: OfBorg doesn't like importTOML from a subdirectory
  version = "0.2.1";

  # Some of the tests are impure and rely on files in /etc/tailord
  doCheck = false;

  cargoHash = "sha256-cmsHigW19LKT9Z0AVhmXKyB+Rzr++rG37UhkYxGaKTk=";

  postInstall = ''
    mkdir -p $out/share/dbus-1/system.d
    cp ${src}/tailord/com.tux.Tailor.conf $out/share/dbus-1/system.d
  '';

  meta = with lib; {
    description = "Rust utilities for interacting with hardware from TUXEDO Computers";
    longDescription = ''
      An alternative to the TUXEDO Control Center daemon.

      Contains the following binaries:
      - tailord: Daemon handling fan, keyboard and general HW support for Tuxedo laptops
      - tailor: CLI
    '';
    homepage = "https://github.com/AaronErhardt/tuxedo-rs";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ mrcjkb ];
  };
}


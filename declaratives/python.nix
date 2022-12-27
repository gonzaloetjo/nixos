let
  mach-nix = import (builtins.fetchGit {
    url = "https://github.com/DavHau/mach-nix";
    ref = "refs/tags/3.4.0";
  }) {
      inherit pkgs;
      python = "python39";
  };
in
mach-nix.mkPython {
  requirements = ''
    pillow
    numpy
    requests
  '';
}
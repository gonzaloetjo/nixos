let
  nixpkgs-version = "21.11";
  pkgs =
    import (fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-${nixpkgs-version}.tar.gz") {};
  ## https://github.com/DavHau/mach-nix
  ## https://github.com/DavHau/mach-nix/issues/414
  mach-nix =
    import (builtins.fetchGit {
      url = "https://github.com/DavHau/mach-nix";
      ref = "refs/tags/3.4.0";
    }) {
      inherit pkgs;
      python = "python39";
    };

  python39Modules = mach-nix.mkPython {
    requirements = ''
      pillow
      numpy
      requests
      python-vagrant
      openshift
      netaddr
      jmespath
      molecule==3.5.2
      molecule-vagrant
      molecule-docker
      pylint
    '';
  };
in
  # TODO
  pkgs.mkShell {
    name = "ansible-molecule";
    buildInputs = [
      python39Modules
      pkgs.ansible
      pkgs.ansible-lint
    ];
  }
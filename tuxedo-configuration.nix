{ config, pkgs, ... }: {
  imports =
    [
    	./machines/gonzalo-tuxedo.nix
      ./cachix.nix
    ];

}


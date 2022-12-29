{ config, pkgs, ... }: {
  imports =
    [
    	./machines/gonzalo-dell.nix
      ./cachix.nix
    ];

}


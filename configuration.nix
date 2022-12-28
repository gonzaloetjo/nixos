{ config, pkgs, inputs, options, ... }: {
  imports =
    [
    	./machines/gonzalo-dell.nix
      ./cachix.nix
    ];

}


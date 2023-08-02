{ config, pkgs, ... }: {

  nixpkgs.config = {
    permittedInsecurePackages = [
      "openssl-1.1.1u"
    ];
  };
  
  imports =
    [
    	./machines/gonzalo-tuxedo.nix
      ./cachix.nix
      # ./modules/tuxedo-rs.nix
    ];

}


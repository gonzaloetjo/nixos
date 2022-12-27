{ config, pkgs, ... }:
# Need to fix. Unused for now.
let
  unstable = import
    (fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  nixpkgs.config =
    {
      packageOverrides = pkgs: {
        virtualbox = unstable.virtualbox.override {
          inherit (config.boot) kernel;
        };
      };

      # Make sure that the Virtualbox Oracle Extensions are installed.
      virtualbox = {
        enableExtensionPack = true;
      };

      # Make sure that unfree packages are available.
      allowUnfree = true;
    };

  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "17.09";
}

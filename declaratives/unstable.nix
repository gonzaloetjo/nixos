{ config, pkgs, latest, ... }:
# how-to-add-nixos-unstable-channel-declaratively-in-configuration-nix
# https://stackoverflow.com/questions/48831392/how-to-add-nixos-unstable-channel-declaratively-in-configuration-nix
let
  unstableTarball =
    fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "0jzy84zgjgblp2ph3kb2kj5z2k05vagn6ms5m80pjr2g27m6hr37";
    };
in
{
  # Don't think this part is needed if it's already done on gonzalo.dell.nix
  # imports =
  #   [ # Include the results of the hardware scan.
  #     /etc/nixos/machines/gonzalo-dell-hardware.nix
  #   ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
}

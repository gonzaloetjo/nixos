{ config, pkgs, ...}:

let
  baseconfig = { allowUnfree = true; };
  # unstable = import <nixos-unstable> { config = baseconfig; }; # needs to add nixos-unstable to channels: 'sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable'
in {
  environment.systemPackages = with pkgs; [
    unstable.docker
    unstable.docker-compose
    unstable.jetbrains.pycharm-professional
    unstable.jetbrains.webstorm
    unstable.jetbrains.datagrip
    unstable.jetbrains.idea-ultimate
    unstable.jetbrains.idea-community
    unstable.jenkins
    unstable.eclipses.eclipse-sdk
    unstable.eclipses.eclipse-java
    unstable.teams
    # unstable.edgedb
  ];
}



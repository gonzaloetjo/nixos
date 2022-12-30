{ config, pkgs, inputs, unstable, ...}: 

  { 
    environment.systemPackages = [
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
      # latest.legacyPackages.${pkgs.system}.docker
      # unstable.edgedb
    ];
  }



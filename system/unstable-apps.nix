{ config, pkgs, inputs, unstable, ...}: 

  { 
    environment.systemPackages = [
      unstable.docker
      unstable.docker-compose
      unstable.eclipses.eclipse-sdk
      unstable.eclipses.eclipse-java
      unstable.jetbrains.pycharm-professional
      unstable.jetbrains.webstorm
      unstable.jetbrains.datagrip
      unstable.jetbrains.idea-ultimate
      unstable.jetbrains.idea-community
      unstable.jenkins
      unstable.keybase-gui
      unstable.keybase
      # unstable.teams

      # latest.legacyPackages.${pkgs.system}.docker
      # unstable.edgedb
    ];
    services.kbfs.enable = true;
    services.keybase.enable = true;
  }
  



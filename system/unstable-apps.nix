{ config, pkgs, inputs, ...}: 

  { 
    environment.systemPackages = [
      inputs.latest.legacyPackages.${pkgs.system}.docker
      inputs.latest.legacyPackages.${pkgs.system}.docker-compose
      # inputs.latest.legacyPackages.${pkgs.system}.jetbrains.pycharm-professional
      # inputs.latest.legacyPackages.${pkgs.system}.jetbrains.webstorm
      # inputs.latest.legacyPackages.${pkgs.system}.jetbrains.datagrip
      # inputs.latest.legacyPackages.${pkgs.system}.jetbrains.idea-ultimate
      # inputs.latest.legacyPackages.${pkgs.system}.jetbrains.idea-community
      # inputs.latest.legacyPackages.${pkgs.system}.jenkins
      inputs.latest.legacyPackages.${pkgs.system}.eclipses.eclipse-sdk
      inputs.latest.legacyPackages.${pkgs.system}.eclipses.eclipse-java
      inputs.latest.legacyPackages.${pkgs.system}.teams
      # unstable.edgedb
    ];
  }



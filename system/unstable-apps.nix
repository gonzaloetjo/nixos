{ config, pkgs, latest, ...}: {

  environment.systemPackages = [
    inputs.latest.packages${pkgs.system}.docker
    inputs.latest.packages${pkgs.system}.docker-compose
    inputs.latest.packages${pkgs.system}.jetbrains.pycharm-professional
    inputs.latest.packages${pkgs.system}.jetbrains.webstorm
    inputs.latest.packages${pkgs.system}.jetbrains.datagrip
    inputs.latest.packages${pkgs.system}.jetbrains.idea-ultimate
    inputs.latest.packages${pkgs.system}.jetbrains.idea-community
    inputs.latest.packages${pkgs.system}.jenkins
    inputs.latest.packages${pkgs.system}.eclipses.eclipse-sdk
    inputs.latest.packages${pkgs.system}.eclipses.eclipse-java
    inputs.latest.packages${pkgs.system}.teams
    # unstable.edgedb
  ];
}


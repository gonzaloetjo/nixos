{ config, pkgs, latest...}: {

  environment.systemPackages = with latest; [
    latest.docker
    latest.docker-compose
    latest.jetbrains.pycharm-professional
    latest.jetbrains.webstorm
    latest.jetbrains.datagrip
    latest.jetbrains.idea-ultimate
    latest.jetbrains.idea-community
    latest.jenkins
    latest.eclipses.eclipse-sdk
    latest.eclipses.eclipse-java
    latest.teams
    # unstable.edgedb
  ];
}


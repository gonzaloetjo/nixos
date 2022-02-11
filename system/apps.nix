{pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    atom
    curl
    keybase-gui
    file                         # View information about a file
    firefox
    git
    # gnome.dconf-editor
    # gnome3.gnome-tweaks
    openssl
    # sublime-merge
    # sublime4
    vim
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.kbfs.enable = true;
  services.keybase.enable = true;

  # Prevent futur errors from Gnome, see https://nixos.wiki/wiki/GNOME#Running_GNOME_programs_outside_of_GNOME
  programs.dconf.enable = true;


}

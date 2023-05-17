{pkgs, inputs, ...}: {

  environment.systemPackages = with pkgs; [
    ansible
    # atom
    brave
    chromium
    curl
    direnv
    exa
    file                   # View information about a file
    flatpak
    firefox
    git
    github-desktop
    gnome3.gnome-tweaks
    gnumake
    graphviz
    gradle
    jdk8
    jq
    keybase-gui
    kompose
    kubernetes
    kubectl
    krb5
    libreoffice
    neovim
    nodejs
    # nodenv
    ntp
    maven
    marktext
    minikube
    obs-studio
    openssl
    openvpn
    redis
    slack
    sqlite
    stdenv
    spark3
    teamviewer
    thunderbird
    tilix
    unzip
    vagrant
    vim
    vlc
    wget
    whatsapp-for-linux
    yarn
    # postman
    # python39
    # python310
    # python310.venv
    # python310.pip
    zoom
    zip

    # Ex unstable ones:
    # docker
    # docker-compose
    # # jetbrains.pycharm-professional
    # # jetbrains.webstorm
    # # jetbrains.datagrip
    # # jetbrains.idea-ultimate
    # # jetbrains.idea-community
    # # jenkins
    # eclipses.eclipse-sdk
    # eclipses.eclipse-java
    # teams
    # gnome.dconf-editor
    # sublime-merge
    # sublime4  

    # Devenv
    inputs.devenv.packages.x86_64-linux.devenv
  ];

  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.kbfs.enable = true;
  services.keybase.enable = true;
  services.teamviewer.enable = true;

  # Kubernetes
  # This is required so that pod can reach the API server (running on port 6443 by default)
  # networking.firewall.allowedTCPPorts = [ 6443 ];
  # services.k3s.enable = true;
  # services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
  #   # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];
  # environment.systemPackages = [ pkgs.k3s ];



  # Openvpn configuration
  # services.openvpn.servers = {
    #officeVPN  = { config = '' config /etc/nixos/openvpn/officeVPN.conf ''; };
   # homeVPN    = { config = '' config /root/nixos/openvpn/homeVPN.conf ''; };
   # serverVPN  = { config = '' config /root/nixos/openvpn/serverVPN.conf ''; };
  #};

  # Enable VirtualBox and networking setup
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "getse" ];

  # VirtualBox - Carlos Based
  # virtualisation.libvirtd.enable = true;

  # virtualisation.virtualbox.host = {
  #   enable = true; # Enable VirtualBox
  #   enableExtensionPack = true; # Enable the VirtualBox Extension Pack
  #   addNetworkInterface = true; # Add a network interface to the host
  # };

  # networking.interfaces.vboxnet0.ipv4.addresses = lib.mkOverride 10 [{
  #   address = "10.10.10.1";
  #   prefixLength = 24;
  # }];

  # environment.etc."vbox/networks.conf".text = ''
  #   * 10.10.10.0/24 192.168.56.0/21
  #   * 2001::/64
  # '';
  # users.extraGroups.vboxusers.members = [ "getse" ];

  # Adding extra host names
  # networking.extraHosts =
	# ''
	#   10.10.10.11 master01.nikita.local
	#   10.10.10.16 worker01.nikita.local
	#   10.10.10.17 worker02.nikita.local
	#   10.10.10.18 worker03.nikita.local
	# '';

  # Prevent futur errors from Gnome, see https://nixos.wiki/wiki/GNOME#Running_GNOME_programs_outside_of_GNOME
  programs.dconf.enable = true;
}

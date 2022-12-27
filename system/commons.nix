{pkgs, ...}:{

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # useful for certain programs
    nixpkgs.config.allowUnfree = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    # sudo for the user
    security.sudo.extraRules = [{
        groups = [ "wheel" ];
        commands = [{
            command = "ALL" ;
            options= [ "SETENV" "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }];
    }];

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking.useDHCP = false;
    networking.interfaces.wlp59s0.useDHCP = true;
    networking.networkmanager.enable = true;
    # users.users.getse.extraGroups = [ "networkmanager" ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


    # Enable the X11 windowing system.
    services.xserver.enable = true;


    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = false; # Needed to make teams work on Nixos. More info here:https://discourse.nixos.org/t/configuring-x11-for-gnome/19113/2
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = [
        pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour  pkgs.gnome.geary
    ];


    # Configure keymap in X11
    services.xserver.layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";

    # Enable CUPS to print documents.
    # services.printing.enable = true;
    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
        General = {
            Enable = "Source,Sink,Media,Socket";
        };
    };

    systemd.services.bluetooth.serviceConfig.ExecStart = [
        ""
        "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=sap"  # Prevents a "permission-denied"-error in the bluetooth-service-startup
    ];

    # disable, apparently it's not required besides for some poorly written tests: 
    # https://www.reddit.com/r/NixOS/comments/vdz86j/how_to_remove_boot_dependency_on_network_for_a/
    systemd.services.NetworkManager-wait-online.enable = false; # Slows down boot

    #ZFS support: https://nixos.wiki/wiki/K3s 
    # K3s's builtin containerd does not support the zfs 
    # snapshotter. However it is possible to configure it 
    # to use an external containerd: 
    # Enabling K3s kubernetes:
    #virtualisation.containerd.enable = true;
    # TODO describe how to enable zfs snapshotter in containerd
    #services.k3s.extraFlags = toString [
    #"--container-runtime-endpoint unix:///run/containerd/containerd.sock"
    #];

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;
    


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

}


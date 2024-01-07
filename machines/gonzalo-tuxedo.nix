# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./gonzalo-tuxedo-hardware.nix
      # ../cachix.nix
      # <home-manager/nixos>
      #../declaratives/unstable.nix
      #../declaratives/virtualbox.nix
      ../system/commons.nix
      ../system/apps.nix
      ../system/unstable-apps.nix
      # ../system/fonts.nix
      ../modules/virtualization.nix

      #../modules/python.nix
      #../declaratives/python.nix
    ];

  networking = {
    hostName = "gonzalo-tuxedo";
  };

  # Testing Flakes
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.useDHCP = false;
  # networking.interfaces.wlo1.useDHCP = true;
  # networking.interfaces.wlp0s20f3.useDHCP = true;
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking = {
    networkmanager.plugins = with pkgs; [ gnome3.networkmanager-openvpn ];
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.wlo1.useDHCP = true;
    # interfaces.wlp0s20f3.useDHCP = true;
    networkmanager = {
      enable = true;
      dns = "none"; # To avoid network manager override my nameservers 
    };
    nameservers = [ "10.0.0.5" "1.1.1.1" ]; # DNS server
    dhcpcd.extraConfig = "nohook resolv.conf";
  };


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    # layout = "us";
    libinput.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Solution said to fix sleep issue in nixos discord. Didn't work.
    # monitorSection = ''
    #   Option "DPMS" "false"
    # '';
  };

  # Add the nvidia-offload script to system packages
  # environment.systemPackages = [
  #   (pkgs.writeShellScriptBin "nvidia-offload" ''
  #     export __NV_PRIME_RENDER_OFFLOAD=1
  #     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #     export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #     export __VK_LAYER_NV_optimus=NVIDIA_only
  #     exec "$@"
  #   '')
  # ];

  # Nvidia
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      sync.enable = true;
      # offload = {
      #   enable = true;
      #   # enableOffloadCmd = true; # commented out as I'm not offloading https://nixos.wiki/wiki/Nvidia#Fix_graphical_corruption_on_suspend.2Fresume
      # };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    # powerManagement = {
    #   enable = true;
    #   finegrained = true;
    # };
    nvidiaPersistenced = false;
    modesetting.enable = true;
  };

  # hardware.tuxedo-rs.enable = true;
  # hardware.tuxedo-rs.tailor_gui.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}


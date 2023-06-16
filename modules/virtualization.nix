{ config, pkgs, lib, ... }: {

  #virtualisation.lxd.enable = true; # Enable LXD virtualisation
  virtualisation.docker.enable = true; # Enable Docker virtualisation
  # Comment out or remove VirtualBox related configuration
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.host = { 
  #   enable = true; 
  #   enableExtensionPack = true; 
  #   addNetworkInterface = true; 
  # };
  # users.extraGroups.vboxusers.members = [ "getse" ]; 
  # environment.etc."vbox/networks.conf".text = ''
  #   * 10.10.10.0/24 192.168.0.0/16
  #   * 2001::/64
  # '';

  # Enable libvirt
  virtualisation.libvirtd = {
    enable = true;
  };

  # Enable nested virtualization
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  # Add your user to the necessary groups for libvirt
  users.users.getse = {
    extraGroups = [
      "docker" 
      "qemu-libvirtd" 
      "libvirtd" 
      "video" 
      "audio" 
      "disk" 
      "networkmanager"
    ];
  };

  # Extra host names for TDP configuration
  networking.extraHosts = ''
  192.168.56.14 worker-01.tdp worker-01
  192.168.56.15 worker-02.tdp worker-02
  192.168.56.16 worker-03.tdp worker-03
  192.168.56.11 master-01.tdp master-01
  192.168.56.12 master-02.tdp master-02
  192.168.56.13 master-03.tdp master-03
  192.168.56.10 edge-01.tdp edge-01
  '';

  # Enable NFS server
  services.nfs.server.enable = true; 

  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';
}

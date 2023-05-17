
{ config, pkgs, lib, ... }: {


  #virtualisation.lxd.enable = true; # Enable LXD virtualisation
  virtualisation.docker.enable = true; # Enable Docker virtualisation
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.host = { # VirtualBox host configuration
    enable = true; #  Enable VirtualBox host
    enableExtensionPack = true; # Enable VirtualBox Extension Pack
    addNetworkInterface = true; # Add VirtualBox network interface
  };
  # networking.interfaces.vboxnet0.ipv4.addresses = lib.mkOverride 10 [{ # VirtualBox host IP address
  #   address = "10.10.10.1";
  #   prefixLength = 24;
  # }];
  users.extraGroups.vboxusers.members = [ "getse" ]; # Add user to group
  environment.etc."vbox/networks.conf".text = ''
    * 10.10.10.0/24 192.168.0.0/16
    * 2001::/64
  ''; # VirtualBox host network configuration: Added 192.168.32.0/24 for 

  # https://discourse.nixos.org/t/getting-firefox-to-work-with-p11-kit-to-use-system-wide-installed-certificates/3175
  # security.pki.certificates = [ " ...certificates... " ];
  
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

  # # Adding extra host names for Cloudera configuration
  # networking.extraHosts = 
	# ''
  #   192.168.56.10 worker-01.tdp
  #   192.168.56.11 worker-02.tdp
  #   192.168.56.12 worker-03.tdp
  #   192.168.56.13 master-01.tdp
  #   192.168.56.14 master-02.tdp
  #   192.168.56.15 master-03.tdp
  #   192.168.56.16 edge-01.tdp
	# '';

  
  # https://nixos.wiki/wiki/Vagrant
  services.nfs.server.enable = true; # Enable NFS server
  networking.firewall.extraCommands = ''
    ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

	# Using Vagrant with libvirt
	# https://discourse.nixos.org/t/set-up-vagrant-with-libvirt-qemu-kvm-on-nixos/14653

	# If you would like to enable nested virtualization for your guests to run KVM hypervisors inside them, you should enable it as follows: boot.extraModprobeConfig, for example:
	boot.extraModprobeConfig = "options kvm_intel nested=1";

	virtualisation.libvirtd = {
		enable = true;
	};
  
	# This backend works and is enabled by default. To use virt-manager with your user, locally and via SSH, it will be necessary to add yourself to the libvirtd group. 
  users.users.getse = {
    extraGroups = [
			"docker" 
			"qemu-libvirtd" "libvirtd" "video" "audio" "disk" "networkmanager"
		]; #"lxd"
  };
}

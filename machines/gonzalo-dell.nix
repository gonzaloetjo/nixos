{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./gonzalo-dell-hardware.nix
      ../cachix.nix
      # <home-manager/nixos>
      #../declaratives/unstable.nix
      #../declaratives/virtualbox.nix
      ../system/commons.nix
      ../system/apps.nix
      #../system/unstable-apps.nix
      # ../system/fonts.nix
      ../modules/virtualization.nix

      #../modules/python.nix
      #../declaratives/python.nix
    ];

  networking = {
    hostName = "gonzalo-dell"; # Define your hostname.  ("") to allow the DHCP server to provide the host name. 
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.getse = {
    isNormalUser = true;
    initialPassword = "secret";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # home-manager.users.getse = { pkgs, config, ... }: {

  #   imports = [
  #     ../home/discord.nix
  #     ../home/git.nix
  #     ../home/vscode.nix
  #     ../home/zsh.nix
  #   ];
  #   # You can use direnv to automatically load the environment when changing into a project folder.
  #   # See https://github.com/nix-community/nix-direnv
  #   # programs.direnv.enable = true;
  #   # programs.direnv.nix-direnv.enable = true;
  #   # Also call `echo "use nix" >> .envrc && direnv allow`
  # };
  # Enable auto upgrades
  # system.autoUpgrade.enable = true;

  # Testing Flakes
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

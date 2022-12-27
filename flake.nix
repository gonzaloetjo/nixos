{
  description = "Trying out flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, nixpkgs-unstable, home-manager, ...}:
    let
      user = "getse";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        "gonzalo-dell" = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${user}" = {
                imports = [
                  ../home/discord.nix
                  ../home/git.nix
                  ../home/vscode.nix
                  ../home/zsh.nix
                ];
              };
            }
          ];
        };
      };
    };
}

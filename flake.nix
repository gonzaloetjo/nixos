{
  description = "Trying out flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    latest.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv/v0.6.2";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, devenv, latest, ... }@inputs:
    let
      user = "getse";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
        };

      allowUnfree = { nixpkgs.config.allowUnfree = true; };  

      unstable = import latest {
        inherit system;
        config.allowUnfree = true; 
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        "gonzalo-tuxedo" = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs unstable; };
          modules = [
            {
              environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
              nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
              nix.registry.nixpkgs.flake = nixpkgs;
              nix.registry.latest.flake = latest;
            }
            allowUnfree
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${user}" = {
                  imports = [
                    ./home/discord.nix
                    ./home/git.nix
                    ./home/vscode.nix
                    ./home/zsh.nix
                  ];
                  home.stateVersion = "23.05";
                };
              };
            }
          ];
        };
        "gonzalo-dell" = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs unstable;};
          modules = [ 
            {
            environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
            nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.registry.latest.flake = latest;
            }
            allowUnfree
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${user}" = {
                  imports = [
                    ./home/discord.nix
                    ./home/git.nix
                    ./home/vscode.nix
                    ./home/zsh.nix
                  ];
                  home.stateVersion = "22.11";
                };
              };
            }
          ];
        };
      };
    };
}

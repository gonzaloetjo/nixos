{
  description = "Trying out flake";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    latest.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.latest.follows = "latest";
    };
  };

  outputs = inputs @ { self, stable, latest, home-manager, ... }:
    let
      # stateVersion = "22.05";
      user = "getse";
      system = "x86_64-linux";
      pkgs = import [ 
        latest {
          inherit system;
          config.allowUnfree = true;
        }
        # latest {
        #   inherit system;
        #   config.allowUnfree = true;
        # }
      ];
      lib = latest.lib;

    in {
      nixosConfigurations = {
        "gonzalo-dell" = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user inputs;};
          modules = [ 
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${user}" = {
                imports = [
                  ./home/discord.nix
                  ./home/git.nix
                  ./home/vscode.nix
                  ./home/zsh.nix
                ];
                home.stateVersion = "22.05";
              };
            }
          ];
        };
      };
    };
}

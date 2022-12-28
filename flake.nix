{
  description = "Trying out flake";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    latest.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.stable.follows = "stable";
    };
  };

  outputs = { self, stable, latest, home-manager, ... }@inputs:
    let
      # stateVersion = "22.05";
      user = "getse";
      system = "x86_64-linux";
      pkgs = import stable {
          inherit system;
          config.allowUnfree = true;
        };

      lib = stable.lib;

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
                home.stateVersion = "21.11";
              };
            }
          ];
        };
      };
    };
}

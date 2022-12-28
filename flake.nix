{
  description = "Trying out flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # latest.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv/v0.5";

    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, devenv, ... }@inputs:
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
          specialArgs = { inherit user inputs;};
          modules = [ 
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

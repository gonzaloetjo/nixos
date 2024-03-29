{
  description = "Trying out flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    latest.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv/v0.6.3";
    tuxedo-nixos.url = "github:blitz/tuxedo-nixos";

    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, devenv, latest, tuxedo-nixos, ... }@inputs:
    let
      user = "getse";
      system = "x86_64-linux";

      # tuxedo-rs-overlay = self: super: {
      #   tuxedo-rs = super.callPackage ./pkgs/tuxedo-rs/default.nix {};
      #   tailor_gui = super.callPackage ./pkgs/tailor_gui/default.nix {};
      # };

      # pkgs = import nixpkgs {
      #     inherit system;
      #     overlays = [ tuxedo-rs-overlay ];
      # };

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
              # nixpkgs.overlays = [ tuxedo-rs-overlay ];
            }
            # Tuxedo control center
            tuxedo-nixos.nixosModules.default
            {
              hardware.tuxedo-control-center.enable = true;
              # Specify the package
              hardware.tuxedo-control-center.package = tuxedo-nixos.packages.x86_64-linux.default;
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
                  home.stateVersion = "23.11";
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

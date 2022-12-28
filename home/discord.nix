{pkgs, ...}: {
    home.packages = with pkgs; [ discord ];
    nixpkgs.overlays = [
     (self: super: {
       discord = super.discord.overrideAttrs (
         _: { src = builtins.fetchTarball {
                url = "https://discord.com/api/download?platform=linux&format=tar.gz";
                sha256 = "9as9d8f7g6s8a8d9d9d8v8s8d8e8d8889s8d7ew7a7v8asdjn387";
              };
            }
       );
     })
  ];
}

{pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    programs.vscode = {
      enable = true;
      # package = pkgs.vscodium;    # You can skip this if you want to use the unfree version
      extensions = with pkgs.vscode-extensions; [
        graphql.vscode-graphql
        mskelton.one-dark-theme
        yzhang.markdown-all-in-one
      ];
    };
}

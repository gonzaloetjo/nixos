{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    initExtra = ''
    #eval "$(direnv hook zsh)"
    [ -f ~/.secrets ] && . ~/.secrets
    # Preserve the current directory of the shell across terminals
    # Note, tried `programs.zsh.vteIntegration` without sucess
    source ${pkgs.gnome3.vte}/etc/profile.d/vte.sh
    '';

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        { name = "b4b4r07/enhancd"; } # Simple plugin installation
      ];
    };
  };
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" "kubectl"];
    # theme = "powerlevel10k";
  };
  programs.zsh.plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
      name = "powerlevel10k-config";
      src = pkgs.lib.cleanSource ./p10k-config;
      file = "p10k.zsh";
    }
  ];
}
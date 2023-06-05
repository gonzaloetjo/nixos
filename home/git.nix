{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName  = "gonzaloetjo";
    userEmail = "gonzaloetjo@gmail.com";
    aliases = {
      lgb = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches";
    };
    extraConfig = {
      core = {
        editor = "/run/current-system/sw/bin/subl -w";
      };
      init = {
        defaultBranch = "master";
      };
      pull = {
        rebase = true;
      };
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
}

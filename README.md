#  General Home-manager configuration

```
flake.nix
 ├─ ./configuration.nix
 │   └─ machines/gonzalo-dell.nix
 │      └─ machines/gonzalo-dell-hardware.nix  
 │      └─ modules/
 │      │    ├─ virtualization.nix
 │      │    └─ virtualbox.nix #not used
 │      └─ system/
 │      │    ├─ apps.nix # Stable Applications installed
 │      │    ├─ unstable-apps.nix # Unstable Applications installed
 │      │    └─ commons.nix 
 │      └─ declaratives/
 │      │    ├─ unstable.nix # to make unstable available
 │      │    └─ python.nix # not used
 │ 
 └─ ./home
     ├─ zsh.nix
     ├─ discord.nix
     ├─ vscode.nix
     └─ git.nix
```

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

Tools to transition to flake:

- https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake/
- https://www.youtube.com/watch?v=AGVXJ-TIv3Y
- 

#  General Home-manager configuration


# Gonzalo NixOS configuration


## Usage

Install NixOS, clone the repository inside /etc/nixos, create a `configuration.nix` file pointing to the target machine configuration.


```bash
MACHINE='gonzalo-dell'
cat <<NIX >/etc/nixos/configuration.nix

{ config, pkgs, options, ... }: {
  imports =
    [
    	"/etc/nixos/machines/${MACHINE}.nix"
    ];
}
NIX
```

Run `nixos-rebuild` to apply changes.

```bash
sudo nixos-rebuild switch --flake .#{hostname}
````

## Tools to transition to flake:

- https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake/
- https://www.youtube.com/watch?v=AGVXJ-TIv3Y
  

## Architecture

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

## Issues:

Currently can't solve having some legacy Packages installed through different channels. 

- Option 1: Solve this are either overlays like before (without taking certain advantages of flakes). This might help: https://github.com/nix-community/home-manager/issues/1538
- Option 2: Find a way to adapt the following instructions: https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake/

At the moment coundn't find a way to bypass the issue of telling the file unstable-apps.nix that it is allowed to evaluate and build unfree packages.



```bash
setfacl -Rm u:[user]:rwx /etc/nixos/
code /etc/nixos
```

## Examples

* https://github.com/michaelpj/nixos-config
* https://github.com/JorelAli/nixos/blob/master/configuration.nix
* https://github.com/NobbZ/nixos-config
* https://github.com/MatthiasBenaets/

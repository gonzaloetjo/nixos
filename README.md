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
```

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
 ├─ ./cachix.nix
 ├─ ./cachix/
 │   └─getseadaltas.nix
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

## Tutorials

- How to manage channels and paths in flakes: https://ayats.org/blog/channels-to-flakes
  - Example: https://github.com/viperML/nix-common/blob/master/modules/nixos/channels-to-flakes.nix
  - Example: https://github.com/viperML/nix-common/blob/master/modules/home-manager/channels-to-flakes.nix
- How to manage multiple inputs in flakes: https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake/
- How to manage multiple inputs in flakes with overlays: https://github.com/nix-community/home-manager/issues/1538
- How to start and understand flakes: https://www.youtube.com/watch?v=AGVXJ-TIv3Y
- Flakes first steps: https://blog.kubukoz.com/flakes-first-steps/
- Nix shells and nix Develop article: https://blog.ysndr.de/posts/guides/2021-12-01-nix-shells/
- Nix intro: https://ayats.org/blog/nix-intro
- Nix installation community: https://nix-community.github.io/home-manager/index.html#ch-nix-flakes
- nixpkgs vs import inputs: https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462


## Examples

* https://github.com/michaelpj/nixos-config
* https://github.com/JorelAli/nixos/blob/master/configuration.nix
* https://github.com/NobbZ/nixos-config
* https://github.com/MatthiasBenaets/
* https://github.com/viperML


## TODO

[ ] Move registry, nixPaths, homemanager to different modules. Can try out flakes.parts as well.
[ ] Make cachix work
[ ] Move pkgs configuration to modules, as it's evil to pass it to nixosSystem:
  https://discourse.nixos.org/t/allowunfree-predicate-does-not-apply-to-self-packages/21734/37




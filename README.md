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
sudo nixos-rebuild switch
````

## Architecture

The repository is organized to be able to add different sections.  
  
Applications are installed in either `/system/apps` through nix configuration, or in `/home/{app-name}` through home-manager.

For convenience, user gains permissions access to the repo using Linux ACL. The location of NixOS remains the same, ownership and permission are unchanged.


```bash
setfacl -Rm u:[user]:rwx /etc/nixos/
code /etc/nixos
```

## Examples

* https://github.com/michaelpj/nixos-config
* https://github.com/JorelAli/nixos/blob/master/configuration.nix

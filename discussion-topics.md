# Remaining Topics, discussions discord/matrix/discourse
## Nix Path
```
I have one question regarding that. When I tried it as described in that section, nix complained about config being undefined, so I had to change it to a function:
modules = [
    ({config, ...}: {
      xdg.configFile."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      home.sessionVariables.NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
      nix.registry.nixpkgs.flake = nixpkgs;
    })
    ./home.nix
];
```

- Do it in an other module file

```
I tried that, with {config, nixpkgs, ...}: { ... } as function definition for the module, but how do I pass nixpkgs into the module? My flake outputs look like this atm (channels.nix being the new module for pinning the channels):
outputs = { nixpkgs, home-manager, ... }:
let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in {
homeConfigurations.lanice = home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ./channels.nix
    ./home.nix
  ];
};
};
```

```
Use one of the 4 well known ways to pass the inputs into the modules
Function over inputs returning a module, specialArgs, _module.args, overlay

```


```
Oookay, took me a bit to figure it out. For anyone else stumbling over this, I changed the channels.nix signature to {nixpkgs}: {config, ...}: { ... } , and called that function (that returns a module) in the let ... in of the flake outputs to have it available as module below. Thanks for the pointer!
one of the 4 well known ways
Yeah, this is probably all pretty basic stuff... I'm just learning it all piece by piece as I go.  Just yesterday took some time to read a bit into the nix language... Clearly not deep enough 😅

```


## Impurity:

- https://github.com/NixOS/nix/pull/6227
- https://github.com/NixOS/nix/issues/520
- Channels are impure. Flakes fix that. That's their whole purpose. Most other benefits are just a followup on that
  - I tell you to run nix-instantiate --eval --expr 'with import <nixpkgs> {}; lib.version', you will see something else than some one else. Thats impure, as all of a sudden your machines state becomes part of the output
  - flakes dont neccesarily stop mismatches htey just allow you to ensure you can always get the same state you had before
  - Because with a flake, the commit used is part of the command to run
  - like how when clisp broke a few days ago, i reverted my flake so i had a working system and figured out what broke then updated it
  - But I can do the same with the normal Rollback, can’t I
  - if you mean a full disk rollback i guess, but changing the state of the package repo is wayyy easier. you can, but there is nothing keeping track of that
  - With flakes the history of my git repo doesn't only tell about the revert, but also abbout the reason.
  - Channels do not tell about either
  - flakes is a version control for your packages. 
  - Flakes do not care for package versions. The operate on inputs.
- https://nixos.org/manual/nixos/stable/index.html#sec-getting-sources this one?
NobbZ — 12/10/2022 12:47 AM
There are 3 manuals, should be more though:

1. nix manual covers the CLI and language, as well as "what is a derivation"
2. nixpkgs covers the package repository, and how to use it and what functions, bulders, helpers it defines, how to work in each sub ecosystem, etc
3 . NixOS, which explains how to configure and maintain a nixos system and how to write and use modules.

- Callback: https://summer.nixos.org/blog/callpackage-a-tool-for-the-lazy/


## Pkgs

Comment:
```
you need an evaluated copy of nixpkgs... in other words, a pkgs value. the nixpkgs flake provides one under legacyPackages.${system}, but you can instead import the default.nix at the root of the flake's directory just like you did pre-flakes with import <nixpkgs> {}
[1:32 AM]
import nixpkgs works like import <nixpkgs> did because the flake input argument has an outPath attribute, which gets used for automatic string conversion. It points to the root directory of the flake in question in the nix store, so you're importing the default.nix in that directory, just like in the NIX_PATH lookup case

```
 https://discourse.nixos.org/t/allowunfree-predicate-does-not-apply-to-self-packages/21734/37

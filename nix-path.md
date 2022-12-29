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

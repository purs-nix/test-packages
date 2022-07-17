 npmlock2nix:
{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "1.0.0";
    src = "is-odd/src";

    foreign.IsOdd.node_modules =
      npmlock2nix.node_modules { src = ./.; } + /node_modules;
  }

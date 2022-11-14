{ get-flake, is-odd, system }:
{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "1.0.0";
    dependencies = [ is-odd ];
    src = "is-even/src";
    pursuit.repo = "https://github.com/purs-nix/test-packages.git";
  }

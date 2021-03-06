{ get-flake, system }:
{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "1.0.0";
    dependencies = [ (get-flake ../is-odd).packages.${system}.default ];
    src = "is-even/src";
    pursuit.repo = "https://github.com/purs-nix/test-packages.git";
  }

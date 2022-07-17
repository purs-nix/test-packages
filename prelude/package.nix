{ get-flake, pkgs }:
{ build, ps-pkgs, ... }:
  with ps-pkgs;
  { version = "override-test";
    dependencies = [(get-flake ../is-even).packages.${pkgs.system}.default ];
    src = "prelude/src";
  }

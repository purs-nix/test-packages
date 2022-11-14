{ get-flake, is-even, pkgs }:
{ build, ps-pkgs, ... }:
  with ps-pkgs;
  { version = "override-test";
    dependencies = [ is-even ];
    src = "prelude/src";
  }

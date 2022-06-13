{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "override-test";
    src = "prelude/src";
  }

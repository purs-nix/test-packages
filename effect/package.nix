{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "override-test";
    dependencies = [ prelude ];
    src = "effect/src";
  }

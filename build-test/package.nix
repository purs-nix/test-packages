{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "1.0.0";
    dependencies = [ "prelude" "console" "effect" ];
    src = "build-test/src";
    pursuit.repo = "https://github.com/purs-nix/test-packages.git";
  }

{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "override-test";
    dependencies = [ "prelude" ];

    install =
      ''
      mkdir $out
      cd effect
      cp -r src/. $out
      cp -r other-src/. $out
      '';

    pursuit.repo = "https://github.com/purs-nix/test-packages.git";
  }

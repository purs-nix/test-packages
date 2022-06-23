{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "override-test";
    dependencies = [ prelude ];

    install =
      ''
      mkdir $out
      cd effect
      cp -r src/. $out
      cp -r other-src/. $out
      '';
  }

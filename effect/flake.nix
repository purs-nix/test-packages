{ inputs =
    { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      purs-nix.url = "github:ursi/purs-nix/new-api";
      utils.url = "github:numtide/flake-utils";
    };

  outputs = { nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem
      (system:
         let
           pkgs = nixpkgs.legacyPackages.${system};
           purs-nix = inputs.purs-nix { inherit system; };
           package = import ./package.nix purs-nix;

           ps =
             purs-nix.purs
               { inherit (package) dependencies;
                 dir = ./.;
                 srcs = [ "src" "other-src" ];
               };
         in
         { devShell =
             pkgs.mkShell
               { packages =
                   with pkgs;
                   [ nodejs
                     nodePackages.bower
                     nodePackages.pulp
                     (ps.command {})
                     purs-nix.esbuild
                     purs-nix.purescript
                   ];
               };
         }
      );
}

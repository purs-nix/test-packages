{ inputs =
    { get-flake.url = "github:ursi/get-flake";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      purs-nix.url = "github:ursi/purs-nix/new-api";
      utils.url = "github:numtide/flake-utils";
    };

  outputs = { get-flake, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem
      (system:
         let
           pkgs = nixpkgs.legacyPackages.${system};
           is-odd = (get-flake ../is-odd).packages.${system}.default;
           purs-nix = inputs.purs-nix { inherit system; };

           package =
             import ./package.nix
               { inherit get-flake is-odd system; }
               purs-nix;

           ps = purs-nix.purs { inherit (package) dependencies; };
         in
         { packages.default =
             purs-nix.build
               { name = "purs-nix.is-even";
                 src.path = ../.;
                 info = package;
               };

           devShell =
             pkgs.mkShell
               { packages =
                   with pkgs;
                   [ nodejs
                     nodePackages.bower
                     nodePackages.pulp

                     (ps.command
                        { bundle =
                            { esbuild.platform = "node";
                              main = false;
                              module = "IsEven";
                            };
                        }
                     )

                     purs-nix.esbuild
                     purs-nix.purescript
                   ];
               };
         }
      );
}

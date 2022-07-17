{ inputs =
    { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      npmlock2nix =
        { flake = false;
          url = "github:nix-community/npmlock2nix";
        };

      purs-nix.url = "github:ursi/purs-nix/ps-0.15";
      utils.url = "github:numtide/flake-utils";
    };

  outputs = { nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem
      (system:
         let
           p = pkgs;
           pkgs = nixpkgs.legacyPackages.${system};
           npmlock2nix = p.callPackages inputs.npmlock2nix {};
           purs-nix = inputs.purs-nix { inherit system; };
           package = import ./package.nix npmlock2nix purs-nix;
           ps = purs-nix.purs { inherit (package) foreign; };
         in
         { packages.default =
             purs-nix.build
               { name = "purs-nix.is-odd";
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
                              module = "IsOdd";
                            };
                        }
                     )

                     purs-nix.esbuild
                     purs-nix.purescript
                     # purs-nix.purescript-language-server
                   ];
               };
         }
      );
}

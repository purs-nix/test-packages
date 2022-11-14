{ inputs =
    { get-flake.url = "github:ursi/get-flake";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      ps-tools.follows = "purs-nix/ps-tools";
      purs-nix.url = "github:ursi/purs-nix/new-api";
      utils.url = "github:numtide/flake-utils";
    };

  outputs = { get-flake, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem
      (system:
         let
           is-even = (get-flake ../is-even).packages.${pkgs.system}.default;
           pkgs = nixpkgs.legacyPackages.${system};
           ps-tools = inputs.ps-tools.legacyPackages.${system};

           purs-nix =
             inputs.purs-nix
               { inherit system;
                 overlays = [ is-even.overlay ];
               };

           package = import ./package.nix { inherit get-flake is-even pkgs; } purs-nix;
           ps = purs-nix.purs { inherit (package) dependencies; };
         in
         { packages.default =
             purs-nix.build
               { name = "purs-nix.prelude";
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
                     (ps.command {})
                     purs-nix.esbuild
                     purs-nix.purescript
                     ps-tools.for-0_15.purescript-language-server
                   ];
               };
         }
      );
}

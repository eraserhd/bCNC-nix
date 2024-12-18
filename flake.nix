{
  description = "GRBL CNC command sender, autoleveler, and g-code editor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        bCNC = pkgs.callPackage ./derivation.nix {};
      in {
        packages = {
          default = bCNC;
          inherit bCNC;
        };
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
          ];
        };
    })) // {
      overlays.default = final: prev: {
        bCNC = prev.callPackage ./derivation.nix {};
      };
    };
}

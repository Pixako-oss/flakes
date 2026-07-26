{
  description = "python3 + nodejs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python39;
        node = pkgs.nodejs_20;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python
            python.pkgs.pip
            node
          ];

          shellHook = ''
            if [ ! -d .venv ]; then
              python -m venv .venv
            fi
            source .venv/bin/activate
          '';
        };

        packages.default = python;
      });
}
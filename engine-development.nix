{
  description = "Engine Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          ruby
          bundler
          gcc
          gnumake
          pkg-config
          cmake
          ninja

          vulkan-headers
          vulkan-loader

          libX11
          libXext
          libXrandr
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
          libXfixes
          libxcb
          libxkbcommon
          libglvnd
          alsa-lib

          wayland
          wayland-protocols
          shaderc
          shader-slang
        ];

          shellHook = ''
            echo "Engine Development Environment"
            echo "Ruby:    $(ruby --version)"
            echo "Bundler: $(bundle --version)"
            echo "CMake:   $(cmake --version | head -n 1)"
            echo "Ninja:   $(ninja --version)"
          '';
        };
      });
}

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              bundler
              ruby
              libffi
              libxml2
              libxslt
              pkg-config
              zlib
            ];

            BUNDLE_PATH = ".bundle/nix";
            BUNDLE_APP_CONFIG = ".bundle/nix-config";
          };
        });
    };
}

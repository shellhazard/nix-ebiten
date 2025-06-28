{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildDeps = with pkgs; [
          gcc
          libGL

          xorg.libX11
          xorg.libXcursor
          xorg.libXext
          xorg.libXi
          xorg.libXinerama
          xorg.libXrandr
          xorg.libXxf86vm
        ];

        attrs = {
          pname = "ebitengine-hello";
          version = self.rev or "unknown";
          src = self;

          vendorHash = "sha256-KMQcCUXlDRfmY+RUDRBxECTe1O7b6UeoLybnhdGLYPI=";

          meta = {
            description = "An example Ebitengine program.";
            mainProgram = "hello";
          };

          nativeBuildInputs = with pkgs; [
            makeWrapper
          ];
          buildInputs = buildDeps;
        };
      in
      {
        packages.default = pkgs.buildGoModule attrs // {
          postInstall = with pkgs; ''
            wrapProgram $out/bin/hello \
              --set LD_LIBRARY_PATH '${lib.getLib libGL}/lib:${lib.getLib libGL}/lib:$LD_LIBRARY_PATH'
          '';
        };
        packages.nixgl = pkgs.buildGoModule attrs;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            gopls
            gotools
          ];

          nativeBuildInputs = with pkgs; [
            go
          ];
          buildInputs = buildDeps;

          shellHook = with pkgs; ''
            export LD_LIBRARY_PATH=${lib.getLib libGL}/lib:${lib.getLib libGL}/lib:$LD_LIBRARY_PATH
          '';
        };
      }
    );
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    mydevenvs.url = "github:yvaniak/mydevenvs";
    mydevenvs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.mydevenvs.flakeModule
        inputs.mydevenvs.devenv
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        { pkgs, config, ... }:
        {
          packages.default = pkgs.callPackage ./default.nix { };

          devenv.shells.default = {
            mydevenvs = {
              nix = {
                enable = true;
                flake.enable = true;
                check.enable = true;
                check.package = config.packages.default;
              };
              ts = {
                enable = true;
                biome.enable = true;
                script-lint.enable = false;
              };
              tools.just = {
                enable = true;
                pre-commit.enable = true;
                check.enable = true;
              };
            };

            enterShell = ''
              echo "shell for example project"
            '';
          };
        };
      flake = {
      };
    };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenvs.url = "github:yvaniak/devenvs";
    devenvs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenvs.flakeModule
        inputs.devenvs.devenv
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem = _: {
        devenv.shells.default = {
          devenvs = {
            nix = {
              enable = true;
              flake.enable = true;
            };
            ts.enable = true;
            ts.biome.enable = true;
            tools.just.enable = true;
            tools.just.pre-commit.enable = true;
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

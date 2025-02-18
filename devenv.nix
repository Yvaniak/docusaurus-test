{
  inputs,
  ...
}:

{
  imports = [
    inputs.devenvs.devenvModules.default
  ];
  ts = {
    enable = true;
    biome.enable = true;
  };
  nix.enable = true;
}

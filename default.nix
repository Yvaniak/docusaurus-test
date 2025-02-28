{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
}:
pkgs.buildNpmPackage {
  pname = "docusaurus-test";
  inherit (lib.trivial.importJSON ./package.json) version;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./src
      ./blog
      ./docs
      ./static
      ./package.json
      ./package-lock.json
      ./docusaurus.config.ts
      ./tsconfig.json
      ./sidebars.ts
    ];
  };

  npmDeps = pkgs.importNpmLock {
    npmRoot = ./.;
  };

  inherit (pkgs.importNpmLock) npmConfigHook;

  npmFlags = [ "--legacy-peer-deps" ];

  nativeInstallCheckInputs = [
    pkgs.versionCheckHook
    pkgs.curl
    pkgs.killall
  ];
  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck

      npm run serve&
      sleep 5
      curl -s localhost:3000 | grep "Dinosaurs are cool"
      killall "npm run serve"

    runHook postInstallCheck
  '';
}

{
  moduleWithSystem,
  inputs,
  ...
}: {
  flake.nixosModules.omnisearch = moduleWithSystem ({...}: let
    modules = [
      inputs.omnisearch.nixosModules.default
    ];
  in {
    imports = modules;
    services.omnisearch.enable = true;
  });
}

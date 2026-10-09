{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.youtube = moduleWithSystem ({...}: let
    modules = with self.nixosModules; [
      obs-studio
      wshowkeys
      woomer
      mumble
    ];
  in {
    imports = modules;
  });
}

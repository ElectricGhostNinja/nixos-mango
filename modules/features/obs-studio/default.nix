{moduleWithSystem, ...}: {
  flake.nixosModules.obs-studio = moduleWithSystem ({...}: {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  });
}

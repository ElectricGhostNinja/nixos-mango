{moduleWithSystem, ...}: {
  flake.nixosModules.weylus = moduleWithSystem ({inputs', ...}: {
    programs.weylus = {
      enable = true;
      package = inputs'.weylus.packages.default;
      users = ["user01"];
    };
  });
}

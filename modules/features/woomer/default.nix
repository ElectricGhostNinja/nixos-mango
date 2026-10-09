{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.woomer = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      woomer
    ];
  });
  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages.woomer = inputs.wrappers.lib.wrapPackage ({...}: {
      inherit pkgs;
      package = inputs'.woomer.packages.default;
      flags = {
        "--monitor" = "DP-1";
        "--output" = "DP-1";
        "--radius" = "2";
      };
    });
  };
}

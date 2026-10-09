{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.bottles = moduleWithSystem ({pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      (bottles.override {
        removeWarningPopup = true;
      })
      wineWow64Packages.stable
      winetricks
      wine
      wine64
      freetype
    ];
  });
}

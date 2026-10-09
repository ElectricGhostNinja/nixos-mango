{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.intelDrivers = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      mesa
      vulkan-tools
    ];
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver
        libva-vdpau-driver
      ];
    };
  };
}

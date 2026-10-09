{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.bootloader = {
    pkgs,
    lib,
    ...
  }: {
    boot = {
      loader = {
        timeout = 2;
        efi = {
          canTouchEfiVariables = true;
        };
        grub = {
          efiSupport = true;
          device = "nodev";
          theme = pkgs.catppuccin-grub;
        };
      };
      plymouth = {
        enable = true;
        theme = "catppuccin-mocha";
        themePackages = with pkgs; [
          # By default we would install all themes
          (catppuccin-plymouth.override {
            variant = "mocha";
          })
        ];
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}

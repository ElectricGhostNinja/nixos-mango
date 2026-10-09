{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.HACKSTATION = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      desktop
      hackstationConfiguration
      amdDrivers
      youtube
      development
      bottles
      gaming
      davinci
      sddm-autologin
      nix-ld

			i3
    ];
  };
}

{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.mobile02 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      desktop
      mobile02Configuration
      intelDrivers
			development
			upower
    ];
  };
}

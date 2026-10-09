{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mobile02Configuration = {...}: {
    networking = {
      hostName = "mobile02";
    };
  };
}

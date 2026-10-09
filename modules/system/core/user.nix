{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.user = {
    pkgs,
    lib,
    ...
  }: let
    modules = with self.nixosModules; [
      zsh
    ];
  in {
    imports = modules;
    users.users.user01 = {
      isNormalUser = true;
      initialPassword = "qwer";
      shell = pkgs.zsh;
      description = "user01";
      extraGroups = [
        "root"
        "wheel"
      ];
    };
  };
}

{
inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.gotify-desktop = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      gotify-desktop
    ];
  });
  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages = {
      gotify-desktop = let
        # Requires gpg keyring cert in order to get api key
        config-file = pkgs.writeText "config.toml" ''
          	[gotify]
          	url = "wss://ntfy.voidarc.co.uk:443"
          		token = { command = "${pkgs.gnupg}/bin/gpg --quiet --batch --decrypt ${./gotify-key.secret}" }
          [notification]
          	min_priority = 1
        '';
      in
        inputs.wrappers.lib.wrapPackage ({...}: {
          inherit pkgs;
          package = inputs'.gotify-desktop.packages.default;
          flags = {
            "-c" = config-file;
          };
        });
    };
  };
}

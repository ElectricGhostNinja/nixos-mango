{
  description = "Master flake for Voidarc nix config";

  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Apps
    nvim.url = "git+https://git.voidarc.co.uk/voidarc/nvim";
    hyprland = {
      url = "git+https://git.voidarc.co.uk/voidarc/hypr";
    };
    otter-launcher = {
      url = "github:kuokuo123/otter-launcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gotify-desktop = {
      url = "github:voidarclabs/gotify-desktop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sls-steam.url = "github:AceSLS/SLSsteam";
    davinci.url = "git+https://git.voidarc.co.uk/voidarc/nixos.davinci";
    quickshell = {
      url = "git+https://git.voidarc.co.uk/voidarc/quickshell";
      flake = false;
    };
    omnisearch = {
      url = "git+https://git.voidarc.co.uk/voidarc/omnisearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    woomer = {
      url = "github:coffeeispower/woomer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wshowkeys.url = "github:voidarclabs/wshowkeys";
    weylus = {
      url = "github:voidarclabs/WeylusCommunityEdition";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake parts
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}

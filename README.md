# The Void
*An opinionated dendritic nix configuration*

## The Concept

I have been trying to get consistent, across device experiences from the second that I
started using linux. I tried my best with arch, but I foolishly believed that just remembering
what packages I installed would be enough. Then I started managing my dotfiles with GNU stow,
but that only allowed for a single host per repo. I moved over to doot, and simultaneously nixos.

I believed a dotfiles manager was my endgame. The final evolution, but it was far from ideal. I had to
manage a mess of dotfiles, submodules and nix packages that were completely uncoupled from the apps that
used them. Hyprland just assumed that I had all of my apps installed, assumed that otter-launcher's
config existed. Just by forgetting an app or a toml file, I had the potential to brick my entire setup.

This is no longer the case.

The solution is similar to that of safely typed languages, like rust. Rust, instead of having optional parameters
like typescript, requires that a variable be passed to a function, regardless of whether it contains anything.
This leads to what is essentially a fixed dependancy tree, where there are no points of failiure, only allowing
for logic errors and such. The same methodology can be applied to nix, using flake parts and wrapper scripts.

Instead of defining the packages beside the app, and its config, you can use the config to define the required binaries.
By wrapping a config that contains a nix variable, ie a binary, that binary is intrinsically linked to that config,
and will therefore always be installed. No more dependancy issues, and because the configs are defined within nix too, no
more potential for missing config files. Dotfile managers are no more, long live dotfile managers. Any app with a `--config`
flag can now be fully versioned and self contained within one repo, config and all, accessible on any machine with nix.

One command for a truly reproducible, fully contained, configured system. This is the endgame.

## Usage

Usage is similar to any other flake, with everything in the module directory being an output.

The folder structure is simply defined:
```
modules/
|- features/ - all available apps, every subfolder contains a seperate wrapped binary
|- attrs/ - attributes composed of other modules, no new features defined
|- system/ - basic system modules, no binaries. Should not be run standalone. (Think network and audio config)
|- hosts/ - available presets for machines. Output names match subfolder names, eg #HACKSTATION, and hostnames
```

### Nixos Configurations

Due to the host module referencing `/etc/nixos/hardware-configuration.nix`, so that it is seperated from the repo,
all rebuild commands will need `--impure`, unless you copy your configuration into the repo.

HACKSTATION is the heavier system, mobile02 is minimal and has no specialist hyprland config.

It is recommended to clone the repo beforehand, but the system can be built directly from remote
```bash
# Local Clone, . is the directory containing flake.nix
sudo nixos-rebuild switch --impure --flake .

# Build from remote
sudo nixos-rebuild switch --impure --flake "git+https://git.voidarc.co.uk/voidarc/nixos.git?ref=dendritic"
```
Both of these commands can be appended with a desired hostname in order to build that configuration.
```bash
# Example of building mobile02 from a local repo
sudo nixos-rebuild switch --impure --flake .#mobile02
```
There is no default output, so if the current hostname doesn't match a host, you will get an error.
Building this config should be non destructive to any existing dotfiles, but will remove all users (not home directories)
from the system other than `user01`, who's default password is `qwer`.

### Binaries

Any binary can be run with the same base command (will change when merged to main)
```bash
nix run "git+https://git.voidarc.co.uk/voidarc/nixos.git?ref=dendritic#appname"
```
`Appname` can be substituted for the name of any folder in the `modules/features` dir, ie `kitty` or `otter-launcher`
# nixos-mango

# nixos-mango

> An opinionated, dendritic NixOS configuration — one flake for every machine.

A fully reproducible, self-contained system: packages, applications and their
configuration are declared together and wrapped into binaries, so an app and its
config can never drift apart. Clone the repo, pick a host, rebuild, done.

> **Fork notice:** this repository is a fork of
> [voidarc/nixos](https://git.voidarc.co.uk/voidarc/nixos/src/branch/dendritic)
> (branch `dendritic`).

## The Concept

Years of chasing a consistent cross-device experience makes one thing clear:
a dotfiles manager is not the endgame.

- **Arch** assumed I'd remember every package I ever installed. I didn't.
- **GNU Stow** assumed one host per repo. It doesn't scale.
- **doot** kept dotfiles, submodules and packages completely uncoupled from the
  apps that used them. One missing binary or `.toml` could brick the setup.

The fix borrows from safely typed languages like Rust. Instead of optional,
implicit dependencies, everything is made explicit — a fixed dependency tree
with no failure points, only logic errors.

Applied to Nix, a config's required binaries are **defined by the config
itself**. Wrap a config together with the binary it needs and the two become
intrinsically linked: it is always installed, always present, always versioned
in one repo. Dotfile managers are dead. Long live dotfile managers.

Any app with a `--config` flag can now be fully versioned, self-contained and
available on any machine with Nix — from a single flake.

## Repository Layout

```
modules/
├── features/   # Every available app — each subfolder is a self-contained wrapped binary
├── attrs/      # Composed bundles of other modules; define no new features
├── system/     # Base system modules (network, audio, drivers…); no binaries, not standalone
└── hosts/      # Machine presets. Output names match the subfolder, e.g. #HACKSTATION
```

The flake auto-imports everything under `modules/` via `import-tree`.

## Requirements

- A NixOS installation with flakes enabled
- `git` (the `hardware-configuration.nix` is read from `/etc/nixos`, **outside**
  the repo, which is why rebuilds use `--impure`)

## Usage

```bash
# Clone
git clone https://github.com/ElectricGhostNinja/nixos-mango.git
cd nixos-mango

# Build the host matching the current hostname
sudo nixos-rebuild switch --impure --flake .

# Or build from remote
sudo nixos-rebuild switch --impure \
  --flake "git+https://github.com/ElectricGhostNinja/nixos-mango.git?ref=main"

# Explicitly select a host
sudo nixos-rebuild switch --impure --flake .#mobile02
```

There is **no default output**: if the current hostname doesn't match a host,
the build errors out. Prefer cloning locally unless you want a one-shot remote
build.

> **Warning:** this configuration is non-destructive to existing dotfiles, but
> it removes all users other than `user01` from the system (home directories are
> left intact). The default `user01` password is `qwer`.

## Hosts

| Host | Description |
| --- | --- |
| `HACKSTATION` | Heavier desktop: AMD drivers, gaming, Davinci Resolve, i3. |
| `mobile02` | Minimal, no specialist Hyprland config. |

## Running Binaries

Every app in `modules/features` is exposed as a runnable output:

```bash
nix run ".#kitty"
nix run ".#otter-launcher"
```

Or from remote:

```bash
nix run "git+https://github.com/ElectricGhostNinja/nixos-mango.git?ref=main#kitty"
```

Substitute any folder name under `modules/features`.

## Secrets

Sensitive values are handled with [`git-secret`](https://git-secret.io/)
(`.gitsecret/`) and age/GPG-encrypted `*.secret` files, e.g.
`modules/features/gotify-desktop/gotify-key.secret`. Decrypt before building
hosts that depend on them.

## License

Personal configuration — no warranty, use at your own risk.

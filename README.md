# 0x63616c/homebrew-tap

Homebrew casks and formulae for apps by [@0x63616c](https://github.com/0x63616c).

## Quantum

[Quantum](https://quantum.worldwidewebb.co/) is a 3D voxel editor for people and agents
(macOS 13 or later, Apple silicon).

```sh
brew install --cask 0x63616c/tap/quantum
```

This installs the signed, notarized `Quantum.dmg` from
[GitHub Releases](https://github.com/0x63616c/quantum/releases) into `/Applications`
and links the bundled `quantum-mcp` server onto your `PATH`.

**Updates.** Quantum updates itself through its built-in updater (Sparkle), so the
cask is marked `auto_updates true`. `brew upgrade` skips it; use
`brew upgrade --cask --greedy quantum` if you want Homebrew to reinstall the latest
release anyway. Homebrew's recorded version may lag behind the running app after an
in-app update; that is harmless.

**Uninstall.**

```sh
brew uninstall --cask quantum         # removes the app and the quantum-mcp link
brew uninstall --cask --zap quantum   # also removes settings, caches and preferences
```

`--zap` never touches your projects in `~/Documents/Quantum`.

The cask is updated automatically by Quantum's release workflow after each release.

## Callkeep

[Callkeep](https://github.com/0x63616c/callkeep) is a native macOS recorder for your
microphone and computer audio, with optional iCloud Drive storage. Requires macOS
15 or later; supports Apple silicon and Intel.

```sh
brew install --cask 0x63616c/tap/callkeep
```

Or run `brew tap 0x63616c/tap` once, then `brew install --cask callkeep`.
Update with `brew upgrade --cask callkeep`.

Releases from Build 4 (1.0.4) onward are signed with Developer ID and notarized by Apple.
Earlier releases were ad-hoc signed and may require approval in
**System Settings → Privacy & Security** before opening the app.
The cask is updated automatically after successful builds on Callkeep’s `main`.
`brew uninstall --cask callkeep` removes the app. `--zap` also removes preferences,
but preserves recordings on this Mac and in iCloud Drive.

## Homelab

Homelab is a terminal client for reviewed remote macOS setup and inspection
(Apple silicon). Its source repository is private: installation requires access
to `0x63616c/homelab` and an existing authenticated GitHub CLI credential helper.

```sh
brew install 0x63616c/tap/homelab
homelab
```

The formula builds only the operator command from a pinned source commit using
Rust and its committed dependency lockfile. It does not install Nix, activate a
host, or register background services. No private source or release assets are
published in this tap. The source is downloaded to Homebrew's local build/cache
locations for the authorized user.

For private Git downloads, follow Homebrew's
[authentication guidance](https://docs.brew.sh/FAQ#how-do-i-authenticate-private-git-source-downloads).
The formula contains no tokens and does not change your authentication setup.

Update with `brew upgrade homelab` after a reviewed formula update. Uninstall
with `brew uninstall homelab`; your local connection profiles are retained.

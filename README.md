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

Releases are ad-hoc signed and not notarized. macOS may require approval in
**System Settings → Privacy & Security** before opening the app.
The cask is updated automatically after successful builds on Callkeep’s `main`.
`brew uninstall --cask callkeep` removes the app. `--zap` also removes preferences,
but preserves recordings on this Mac and in iCloud Drive.

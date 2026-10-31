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

## runner-pool

[runner-pool](https://github.com/0x63616c/runner-pool) turns an Apple silicon Mac into an
isolated, reversible CI runner pool (Tart macOS VMs and a Lima Linux VM under a
dedicated non-admin user). The CLI installs as both `runner-pool` and `rp`.

```sh
brew install 0x63616c/tap/runner-pool
sudo rp setup --dry-run   # preview
sudo rp setup             # set up this Mac (asks once)
rp status
```

The source repository is private for now, so Homebrew downloads the release with your
GitHub login: run `gh auth login` first, or set `HOMEBREW_GITHUB_API_TOKEN`.

Upgrade with `brew upgrade runner-pool`. LaunchDaemons point at Homebrew's stable
`opt/runner-pool` path, so they pick up the new binary on their next run. Maintainers
bump the formula with `script/bump-runner-pool vX.Y.Z`.

# 42BV Homebrew Tap

Homebrew Formulae maintained by 42BV.

## Install Normatik CLI

```bash
brew tap 42bv/tap
brew install 42bv/tap/normatik
```

The `normatik` Formula is the installation route. It uses a
versioned, checksummed public source release and, when a matching bottle is
available, Homebrew downloads that prebuilt package instead of building Go
source locally.

## Maintainer release flow

1. Publish an immutable public CLI source tag.
2. Open a pull request that updates `Formula/normatik.rb` to its source URL and
   SHA-256.
3. Let `brew test-bot` validate the Formula and create a bottle artifact on
   Apple Silicon macOS 26.
4. Leave that Formula pull request open and, after reviewing its green checks,
   run the `brew pr-pull` workflow with its number and reviewed head SHA. It
   publishes bottles as public assets on the tap's GitHub Release and commits
   the generated `bottle do` checksums to `main`.

The public release assets are the customer download path; a matching
`brew install 42bv/tap/normatik` pours a bottle without installing Go, Xcode or
other build tools. The Formula's public source archive remains the reproducible
fallback for platforms without a matching bottle.

## Support

Report issues with the Normatik CLI through the normal Normatik support channel.
This repository contains Homebrew packaging metadata only.

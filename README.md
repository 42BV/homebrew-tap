# 42BV Homebrew Tap

Homebrew Formulae and legacy Casks maintained by 42BV.

## Install Normatik CLI

```bash
brew tap 42bv/tap
brew install 42bv/tap/normatik
```

The `normatik` Formula is the preferred installation route. It uses a
versioned, checksummed public source release and, when a matching bottle is
available, Homebrew downloads that prebuilt package instead of building Go
source locally.

`Casks/normatik.rb` is the previous prebuilt-binary proof of concept. It stays
in place temporarily while the Formula bottle route is verified, but should not
be used for new installations.

## Maintainer release flow

1. Publish an immutable public CLI source tag.
2. Open a pull request that updates `Formula/normatik.rb` to its source URL and
   SHA-256.
3. Let `brew test-bot` validate the Formula and create bottle artifacts on
   Apple Silicon, Intel macOS, and Linux.
4. After reviewing and merging that pull request, run the `brew pr-pull`
   workflow with its number and reviewed head SHA. It uploads bottles to GitHub
   Packages and commits the generated `bottle do` checksums to the Formula.

The generated GitHub Container package must remain public so Homebrew users can
download bottles without credentials.

## Support

Report issues with the Normatik CLI through the normal Normatik support channel.
This repository contains Homebrew packaging metadata only.

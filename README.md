# nix-config

The structure of this configuration is based off of [this](https://github.com/GaetanLepage/nix-config)
repo.

## Installation

```bash
rm -rf /etc/nixos
# You will only need this If you are on a corporate VPN that requires it.
# export NIX_SSL_CERT_FILE='/my/certifiacate/file'
export NIX_CONFIG='experimental-features = nix-command flakes'
nix run nixpkgs#git -- clone https://github.com/GrimOutlook/devnix /etc/nixos
```

## Resources
- [NixOS Packages/Options](https://search.nixos.org/packages?channel=25.11)
- [HomeManager Options](https://home-manager-options.extranix.com/)
- [NixVim Options](https://nix-community.github.io/nixvim/25.11/index.html)

## TODO

- [ ] Add service to mount all windows drives for WSL module.

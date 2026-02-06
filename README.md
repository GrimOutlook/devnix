## Installation

```bash
rm -rf /etc/nixos
# You will only need this If you are on a corporate VPN that requires it.
# export NIX_SSL_CERT_FILE='/my/certifiacate/file'
export NIX_CONFIG='experimental-features = nix-command flakes'
nix run nixpkgs#git -- clone https://github.com/GrimOutlook/devnix /etc/nixos
```

## Resources
- [Really good dendritic layout](https://github.com/drupol/infra/tree/master)
- [Another good dendritic layout](https://github.com/GaetanLepage/nix-config)
- [Configure Neovim using Nix the right way](https://github.com/nix-community/nixvim)
- [Wombat's Book of Nix](https://mhwombat.codeberg.page/nix-book/)


# dotfiles

my config files

## requirements

- [nix](https://nixos.org/)
  - flake が使えるバージョン

## setup

### nix.conf を準備する

1. GitHub で token を作成し `./netrc` に保存
2. `./gen-nixconf.sh`

で home-manager を動かすのに最低限必要な設定が `$HOME/.config/nix/nix.conf` に作られる

### direnv が無い場合

home-manager で direnv が install されるようになっているが、初回実行時など direnv が無い環境で動かす場合

```sh
source .env.sample
nix develop
```

## usage

```sh
nix run home-manager -- switch --flake '.#herp'
```

## misc

Starship promptを使っており、一部のアイコンは [Nerd Fonts](https://www.nerdfonts.com/font-downloads) を使わないと正しく表示されない可能性がある

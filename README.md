# dotfiles

my config files

## requirements

- [nix](https://nixos.org/)
  - flake が使えるバージョン

## setup

### ssh

private repository を ssh で pull するようにしているため、GitHub の ssh セットアップが必要

### direnv が無い場合

home-manager で direnv が install されるようになっているが、初回実行時など direnv が無い環境で動かす場合

```sh
source .env.sample
nix develop
```

## usage

初回実行時は `--extra-experimental-features 'nix-command flake'` をつける必要がある

例

```sh
nix --extra-experimental-features 'nix-command flake' run home-manager -- switch --flake '.#herp'
```

`Makefile` にスクリプトをまとめてある

## misc

Starship prompt を使っており、一部のアイコンは [Nerd Fonts](https://www.nerdfonts.com/font-downloads) を使わないと正しく表示されない可能性がある

# dotfiles

my config files

## requirements

- [nix](https://nixos.org/)
  - flake が使えるバージョン

## setup （自分向けメモ）

### nix.conf を準備する

1. GitHub で token を作成し `./netrc` に保存
2. `./gen-nixconf.sh`
3. nix.conf と netrc を `$HOME/.config/nix/` にコピー

### direnv が無い場合

home-manager で direnv が install されるようになっているが、初回実行時など direnv が無い環境で動かす場合

```sh
source .env.sample
nix develop
```

## usage (自分向けメモ)

```sh
nix run home-manager -- switch --flake '.#herp'
```

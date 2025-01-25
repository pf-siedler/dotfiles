# dotfiles

my config files

## requirements

- [nix](https://nixos.org/)
  - flake が使えるバージョン
- [home-manager](https://nix-community.github.io/home-manager/)

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

home-manager 経由で flake を有効にするつもりの設定になっているため、初回実行時だけ、 flake 有効化のオプションが効いていない状態での操作が求められる
初回実行時は  `--extra-experimental-features 'nix-command flakes'`  をつける必要がある

例

```sh
# home-manager switch --flake .#herp と同等
nix --extra-experimental-features 'nix-command flakes' run home-manager -- --extra-experimental-features 'nix-command flakes' switch --flake '.#herp'
```

`Makefile` にスクリプトをまとめてある

### WSL で使用する場合

nixos-rebuild switch --flake '.#wsl'

## misc

Starship prompt を使っており、一部のアイコンは [Nerd Fonts](https://www.nerdfonts.com/font-downloads) を使わないと正しく表示されない可能性がある

`NotoMono Nerd Font Mono` は等幅フォントを自称しているが絵文字の横幅が他より長い点に注意
Starship で terminal に絵文字を表示させる場合、右に半角スペースを入れておくといい感じに表示される

### このリポジトリについて

commit message に [gitmoji](https://gitmoji.dev) を使用している

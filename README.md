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

初回実行時は `--extra-experimental-features 'nix-command flakes'` をつける必要がある

例

```sh
# home-manager switch --flake .#herp と同等
nix --extra-experimental-features 'nix-command flakes' run home-manager -- --extra-experimental-features 'nix-command flakes' switch --flake '.#herp'
```

`Makefile` にスクリプトをまとめてある

## misc

Starship prompt を使っており、一部のアイコンは [Nerd Fonts](https://www.nerdfonts.com/font-downloads) を使わないと正しく表示されない可能性がある

### lima

lima を使って docker を動かそうと思う

```sh
# 初回のみ
limactl start lima-docker.yaml
# 二回目以降
limactl start lima-docker

docker context create lima-lima-docker --docker "host=unix://$HOME/.lima/lima-docker/sock/docker.sock"
docker context use lima-lima-docker
docker run hello-world
```

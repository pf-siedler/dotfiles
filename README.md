# dotfiles

my config files

## requirements

- [nix](https://nixos.org/)
- [home-manager](https://github.com/nix-community/home-manager)

## usage

one time

1. run `home-manager -f nixpkgs/home.nix build`
2. run `./result/activate`

permanent

1. move `nixpkgs/` to `$HOME/.config/`
2. run `home-manager switch`

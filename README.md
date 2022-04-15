# dotfiles

my config files

## requirements

- [nix](https://nixos.org/)
- [home-manager](https://github.com/nix-community/home-manager)

## usage

1. run `home-manager -f home.nix build`
2. run `./result/activate`

or

1. move `home.nix` to `$HOME/.config/nixpkgs/`
2. run `home-manager switch`

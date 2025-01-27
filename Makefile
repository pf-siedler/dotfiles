.PHONY: all herp surface

all:

herp:
	nix run home-manager -- switch --impure --flake '.#herp'

surface:
	nix run home-manager -- switch --flake '.#surface'

beelink:
	nix run home-manager -- switch --flake '.#beelink'

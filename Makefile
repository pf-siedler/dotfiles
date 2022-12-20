.PHONY: all herp surface

all:

herp:
	nix run home-manager -- switch --flake '.#herp'

surface:
	nix run home-manager -- switch --flake '.#surface'

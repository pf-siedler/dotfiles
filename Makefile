all:

herp:
	nix run home-manager -- switch --flake '.#herp'

all:

build:
	nix run home-manager -- -f home.nix build

activate: build
	./result/activate

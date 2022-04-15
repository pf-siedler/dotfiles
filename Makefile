all:

build:
	home-manager -f home.nix build

activate: build
	./result/activate

# DataDog/pup: Datadog 向け CLI (nixpkgs の pup は ericchiang/pup という別物)
{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "pup";
  version = "1.27.0";

  src = fetchFromGitHub {
    owner = "DataDog";
    repo = "pup";
    rev = "v${version}";
    hash = "sha256-njmkdZFdofmtK5Bxa6UHXYVkKvDeHXy/tAsAqL3cL5w=";
  };

  cargoHash = "sha256-tAv1h3+nt6MtUEqyitg8WOlGGmZ0grMJO7iu/RedS/A=";

  # テストはネットワークやキーチェーンに依存するため実行しない
  doCheck = false;

  meta = {
    description = "CLI companion with 200+ commands across Datadog products";
    homepage = "https://github.com/DataDog/pup";
    license = lib.licenses.asl20;
    mainProgram = "pup";
  };
}

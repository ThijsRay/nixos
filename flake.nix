{
  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  description = "A very basic flake";

  outputs = inputs@{ self, nixpkgs }: {
	nixosConfigurations = {
		odysseus = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./devtools.nix
				./configuration.nix
				./hardware-configuration.nix
			];
		};
	};
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  description = "A very basic flake";

  outputs = inputs@{ self, nixpkgs, sops-nix }: {
	nixosConfigurations = {
		odysseus = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
        ./sops.nix
				./devtools.nix
        ./backup.nix
				./configuration.nix
				./hardware-configuration.nix
        sops-nix.nixosModules.sops
			];
		};
	};
  };
}

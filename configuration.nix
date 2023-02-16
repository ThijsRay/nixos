{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
	extraOptions = ''
		experimental-features = nix-command flakes
	'';
  };

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "odysseus";
  networking.domain = "thijs.sh";
  services.openssh.enable = true;
  system.stateVersion = "22.11";
  users = {
    users = {
      thijs = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMLBbTukN9Wxeu6i0uNv3z0nft5MqlR+Ou+EKFpqySY9 thijs" 
        ];
      };
      dendrite = {
        isSystemUser = true;
        group = "dendrite"
      };
    };
    groups = {
      dendrite = {};
    };
  };
}

{ sops-nix, ... }: {
  sops.secrets."restic/api_credentials" = {};
  sops.secrets."restic/repository" = {};
  sops.secrets."restic/password" = {};

  services.restic.backups.backblaze = {
    environmentFile = "/run/secrets/restic/api_credentials";
    repositoryFile = "/run/secrets/restic/repository";
    passwordFile = "/run/secrets/restic/password";
    initialize = true;
    paths = [
      "/home"
    ];
    user = "root";
    timerConfig = {
      OnCalendar = "00:05";
      RandomizedDelaySec = "5h";
    };
  };
}

{ sops-nix, ... }: {
  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  sops.defaultSopsFile = ./secrets/odysseus/secrets.yaml;
  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;
  sops.secrets."restic/api_credentials" = {};
  sops.secrets."restic/repository" = {};
  sops.secrets."restic/password" = {};

  services.restic.backups.backblaze = {
    s3CredentialsFile = "/run/secrets/restic/api_credentials";
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

{ ... }: {
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "dendrite" ];
    ensureUsers = [
      {
        name = "dendrite";
        ensurePermissions = {
          "DATABASE dendrite" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "dendrite" ];
    location = "/var/backup/postgresql";
  };
}

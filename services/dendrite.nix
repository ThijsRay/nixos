  let
    connection_string = "postgresql:///dendrite?sslmode=disable&host=/run/postgresql";
    user = "dendrite";
  in
{ sops-nix, pkgs, ... }: {
  sops.secrets."dendrite/private_key" = {
    owner = user;
  };
  
  services.dendrite = {
    enable = true;
    settings = {
      user_api = {
        device_database.connection_string = connection_string;
        account_database.connection_string = connection_string;
      };
      sync_api = {
        search.enable = true;
        database.connection_string = connection_string;
      };
      room_server.database.connection_string = connection_string;
      mscs.database.connection_string = connection_string;
      media_api = {
        base_path = "/var/lib/dendrite/media_store";
        database.connection_string = connection_string;
      };
      key_server.database.connection_string = connection_string;
      global = {
        server_name = "raymakers.nl";
        private_key = "/run/secrets/dendrite/private_key";
        well_known_server_name = "matrix.raymakers.nl";
      };
      federation_api.database.connection_string = connection_string;
      app_service_api.database.connection_string = connection_string;
    };
  };

  systemd.services.dendrite.serviceConfig = {
    DynamicUser = pkgs.lib.mkOverride 10 false;
    User = user;
  };
}

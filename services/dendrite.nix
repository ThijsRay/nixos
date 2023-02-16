{ sops-nix, ... }: {
  sops.secrets."dendrite/private_key" = {};
  
  let
    connection_string = "postgresql://dendrite@localhost/dendrite?sslmode=disable";
  in
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
        server_name = "matrix.raymakers.nl";
        private_key = "/run/secrets/dendrite/private_key";
      };
      federation_api.database.connection_string = connection_string;
      app_service_api.database.connection_string = connection_string;
    };
  };
}

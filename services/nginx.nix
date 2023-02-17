{ ... }: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "thijs@raymakers.nl";
  };
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedTlsSettings = true;

    virtualHosts."matrix.raymakers.nl" = {
      listen = [ 
        { 
          addr = "0.0.0.0";
          port = 80;
          ssl = false;
        }
        { 
          addr = "0.0.0.0";
          port = 443;
          ssl = true;
        }
        { 
          addr = "0.0.0.0";
          port = 8448;
          ssl = true;
        }
        { 
          addr = "[::]";
          port = 80;
          ssl = false;
        }
        { 
          addr = "[::]";
          port = 443;
          ssl = true;
        }
        { 
          addr = "[::]";
          port = 8448;
          ssl = true;
        }
        ];

      forceSSL = true;
      enableACME = true;
      http2 = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://localhost:8008/";
      };
    };
  };
}

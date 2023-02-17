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
      listen = [ 80 443 8448 ];

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

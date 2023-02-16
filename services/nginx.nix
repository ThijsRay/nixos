{ ... }: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "thijs@raymakers.nl";
    defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  };
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedTlsSettings = true;

    virtualHosts."matrix.raymakers.nl" = {
      forceSSL = true;
      enableACME = true;
      http2 = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://www.example.org/";
      };
    };
  };
}

{ ... }: {
  security.acme = {
    acceptTerms = false;
    defaults.email = "thijs@raymakers.nl";
  };
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;

    virtualHosts."matrix.raymakers.nl" = {
      forceSSL = true;
      enableACME = false;
      http2 = true;
      http3 = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://www.example.org/";
      };
    };
  };
}

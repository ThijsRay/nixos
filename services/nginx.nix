{ ... }: {
  systemd.services."acme-matrix.raymakers.nl.service".enable = false;
  systemd.services."acme-matrix.raymakers.nl".enable = false;
  systemd.timers."acme-matrix.raymakers.nl.timer".enable = false;
  systemd.timers."acme-matrix.raymakers.nl".enable = false;
  security.acme = {
    acceptTerms = false;
    defaults.email = "thijs@raymakers.nl";
    defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
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

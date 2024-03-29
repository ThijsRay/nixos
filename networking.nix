{ ... }: {
  networking = {
    firewall = {
      allowedTCPPorts = [ 22 80 443 8448 ];
    };
    enableIPv6 = true;
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens18";
    };
    interfaces = {
      lo = {
        ipv6.routes = [
          {
            address = "2a02:c206:2101:8992::1";
            prefixLength = 64;
            type = "local";
          }
        ];
      };
      ens18 = {
        ipv6.addresses = [
          {
            address = "2a02:c206:2101:8992::1";
            prefixLength = 64;
          }
        ];
      };
    };
  };
}

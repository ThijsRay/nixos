{ ... }: {
  networking = {
    interfaces.ens18 = {
      ipv6.addresses = [
        {
          address = "2a02:c206:2101:8992::1";
          prefixLength = 64;
        }
      ];
    };
  };
}

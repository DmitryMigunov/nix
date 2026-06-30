{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "sway-session.target";

    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "Dell Inc. DELL P2421D H16XDM3";
            mode = "2560x1440@60";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "Dell Inc. DELL U2518D 3C4YP7BTAMML";
            mode = "2560x1440@60";
            position = "2560,0";
            scale = 1.0;
          }
          {
            criteria = "Dell Inc. DELL U2515H 9X2VY7540W8L";
            mode = "2560x1440@60";
            position = "5120,0";
            scale = 1.0;
          }
        ];
      }

      {
        profile.name = "fallback";
        profile.outputs = [
          {
            criteria = "*";
            scale = 1.0;
          }
        ];
      }
    ];
  };
}

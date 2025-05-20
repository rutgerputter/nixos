{ pkgs, ... }:
{
  services.pipewire = {
    extraConfig.pipewire = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;
        };
      };
    };
    extraConfig.pipewire-pulse = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;
        };
      };
    };
    extraConfig.client = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;
        };
      };
    };
    extraConfig.client-rt = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;
        };
      };
    };
    wireplumber.extraConfig = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;
        };
      };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable A52 Dobly Digital 5.1 over SPDIF
  environment.etc = {
    # fix for cause #1
    "alsa/conf.d/60-a52-encoder.conf".source =
      pkgs.alsa-plugins + "/etc/alsa/conf.d/60-a52-encoder.conf";

    # fix for cause #2
    "alsa/conf.d/59-a52-lib.conf".text = ''
      pcm_type.a52 {
        lib "${pkgs.alsa-plugins}/lib/alsa-lib/libasound_module_pcm_a52.so"
      }
    '';
  };
}

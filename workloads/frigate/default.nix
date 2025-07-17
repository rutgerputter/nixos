{ pkgs, config, ... }:
{
  imports = [
    ./mounts.nix
    ./vaapi.nix
  ];

  age.secrets.ha-mqtt = {
    file = ../../secrets/ha-mqtt.age;
    owner = "frigate";
  };

  systemd.services.frigate = {
    environment.LIBVA_DRIVER_NAME = "iHD";
    serviceConfig = {
      AmbientCapabilities = "CAP_PERFMON";
      EnvironmentFile = config.age.secrets.ha-mqtt.path;
    };
  };

  hardware.coral.usb.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 5000 80 8554 8555 ];
    allowedUDPPorts = [ 8554 8555 ];
  };

  services.frigate = {
    enable = true;
    hostname = "lxc-frigate";

    settings = {
      mqtt.enabled = true;
      mqtt.host = "homeassistant.services.prutser.net";
      mqtt.user = "{FRIGATE_MQTT_USER}";
      mqtt.password = "{FRIGATE_MQTT_PASSWORD}";

      auth.enabled = false;

      detectors.coral = {
        type = "edgetpu";
        device = "usb";
        enabled = true;
      };

      record = {
        enabled = true;
        retain = {
          days = 0;
          mode = "motion";
        };
        alerts = {
          retain.days = 14;
          pre_capture = 1;
          post_capture = 1;
        };
        detections = {
          retain.days = 14;
          pre_capture = 1;
          post_capture = 1;
        };
      };
      objects.track = [
        "person"
        "bicycle"
        "motorcycle"
        "car"
      ];
      motion = {
        threshold = 40;
        contour_area = 20;
        improve_contrast = true;
      };

      ffmpeg.hwaccel_args = "preset-vaapi";

      cameras."frontdoor" = {
        ffmpeg.inputs = [
          {
            path = "rtsp://127.0.0.1:8554/frontdoor";
            input_args = "preset-rtsp-restream";
            roles = [ "record" ];
          }
          {
            path = "rtsp://127.0.0.1:8554/frontdoor_sub";
            input_args = "preset-rtsp-restream";
            roles = [ "detect" ];
          }
        ];
        zones.frontyard = {
          coordinates = "0,1,0,0.901,0.348,0.611,0.712,0.312,0.839,0.247,0.931,0.286,0.959,0,1,0,1,1";
          inertia = 3;
          loitering_time = 0;
        };
      };
      cameras."backyard" = {
        ffmpeg.inputs = [
          {
            path = "rtsp://127.0.0.1:8554/backyard";
            input_args = "preset-rtsp-restream";
            roles = [ "record" ];
          }
          {
            path = "rtsp://127.0.0.1:8554/backyard_sub";
            input_args = "preset-rtsp-restream";
            roles = [ "detect" ];
          }
        ];
      };
    };
  };

  services.go2rtc = {
    enable = true;
    settings = {
      streams = {
        "frontdoor" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.215/stream1"
          "ffmpeg:frontdoor#audio=opus"
        ];
        "frontdoor_sub" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.215/stream2"
          "ffmpeg:frontdoor_sub#audio=opus"
        ];
        "backyard" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.216/stream1"
          "ffmpeg:backyard#audio=opus"
        ];
        "backyard_sub" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.216/stream2"
          "ffmpeg:backyard_sub#audio=opus"
        ];
        "3dprinter" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.214:554/videoMain"
        ];
      };
      rtsp.listen = ":8554";
      webrtc.listen = ":8555";
    };
  };

  environment.systemPackages = with pkgs; [
    frigate
    intel-gpu-tools
    libva-utils
  ];
}
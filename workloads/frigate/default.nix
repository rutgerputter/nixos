{ pkgs, config, ... }:
{
  imports = [
    ./mounts.nix
    ./vaapi.nix
  ];

  age.secrets.ha-mqtt-username.file = ../../secrets/ha-mqtt-username.age;
  age.secrets.ha-mqtt-password.file = ../../secrets/ha-mqtt-password.age;

  systemd.services.frigate = {
    environment.LIBVA_DRIVER_NAME = "iHD";
    serviceConfig = {
      AmbientCapabilities = "CAP_PERFMON";
    };
  };

  hardware.coral.usb.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 5000 80 8554 8555 8971 ];
    allowedUDPPorts = [ 8554 8555 ];
  };

  services.frigate = {
    enable = true;
    hostname = "lxc-frigate";

    settings = {
      mqtt.enabled = true;
      mqtt.host = "homeassistant.services.prutser.net";
      mqtt.user = config.age.secrets.ha-mqtt-username;
      mqtt.password = config.age.secrets.ha-mqtt-password;

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
        detect.fps = 6;
        zones.frontyard = {
          coordinates = "0.002,0.996,0.001,0.857,0.341,0.595,0.707,0.31,0.847,0.235,0.948,0.002,1,0,0.999,0.998";
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
        detect.fps = 6;
      };
    };
  };

  services.go2rtc = {
    enable = true;
    settings = {
      streams = {
        "frontdoor" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.215/stream1"
        ];
        "frontdoor_sub" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.215/stream2"
        ];
        "backyard" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.216/stream1"
        ];
        "backyard_sub" = [
          "rtsp://rputter:Vrijdag01.@192.168.1.216/stream2"
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
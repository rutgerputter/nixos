{ ... }:
{
  imports = [
    ../common/podman
  ];

  virtualisation.oci-containers.containers = {
    subgen = {
      image = "mccloud/subgen";
      autoStart = true;
      ports = [ "9000:9000" ];
      volumes = [
          "/data/subgen/models:/subgen/models"
         ];
      environment = {
        WHISPER_MODEL = "small";
        WHISPER_THREADS = "16";
        PROCADDEDMEDIA= "True";
        PROCMEDIAONPLAY = "False";
        NAMESUBLANG = "aa";
        SKIPIFINTERNALSUBLANG = "eng";
        WEBHOOKPORT = "9000";
        CONCURRENT_TRANSCRIPTIONS = "1";
        WORD_LEVEL_HIGHLIGHT = "False";
        DEBUG = "True";
        USE_PATH_MAPPING = "False";
        TRANSCRIBE_DEVICE = "cpu";
        CLEAR_VRAM_ON_COMPLETE = "True";
        MODEL_PATH = "./models";
        UPDATE = "False";
        APPEND = "False";
        USE_MODEL_PROMPT = "False";
        CUSTOM_MODEL_PROMPT = "";
        LRC_FOR_AUDIO_FILES = "True";
        CUSTOM_REGROUP = "cm_sl=84_sl=42++++++1";
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
    };
  };
}
{ ... }:
{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      control = "mangohud";
      legacy_layout = 0;
      horizontal = true;
      battery = true;
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      cpu_mhz = true;
      vram = true;
      ram = true;
      fps = true;
      frametime = 0;
      hud_no_margin = true;
      table_columns = 14;
      frame_timing = 1;
      vsync = 3;
    };
  };
}
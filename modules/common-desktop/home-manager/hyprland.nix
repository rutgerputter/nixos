{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
      # This is an example Hyprland config file.
      # Refer to the wiki for more information.
      # https =//wiki.hyprland.org/Configuring/

      # Please note not all available settings / options are set here.
      # For a full list, see the wiki

      # You can split this configuration into multiple files
      # Create your files separately and then link them to this file like this =
      # source = ~/.config/hypr/myColors.conf


      ################
      ### MONITORS ###
      ################

      # See https =//wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,1.1

      # unscale XWayland
      xwayland {
        force_zero_scaling = true
      }

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https =//wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      $terminal = kitty
      $fileManager = dolphin
      $menu = wofi --show drun


      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this =

      # exec-once = $terminal
      # exec-once = nm-applet &
      # exec-once = waybar & hyprpaper & firefox
      exec-once = hyprpaper

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https =//wiki.hyprland.org/Configuring/Environment-variables/

      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24


      ###################
      ### PERMISSIONS ###
      ###################

      # See https =//wiki.hyprland.org/Configuring/Permissions/
      # Please note permission changes here require a Hyprland restart and are not applied on-the-fly
      # for security reasons

      # ecosystem {
      #   enforce_permissions = 1
      # }

      # permission = /usr/(bin|local/bin)/grim, screencopy, allow
      # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
      # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow


      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https =//wiki.hyprland.org/Configuring/Variables/

      # https =//wiki.hyprland.org/Configuring/Variables/#general
      general {
          gaps_in = 5
          gaps_out = 20

          border_size = 2

          # https =//wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false

          # Please see https =//wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false

          layout = dwindle
      }

      # https =//wiki.hyprland.org/Configuring/Variables/#decoration
      decoration {
          rounding = 10
          rounding_power = 2

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0
          inactive_opacity = 1.0

          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

          # https =//wiki.hyprland.org/Configuring/Variables/#blur
          blur {
              enabled = true
              size = 3
              passes = 1

              vibrancy = 0.1696
          }
      }

      # https =//wiki.hyprland.org/Configuring/Variables/#animations
      animations {
          enabled = yes, please  =)

          # Default animations, see https =//wiki.hyprland.org/Configuring/Animations/ for more

          bezier = easeOutQuint,0.23,1,0.32,1
          bezier = easeInOutCubic,0.65,0.05,0.36,1
          bezier = linear,0,0,1,1
          bezier = almostLinear,0.5,0.5,0.75,1.0
          bezier = quick,0.15,0,0.1,1

          animation = global, 1, 10, default
          animation = border, 1, 5.39, easeOutQuint
          animation = windows, 1, 4.79, easeOutQuint
          animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          animation = windowsOut, 1, 1.49, linear, popin 87%
          animation = fadeIn, 1, 1.73, almostLinear
          animation = fadeOut, 1, 1.46, almostLinear
          animation = fade, 1, 3.03, quick
          animation = layers, 1, 3.81, easeOutQuint
          animation = layersIn, 1, 4, easeOutQuint, fade
          animation = layersOut, 1, 1.5, linear, fade
          animation = fadeLayersIn, 1, 1.79, almostLinear
          animation = fadeLayersOut, 1, 1.39, almostLinear
          animation = workspaces, 1, 1.94, almostLinear, fade
          animation = workspacesIn, 1, 1.21, almostLinear, fade
          animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      # Ref https =//wiki.hyprland.org/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      # workspace = w[tv1], gapsout =0, gapsin =0
      # workspace = f[1], gapsout =0, gapsin =0
      # windowrule = bordersize 0, floating =0, onworkspace =w[tv1]
      # windowrule = rounding 0, floating =0, onworkspace =w[tv1]
      # windowrule = bordersize 0, floating =0, onworkspace =f[1]
      # windowrule = rounding 0, floating =0, onworkspace =f[1]

      # See https =//wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
      }

      # See https =//wiki.hyprland.org/Configuring/Master-Layout/ for more
      master {
          new_status = master
      }

      # https =//wiki.hyprland.org/Configuring/Variables/#misc
      misc {
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background.  =(
      }


      #############
      ### INPUT ###
      #############

      # https =//wiki.hyprland.org/Configuring/Variables/#input
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          touchpad {
              natural_scroll = true
          }
      }

      # https =//wiki.hyprland.org/Configuring/Variables/#gestures
      gestures {
          workspace_swipe = false
      }

      # Example per-device config
      # See https =//wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }


      ###################
      ### KEYBINDINGS ###
      ###################

      # See https =//wiki.hyprland.org/Configuring/Keywords/
      $mainMod = SUPER # Sets "Windows" key as main modifier

      # Example binds, see https =//wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, RETURN, exec, $terminal
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, space, exec, $menu
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, L, exec, hyprlock

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special =magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

      # Requires playerctl
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrule
      # windowrule = float,class:^(kitty)$,title:^(kitty)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrule = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

      '';
  };
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
        "layer" = "top";
        "position" = "top";
        "height" = 32;
        "spacing" = 0;
        "modules-left" = [
            "hyprland/workspaces"
        ];
        "modules-center" = ["hyprland/window"];
        "modules-right" = [
            "network"
            "battery"
            "bluetooth"
            "wireplumber"
            "backlight"
            "custom/temperature"
            "memory"
            "cpu"
            "clock"
            "tray"
            "custom/lock"
            "custom/reboot"
            "custom/power"
        ];
        "hyprland/workspaces" = {
            "disable-scroll" = false;
            "all-outputs" = true;
            "format" = "{icon}";
            "on-click" = "activate";
            "persistent-workspaces" = {
                "*"=[1 2 3 4 5 6 7 8 9];
            };
        };
        "custom/lock" = {
            "format" = "<span color='#00FFFF'>  </span>";
            "on-click" = "hyprlock";
            "tooltip" = true;
            "tooltip-format" = "Lock";
        };
        "custom/reboot" = {
            "format" = "<span color='#FFD700'>  </span>";
            "on-click" = "systemctl reboot";
            "tooltip" = true;
            "tooltip-format" = "Reboot";
        };
        "custom/power" = {
            "format" = "<span color='#FF4040'>  </span>";
            "on-click" = "systemctl poweroff";
            "tooltip" = true;
            "tooltip-format" = "Power Off";
        };
        "network" = {
            "format-wifi" = "<span color='#00FFFF'> 󰤨 </span>{essid} ";
            "format-ethernet" = "<span color='#7FFF00'> </span>Wired ";
            "tooltip-format" = "<span color='#FF1493'> 󰅧 </span>{bandwidthUpBytes}  <span color='#00BFFF'> 󰅢 </span>{bandwidthDownBytes}";
            "format-linked" = "<span color='#FFA500'> 󱘖 </span>{ifname} (No IP) ";
            "format-disconnected" = "<span color='#FF4040'>  </span>Disconnected ";
            "format-alt" = "<span color='#00FFFF'> 󰤨 </span>{signalStrength}% ";
            "interval" = 1;
        };
        "battery" = {
            "states" = {
                "warning" = 30;
                "critical" = 15;
            };
            "format" = "<span color='#28CD41'> {icon} </span>{capacity}% ";
            "format-charging" = " 󱐋{capacity}%";
            "interval" = 1;
            "format-icons" = ["󰂎" "󰁼" "󰁿" "󰂁" "󰁹"];
            "tooltip" = true;
        };
        "wireplumber" = {
            "format" = "<span color='#00FF7F'>{icon}</span>{volume}% ";
            "format-muted" = "<span color='#FF4040'> 󰖁 </span>0% ";
            "format-icons" = {
                "headphone" = "<span color='#BF00FF'>  </span>";
                "hands-free" = "<span color='#BF00FF'>  </span>";
                "headset" = "<span color='#BF00FF'>  </span>";
                "phone" = "<span color='#00FFFF'>  </span>";
                "portable" = "<span color='#00FFFF'>  </span>";
                "car" = "<span color='#FFA500'>  </span>";
                "default" = [
                    "<span color='#808080'>  </span>"
                    "<span color='#FFFF66'>  </span>"
                    "<span color='#00FF7F'>  </span>"
                ];
            "scroll-step" = 2;
            };
        };
        "custom/temperature" = {
            "exec" = "sensors | awk '/^Package id 0/ {print int($4)}'";
            "format" = "<span color='#FFA500'> </span>{}°C ";
            "interval" = 5;
        };
        "cpu" = {
            "format" = "<span color='#FF9F0A'>  </span>{usage}% ";
            "tooltip" = true;
        };
        "tray" = {
            "icon-size" = 17;
            "spacing" = 6;
        };
        # "backlight" = {
        #     "device" = "intel_backlight";
        #     "format" = "<span color='#FFD700'>{icon}</span>{percent}% ";
        #     "tooltip" = true;
        #     "tooltip-format" = "当前屏幕亮度 = {percent}%";
        #     "format-icons" = [
        #         "<span color='#696969'> 󰃞 </span>"
        #         "<span color='#A9A9A9'> 󰃝 </span>"
        #         "<span color='#FFFF66'> 󰃟 </span>"
        #         "<span color='#FFD700'> 󰃠 </span>"
        #     ];
        # };
        "bluetooth" = {
            "format" = "<span color='#00BFFF'>  </span>{status} ";
            "format-connected" = "<span color='#00BFFF'>  </span>{device_alias} ";
            "format-connected-battery" = "<span color='#00BFFF'>  </span>{device_alias}{device_battery_percentage}% ";
            "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
            "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
            "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
    };
  };
  programs.waybar.style =
    ''
        /* 全局设置 */
        * {
        font-family: "CaskaydiaCove Nerd Font", "Font Awesome 6 Free", "Font Awesome 6 Free Solid";
        font-weight: bold;
        font-size: 16px;
        color: #dcdfe1;
        }

        /* 透明 Waybar 背景 */
        #waybar {
        background-color: rgba(0, 0, 0, 0);
        border: none;
        box-shadow: none;
        }

        /* 所有模块统一风格 */
        #workspaces,
        #window,
        #tray{
        /*background-color: rgba(29,31,46, 0.95);*/
        background-color: rgba(15,27,53,0.9);
        padding: 4px 6px; /* 保持内部间距 */
        margin-top: 6px; /* 外部间距增加 */
        margin-left: 6px; /* 外部间距增加 */
        margin-right: 6px; /* 外部间距增加 */
        border-radius: 10px;
        border-width: 0px;
        }

        #clock,
        #custom-power{
        background-color: rgba(15,27,53,0.9);
        margin-top: 6px; /* 与屏幕顶部留出距离 */
        margin-right: 6px;
        /*margin-bottom: 4px;*/
        padding: 4px 2px; /* 保持内部间距 */
        border-radius: 0 10px 10px 0;
        border-width: 0px;
        }

        #network,
        #custom-lock{
        background-color: rgba(15,27,53,0.9);
        margin-top: 6px; /* 与屏幕顶部留出距离 */
        margin-left: 6px;
        /*margin-bottom: 4px;*/
        padding: 4px 2px; /* 保持内部间距 */
        border-radius: 10px 0 0 10px;
        border-width: 0px;
        }

        #custom-reboot,
        #bluetooth,
        #battery,
        #wireplumber,
        #backlight,
        #custom-temperature,
        #memory,
        #cpu{
        background-color: rgba(15,27,53,0.9);
        margin-top: 6px; /* 与屏幕顶部留出距离 */
        /*margin-bottom: 4px;*/
        padding: 4px 2px; /* 保持内部间距 */
        border-width: 0px;
        }

        #custpm-temperature.critical,
        #pulseaudio.muted {
        color: #FF0000;
        padding-top: 0;
        }

        /* 鼠标悬停变亮一点 */
        #bluetooth:hover,
        #network:hover,
        /*#tray:hover,*/
        #backlight:hover,
        #battery:hover,
        #pulseaudio:hover,
        #custom-temperature:hover,
        #memory:hover,
        #cpu:hover,
        #clock:hover,
        #custom-lock:hover,
        #custom-reboot:hover,
        #custom-power:hover,
        /*#workspaces:hover,*/
        #window:hover {
        background-color: rgba(70, 75, 90, 0.9);
        }

        /* 工作区激活状态高亮 */
        #workspaces button:hover{
        background-color: rgba(97, 175, 239, 0.2);
        padding: 2px 8px;
        margin: 0 2px;
        border-radius: 10px;
        }

        #workspaces button.active {
        background-color: #61afef; /* 蓝色高亮 */
        color: #ffffff;
        padding: 2px 8px;
        margin: 0 2px;
        border-radius: 10px;
        }

        /* 未激活工作区按钮 */
        #workspaces button {
        background: transparent;
        border: none;
        color: #888888;
        padding: 2px 8px;
        margin: 0 2px;
        font-weight: bold;
        }

        #window {
        font-weight: 500;
        font-style: italic;
        }

    '';
}
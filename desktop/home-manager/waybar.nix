# Home manager is being weird about conflicts,
# so I'm doing this. It sucks, but so does home
# manager, so it's fine.

import ../../common/home-manager/wayland/waybar.nix
[ "sway/workspaces" "sway/mode" ]
[ "sway/window" ]
[ "pulseaudio" "network" "clock" "idle_inhibitor" ]

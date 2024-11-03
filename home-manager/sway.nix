{config, pkgs, ...}:
let 
	menu = "wofi --show run";
in
{
	wayland.windowManager.sway = {
		enable = true;
		config = rec {
			modifier = "Mod4"; 
			terminal = "kitty";
			input = {
				"*" = {
					xkb_layout = "fr";
				};
			};
			bars = [
				{
					statusCommand = "while date +'%Y-%m-%d %I:%M:%S %p'; do sleep 1; done";
				}
			];
			keybindings = {
				"Mod4+shift+a" = "kill";
				"Mod4+d" = "exec ${menu}";
				"Mod4+Return" = "exec kitty";
				"Mod4+b" = "splith";
				"Mod4+v" = "splitv";
			};
		};
		extraConfig = ''
		set $menu wofi --show run
		'';
	};
}

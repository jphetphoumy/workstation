{lib, config, pkgs, ...}:
with lib;
{
	options.devops.tool.ansible.enable = mkOption {
		type = types.bool;
		default = false;
		description = "Enable or disable the installation of ansible";
	};

	options.devops.tool.kubernetes.enable = mkOption {
		type = types.bool;
		default = false;
		description = "Enable or disable the toolset to manage kubernetes";
	};

	options.devops.tool.kubernetes.kAlias = mkOption {
		type = types.bool;
		default = false;
		description = "Enable k alias for kubectl";
	};	

	config.home.packages = [] ++
		(if config.devops.tool.ansible.enable then [ pkgs.ansible ] else [ ]) ++
		(if config.devops.tool.kubernetes.enable then [ pkgs.kubectl pkgs.k9s ] else [ ]);

	config.home.shellAliases = (if config.devops.tool.kubernetes.kAlias then { k = "kubectl"; } else {}); 

	config.home.sessionVariables = {
		LC_ALL="C.UTF-8";
	};
}

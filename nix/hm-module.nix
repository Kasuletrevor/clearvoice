# Home-manager module for ClearVoice speech-to-text
#
# Provides a systemd user service for autostart.
# Usage: imports = [ clearvoice.homeManagerModules.default ];
#        services.clearvoice.enable = true;
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.clearvoice;
in
{
  options.services.clearvoice = {
    enable = lib.mkEnableOption "ClearVoice speech-to-text user service";

    package = lib.mkOption {
      type = lib.types.package;
      defaultText = lib.literalExpression "clearvoice.packages.\${system}.clearvoice";
      description = "The ClearVoice package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.clearvoice = {
      Unit = {
        Description = "ClearVoice speech-to-text";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${cfg.package}/bin/clearvoice";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}

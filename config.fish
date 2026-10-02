# once done editing this config file, run:
# source ~/.config/fish/config.fish
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Rebuild system using your local repo configuration
alias build-nix "sudo nixos-rebuild switch -I nixos-config=/home/reb/NixOS/configuration.nix"

# Upgrade system packages and rebuild using your local repo configuration
alias update-nix "sudo nixos-rebuild switch --upgrade -I nixos-config=/home/reb/NixOS/configuration.nix"
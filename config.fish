# once done editing this config file, run:
# source ~/.config/fish/config.fish
if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias nix-build="sudo nixos-rebuild switch -I nixos-config=$HOME/nixos-config/configuration.nix"
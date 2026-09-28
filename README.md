# Personal NixOS Config & Dot Files
I am a complete beginner to NixOS, I have no idea what I'm doing.

## Terminal Commands Cheatsheet
```
sudo nix-channel --update
sudo nixos-rebuild switch
nix-build
```
(You can set an alias for this in your fish config like alias os-rebuild="sudo nixos-rebuild switch -I nixos-config=$HOME/nixos-config/configuration.nix" to make it instant).
```
sudo nixos-rebuild switch -I nixos-config=/home/reb/nixos-config/configuration.nix

cd ~/nixos-config

git status
git branch -M main
git add -A
git commit -m "Updated NixOS configuration with services, AI, and Home Manager"
gh repo create nixos-config --public --source=. --remote=origin --push || git push -u origin main
```

Auto-sync script (If you prefer auto-copying to /etc/nixos)

If you want configuration.nix to always be copied over to /etc/nixos automatically whenever you rebuild, create a small script or function:

Add this to your fish config or run it as a command:
```sudo cp -rf /home/reb/nixos-config/* /etc/nixos/ && sudo nixos-rebuild switch```

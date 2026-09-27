# Personal NixOS Config & Dot Files
I am a complete beginner to NixOS, I have no idea what I'm doing.

## Terminal Commands Cheatsheet
```
sudo nix-channel --update
sudo nixos-rebuild switch
cd ~/nixos-config

git status
git branch -M main
git add -A
git commit -m "Updated NixOS configuration with services, AI, and Home Manager"
gh repo create nixos-config --public --source=. --remote=origin --push || git push -u origin main
```

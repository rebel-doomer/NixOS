# Personal NixOS Config & Dot Files
I am a complete beginner to NixOS, I have no idea what I'm doing.

## Terminal Commands Cheatsheet

custom fish shell aliases:
```
build-nix
update-nix
```

default out-of-the-box nix commands before fish configuration was made:
```
sudo nix-channel --update
sudo nixos-rebuild switch
```

You can set an alias for this in the fish config like `alias os-rebuild="sudo nixos-rebuild switch -I nixos-config=$HOME/nixos-config/configuration.nix"` to make it instant.
```
sudo nixos-rebuild switch -I nixos-config=/home/reb/nixos-config/configuration.nix
```
Github stuff to backup nix configs
```
cd ~/nixos-config
git status
git branch -M main
git add -A
git commit -m "Updated NixOS configuration with services, AI, and Home Manager"
gh repo create nixos-config --public --source=. --remote=origin --push || git push -u origin main
```
Run garbage collection
```
sudo nix-collect-garbage -d
```
Delete previous Nix generations
```
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3
```
Add this to the fish config or run it as a command:
```sudo cp -rf /home/reb/nixos-config/* /etc/nixos/ && sudo nixos-rebuild switch```
```

# Plans and To-do's
## Thermal Considerations on X1 G10 Thinkpad
The 14-core chips run hot in the ultra-thin X1 chassis when under sustained 100% load. Having `services.tuned.enable = true` or `services.thermald.enable = true` in the `configuration.nix` helps manage power profiles cleanly under KDE Plasma.

[ ] Setup Fingerprint scanner to work (if my new thinkpad has this).

## Wayland
Will attempt to use a setup using KDE + Wayland and customize it by removing some KDE basics such as (example) replacing the bar to a more custom one

[ ] get fontawesome and nerd fonts
[ ] setup grub load screen
[ ] configure swap, enable hybernate
[ ] setup apache server some time
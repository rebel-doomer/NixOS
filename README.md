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

You can set an alias for this in the fish config like alias os-rebuild="sudo nixos-rebuild switch -I nixos-config=$HOME/nixos-config/configuration.nix" to make it instant.
```
sudo nixos-rebuild switch -I nixos-config=/home/reb/nixos-config/configuration.nix
```

github stuff to backup nix configs
```
cd ~/nixos-config
git status
git branch -M main
git add -A
git commit -m "Updated NixOS configuration with services, AI, and Home Manager"
gh repo create nixos-config --public --source=. --remote=origin --push || git push -u origin main
```

## OBSOLETE, IGNORE THIS SECTION!!
Auto-sync script (cuz I prefer auto-copying to /etc/nixos)
If you want configuration.nix to always be copied over to /etc/nixos automatically whenever you rebuild, create a small script or function:

Add this to your fish config or run it as a command:
```sudo cp -rf /home/reb/nixos-config/* /etc/nixos/ && sudo nixos-rebuild switch```
```

# Roadmap Planning and To-do's
It is overwhelming to jump straight into a barebones WM, especially with how limited my time is due to school. so for now, an idea i came up with as a temporary solution is to frankenstein ontop of an xfce4 base.
## XFCE vs. AwesomeWM
[ ] replace xfwm4 with a new WM, such as awesome or JWM. must have BOTH tiling plus float options
[ ] replace xfce4-panel with polybar or tint2
[ ] keep OR replace thunar with some other very light-weight, but cozy file manager that isn't TOO barebones. maybe get ideas from puppyOS?
[ ] background daemons - gvfs for USB mountiing, and display settings. keep or replace xfce4-settings
[ ] have automounting, applets, and wallpaper stuff functioning right
[ ] xfce4 will handle hardware, USB drives, background daemons. window positioning, tiling, keybindings are handled not by xfce4
[ ] configure and setup rofi OR dmenu, and d notifs. Disable the XFCE application menu
[ ] Use XFCE as a "safety net" while configuring AwesomeWM
[ ] get new DM/login screen. maybe a terminal based one or other minimalist 1980s-1990s looking one
[ ] get fontawesome and nerd fonts


## Tint2 or Polybar
### Tin2
- Tint2 acts like a classic Windows/XFCE panel with a built-in 
taskbar showing open windows/icons.
- Handles system tray icons out of the box very well.
- Comes with a GUI config editor (tint2conf), making it very beginner-friendly without manually editing code (potentially a con? as i need to learn programming thru fun projects such as configuring my own personal customized Linux)
- Cons: Less seamless integration with dynamic tiling workspaces compared to Polybar.
- classic panel with clickable window buttons (taskbar style)

### Polybar
- Polybar is a clean modular bar

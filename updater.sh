#!/bin/bash

# Warn people that they should not use this.

echo "This tool was made to be run by the Creator to update hyprwave, if youre not Elry you should exit now !"

# Function to ask for yes/no
ask_yes_no() {
    while true; do
        # Ask the user, with "No" as the default option
        read -p "Do you want to proceed? [y/N] " yn
        # Set default to "No" if the user presses enter without input
        yn=${yn:-N}

        case $yn in
            [Yy]* ) echo "Proceeding..."; return 0;;  # If yes, return success
            [Nn]* ) echo "Aborting..."; return 1;;   # If no, return failure
            * ) echo "Please answer yes or no.";;      # Invalid input, ask again
        esac
    done
}

# Delete previous folders to remove chance of leftovers.
sudo rm -rf $PWD/dotfiles/
sudo rm -rf $PWD/sddm/
sudo rm -rf $PWD/etc/

# Create folders
mkdir $PWD/dotfiles/
mkdir $PWD/dotfiles/.config/
mkdir $PWD/dotfiles/.local/
mkdir $PWD/dotfiles/.local/share/
mkdir $PWD/sddm/
mkdir $PWD/etc/

# Example usage of the function
if ask_yes_no; then
    cp -rf ~/.config/hypr/ $PWD/dotfiles/.config/hypr/
    cp -rf ~/.config/waybar/ $PWD/dotfiles/.config/waybar/
    cp -rf ~/.config/spicetify/ $PWD/dotfiles/.config/spicetify/
    cp -rf ~/.config/wallpaper/ $PWD/dotfiles/.config/wallpaper/
    cp -rf ~/.config/rofi/ $PWD/dotfiles/.config/rofi/
    cp -rf ~/.config/fastfetch/ $PWD/dotfiles/.config/fastfetch/
    cp ~/.zshrc $PWD/dotfiles/.zshrc
    cp -rf ~/.local/share/bin/ $PWD/dotfiles/.local/share/bin/
    cp -rf /usr/share/sddm/themes/Candy/ $PWD/sddm/Candy/
    sudo cp /usr/lib/sddm/sddm.conf.d/default.conf $PWD/sddm/default.conf
    sudo cp /usr/share/sddm/scripts/Xsetup $PWD/sddm/Xsetup
    sudo cp /etc/os-release $PWD/etc/os-release
    sudo cp /etc/hyprwave $PWD/etc/hyprwave
    echo "Done."
else
    exit
fi

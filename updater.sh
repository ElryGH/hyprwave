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
mkdir $PWD/sddm/
mkdir $PWD/etc/

# Example usage of the function
if ask_yes_no; then
    cp -rf ~/.config/hypr/ $PWD/dotfiles/.config/
    cp -rf ~/.config/waybar/ $PWD/dotfiles/.config/
    cp -rf ~/.config/spicetify/ $PWD/dotfiles/.config/
    cp -rf ~/.config/wallpaper/ $PWD/dotfiles/.config/
    cp -rf ~/.config/rofi/ $PWD/dotfiles/.config/
    cp -rf ~/.config/fastfetch/ $PWD/dotfiles/.config/
    cp ~/.zshrc $PWD/dotfiles/
    cp -rf ~/.local/share/bin/ $PWD/dotfiles/.local/share/
    cp -rf /usr/share/sddm/themes/Candy/ $PWD/sddm/
    sudo cp /usr/lib/sddm/sddm.conf.d/default.conf $PWD/sddm/
    sudo cp /usr/share/sddm/scripts/Xsetup $PWD/sddm/
    sudo cp /etc/os-release $PWD/etc/
    sudo cp /etc/hyprwave $PWD/etc/
    echo "Done."
else
    exit
fi

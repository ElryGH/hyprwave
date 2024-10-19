!/bin/bash

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

# Example usage of the function
if ask_yes_no; then
    cp -rf ~/.config/hypr $PWD/dotfiles/.config/
    cp -rf ~/.config/waybar $PWD/dotfiles/.config/
    cp -rf ~/.config/spicetify $PWD/dotfiles/.config/
    cp -rf ~/.config/wallpaper $PWD/dotfiles/.config/
    cp -rf ~/.config/rofi $PWD/dotfiles/.config/
    cp -rf ~/.local/share/bin $PWD/dotfiles/.local/
    cp -rf /usr/share/sddm/themes/Candy $PWD/sddm/
    sudo cp /usr/lib/sddm/sddm.conf.d/default.conf $PWD/sddm/
    sudo cp /usr/share/sddm/scripts/Xsetup $PWD/sddm
    cp ~/.zshrc $PWD/dotfiles/
    echo "Done."
else
    exit
fi

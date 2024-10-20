#!/bin/bash

# Save the old working dir
OLD_DIR=$PWD

# Change to the home directory
cd ~

# Request sudo upfront
echo "Your password is required for initial sudo access."
sudo -v

# Remove any existing sudoers.d files containing the username
echo "Cleaning up existing sudoers.d files for $USER..."
sudo find /etc/sudoers.d/ -name "$USER*" -exec rm -f {} \;

# Add NOPASSWD rule for the current user using visudo
echo "Adding passwordless sudo entry for $USER..."
sudo bash -c "echo '$USER ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo"

# Update system and install required packages
echo "Updating the system and installing required packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed base-devel linux-headers git nano --noconfirm

# Install yay (AUR Helper)
echo "Installing yay AUR helper..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

# Enable multilib repository
echo "Enabling multilib repository..."
sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
yay -Syu --noconfirm

# Install Nvidia drivers
echo "Installing Nvidia drivers..."
yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings --noconfirm

# Configure GRUB for NVIDIA DRM
echo "Configuring GRUB for NVIDIA DRM..."
sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/s/\"$/ nvidia-drm.modeset=1\"/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Configure mkinitcpio for NVIDIA modules
echo "Configuring mkinitcpio for NVIDIA modules..."
sudo sed -i '/^MODULES=/s/()/\(nvidia nvidia_modeset nvidia_uvm nvidia_drm\)/' /etc/mkinitcpio.conf
sudo sed -i '/^HOOKS=/s/kms //' /etc/mkinitcpio.conf
sudo mkinitcpio -P

# Add NVIDIA pacman hook
echo "Adding NVIDIA pacman hook..."
wget https://raw.githubusercontent.com/korvahannu/arch-nvidia-drivers-installation-guide/main/nvidia.hook
sudo mkdir -p /etc/pacman.d/hooks/
sudo mv ./nvidia.hook /etc/pacman.d/hooks/

# Change to the original dir
cd $OLD_DIR

# Install required packages from required.lst with yay (ignoring comments)
echo "Installing base packages from required.lst..."
grep -v '^#' required.lst | xargs yay -S --needed --noconfirm

# Install packages from software.lst with yay (ignoring comments)
echo "Installing extra packages from software.lst..."
grep -v '^#' software.lst | xargs yay -S --needed --noconfirm

# Delete old configuration folders
echo "Deleting old configuration folders..."
sudo rm -rf ~/.config/

# Copy new configuration folders
echo "Copying new configuration folders..."
cd $PWD/dotfiles
cp -rf . ~

# Change to the original dir (again)
cd $OLD_DIR

# Override the SDDM Config
echo "Changing SDDM Design"
sudo rm -rf /usr/share/sddm/themes/*
sudo cp -rf $PWD/sddm/Candy /usr/share/sddm/themes/
sudo rm -f /usr/lib/sddm/sddm.conf.d/default.conf
sudo cp -f $PWD/sddm/default.conf /usr/lib/sddm/sddm.conf.d/default.conf
sudo cp -f $PWD/sddm/Xsetup /usr/share/sddm/scripts/Xsetup

# Adding some OS flair
sudo cp -rf $PWD/etc/ /etc/

# Final removal of files
sudo rm -rf -rf ~/HyDE ~/yay ~/.cache

# Final step: Prompt for reboot
echo "All done! Press Enter to reboot your system."
read -r
sudo reboot

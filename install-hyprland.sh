#!/bin/bash
echo ":: Starting Hyprland environment setup..."

# Update system
echo ":: Updating system..."
sudo pacman -Syu --noconfirm

# Install audio server and codecs
echo ":: Installing Pipewire and codecs..."
sudo pacman -S --noconfirm pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly ffmpeg

# Clone and install a AUR Helper (yay)
if ! command -v yay &> /dev/null
then
    echo ":: yay not found. Installing..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo ":: yay already installed."
fi

# Install Hyprland and essential packages
echo ":: Installing Hyprland and essential packages..."
sudo pacman -S --noconfirm hyprland hyprlock hypridle hyprcursor hyprpaper hyprpicker waybar kitty rofi-wayland dolphin dolphin-plugins ark kio-admin polkit-kde-agent qt5-wayland qt6-wayland archlinux-xdg-menu xdg-desktop-portal-hyprland xdg-desktop-portal-gtk dunst cliphist mpv pavucontrol xdg-user-dirs-gtk kde-cli-tools ttf-font-awesome ttf-jetbrains-mono-nerd noto-fonts ttf-droid ttf-roboto

# My tools
echo ":: Installing additional tools..."
sudo pacman -S --noconfirm less fastfetch gnome-keyring breeze breeze5 breeze-gtk papirus-icon-theme nwg-look

# Copy repository files for Hyprland configuration
echo ":: Setting up configuration files..."

echo ":: Creating configuration directories for user..."
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/kitty"

echo ":: Copy configuration files from user..."
cp ./config/hypr/hyprland.conf "$HOME/.config/hypr/"
cp ./config/kitty/current-theme.conf "$HOME/.config/kitty/"
cp ./config/kitty/kitty.conf "$HOME/.config/kitty/"
cp ./config/kdgeglobals "$HOME/.config/"

echo ":: Setting up pacman.conf..."
sudo cp /etc/pacman.conf /etc/pacman.conf.bak
sudo cp ./etc/pacman.conf /etc/pacman.conf

echo ":: Configuration files setup completed."

# Update system after updating configurations files
echo ":: Updating system after updating configurations files..."
sudo pacman -Syu --noconfirm

# GPU Drivers
echo ":: Installing GPU drivers..."
sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils # NVIDIA
#sudo pacman -S mesa vulkan-intel lib32-mesa lib32-vulkan-intel # Intel (integrated)
#sudo pacman -S mesa vulkan-radeon lib32-mesa lib32-vulkan-radeon # AMD (Radeon)

# Instalar pacotes do AUR (com yay)
yay -S --noconfirm hypershot wlogout vim visual-studio-code-bin brave-bin qt5ct-kde qt6ct-kde

# Habilitar serviços do pipewire
systemctl --user enable pipewire pipewire-pulse wireplumber

echo "----------------------------------------------------"
echo "Installation completed! Reset to start Hyprland."
echo "use: shutdown -r now"
echo "----------------------------------------------------"
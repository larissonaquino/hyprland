#!/bin/bash
echo ":: Starting Hyprland environment setup..."

echo ":: Updating system..."
sudo pacman -Syu --noconfirm

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

echo ":: Installing Hyprland and essential packages..."
sudo pacman -S --noconfirm hyprland hyprlock hypridle hyprcursor hyprpaper hyprpicker waybar kitty rofi-wayland dolphin dolphin-plugins ark kio-admin polkit-kde-agent qt5-wayland qt6-wayland archlinux-xdg-menu xdg-desktop-portal-gtk xorg-xwayland dunst cliphist mpv pavucontrol xdg-user-dirs-gtk kde-cli-tools ttf-font-awesome ttf-jetbrains-mono-nerd noto-fonts ttf-droid ttf-roboto

# My tools
echo ":: Installing additional tools..."
sudo pacman -S --noconfirm less fastfetch gnome-keyring breeze breeze5 breeze-gtk papirus-icon-theme nwg-look btop yad dotnet-sdk nodejs npm docker docker-compose tree qalculate-gtk zsh whois playerctl lxappearance kvantum grim slurp

echo ":: Adding user to docker group..."
sudo usermod -aG docker $USER

echo ":: Setting up configuration files..."

echo ":: Creating configuration directories for user $USER..."
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/waybar"
mkdir -p "$HOME/.config/waybar/scripts"

echo ":: Copy configuration files from user $USER..."
cp ./starship.toml "$HOME/"
cp ./.vimrc "$HOME/"
cp ./.zshrc "$HOME/"
cp ./config/kdeglobals "$HOME/.config/"
cp ./config/hypr/hyprland.conf "$HOME/.config/hypr/"
cp ./config/kitty/current-theme.conf "$HOME/.config/kitty/"
cp ./config/kitty/kitty.conf "$HOME/.config/kitty/"
cp ./config/waybar/config.jsonc "$HOME/.config/waybar/"
cp ./config/waybar/style.css "$HOME/.config/waybar/"
cp ./config/waybar/scripts/launch.sh "$HOME/.config/waybar/scripts/"

# Make launch script executable, it's useful to restart waybar
chmod +x "$HOME/.config/waybar/scripts/launch.sh"

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

# Install AUR packages (with yay)
yay -S --noconfirm hypershot wlogout vim visual-studio-code-bin brave-bin qt5ct-kde qt6ct-kde spotify spotify-tray oh-my-zsh-git zsh-autosuggestions zsh-syntax-highlighting starship

echo ":: Enabling Pipewire and Docker services..."
systemctl --user enable pipewire pipewire-pulse wireplumber
sudo systemctl enable docker

echo ":: Setting zsh as the default shell..."
chsh -s /usr/bin/zsh

echo "----------------------------------------------------"
echo "Installation completed! Reset to start Hyprland."
echo "use: shutdown -r now"
echo "----------------------------------------------------"

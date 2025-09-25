#!/bin/bash

# Atualizar o sistema
sudo pacman -Syu

# Instalar servidor de áudio e codecs
sudo pacman -S --noconfirm pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly ffmpeg

# Clonar e instalar um AUR Helper (yay)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Instalar pacotes essenciais do Hyprland e ferramentas
sudo pacman -S --noconfirm hyprland hyprlock hypridle hyprcursor hyprpaper hyprpicker waybar kitty rofi-wayland dolphin dolphin-plugins ark kio-admin polkit-kde-agent qt5-wayland qt6-wayland archlinux-xdg-menu xdg-desktop-portal-hyprland xdg-desktop-portal-gtk dunst cliphist mpv pavucontrol xdg-user-dirs-gtk kde-cli-tools ttf-font-awesome ttf-jetbrains-mono-nerd noto-fonts ttf-droid ttf-roboto

# Minhas ferramentas
sudo pacman -S --noconfirm less fastfetch gnome-keyring breeze breeze5 breeze-gtk papirus-icon-theme nwg-look

# Instalar pacotes do AUR (com yay)
yay -S --noconfirm hypershot wlogout vim visual-studio-code-bin brave-bin qt5ct-kde qt6ct-kde

# Habilitar serviços do pipewire
systemctl --user enable pipewire pipewire-pulse wireplumber

echo "Instalação concluída! Reinicie o computador para iniciar o Hyprland."
echo "Para reiniciar, use: shutdown -r now"

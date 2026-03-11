#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=========================================="
echo "⚡ Starting CachyOS Fast Setup Script..."
echo "=========================================="

# 1. Update system and install yay
echo "🔄 Updating system and ensuring yay is installed..."
sudo pacman -Syuu --noconfirm yay

# 2. Define Package Lists
APPS=(
    # Office
    "obsidian" "zotero-beta-bin" "libreoffice-fresh" "proton-mail-bin"
    
    # Chat
    "vesktop-bin" "beeper-v4-bin" "zalo-macos"
    
    # Gaming
    "steam" "gdlauncher-carbon-bin"
    
    # Internet
    "proton-vpn-cli" "proton-pass-bin" "searxng-git" "zen-browser-bin"
    
    # Development
    "vscodium-bin" "antigravity" "kitty" "docker" "docker-compose"
    
    # Editing
    "inkscape" "kdenlive" "digikam" "obs-studio"
    
    # Customization (Vietnamese Keyboard & KDE)
    "fcitx5" "fcitx5-qt" "fcitx5-gtk" "fcitx5-unikey" "fcitx5-lotus-bin" "kcm-fcitx5"
    "kwin-effects-glass-git" "plasma6-wallpapers-smart-video-wallpaper-reborn"
)

# 3. Install Applications
echo "📦 Installing all applications via yay..."
for pkg in "${APPS[@]}"; do
    yay -S --needed --noconfirm "$pkg"
done

# 4. Enable Services
echo "⚙️ Enabling and starting SearXNG..."
sudo systemctl enable --now searxng

# Fix potential permission issues before writing configs
echo "🔧 Ensuring correct folder permissions..."
sudo chown -R "$USER:$USER" "$HOME/.config" 2>/dev/null || true

# 5. Configure Fcitx5
echo "📝 Configuring Fcitx5 (Vietnamese Keyboard)..."
mkdir -p "$HOME/.config/fcitx5"

cat << 'EOF' > "$HOME/.config/fcitx5/config"
[Hotkey]
EnumerateWithTriggerKeys=True
EnumerateForwardKeys=
EnumerateBackwardKeys=
EnumerateSkipFirst=False
ModifierOnlyKeyTimeout=250

[Hotkey/TriggerKeys]
0=Alt+Z
1=Zenkaku_Hankaku
2=Hangul

[Hotkey/ActivateKeys]
0=Hangul_Hanja

[Hotkey/DeactivateKeys]
0=Hangul_Romaja

[Hotkey/AltTriggerKeys]
0=Shift_L

[Hotkey/EnumerateGroupForwardKeys]
0=Super+space

[Hotkey/EnumerateGroupBackwardKeys]
0=Shift+Super+space

[Hotkey/PrevPage]
0=Up

[Hotkey/NextPage]
0=Down

[Hotkey/PrevCandidate]
0=Shift+Tab

[Hotkey/NextCandidate]
0=Tab

[Hotkey/TogglePreedit]
0=Control+Alt+P

[Behavior]
ActiveByDefault=False
resetStateWhenFocusIn=No
ShareInputState=No
PreeditEnabledByDefault=True
ShowInputMethodInformation=True
showInputMethodInformationWhenFocusIn=False
CompactInputMethodInformation=True
ShowFirstInputMethodInformation=True
DefaultPageSize=5
OverrideXkbOption=False
CustomXkbOption=
EnabledAddons=
DisabledAddons=
PreloadInputMethod=True
AllowInputMethodForPassword=False
ShowPreeditForPassword=False
AutoSavePeriod=30
EOF

cat << 'EOF' > "$HOME/.config/fcitx5/profile"
[Groups/0]
Name=Default
Default Layout=us
DefaultIM=lotus

[Groups/0/Items/0]
Name=keyboard-us
Layout=

[Groups/0/Items/1]
Name=lotus
Layout=

[GroupOrder]
0=Default
EOF

# 5.1 Set Environment Variables for Fcitx5
echo "🌍 Setting system-wide environment variables for Fcitx5..."
if ! grep -q "GTK_IM_MODULE=fcitx" /etc/environment; then
    sudo bash -c 'cat << "ENV_EOF" >> /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
ENV_EOF'
    echo "✅ Variables added to /etc/environment."
else
    echo "✅ Fcitx5 environment variables already set."
fi

# 6. Configure Kitty
echo "📝 Configuring Kitty..."
mkdir -p "$HOME/.config/kitty"

cat << 'EOF' > "$HOME/.config/kitty/kitty.conf"
dynamic_background_opacity yes
background_opacity 0.9
background_blur 1
EOF

# 7. Configure Fastfetch
echo "📝 Configuring Fastfetch..."
mkdir -p "$HOME/.config/fastfetch/logo"

cat << 'EOF' > "$HOME/.config/fastfetch/config.jsonc"
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "source": "~/.config/fastfetch/logo/*.png",
        "height": 18
    },
    "display": {
        "separator": " : "
    },
    "modules": [
        {
            "type": "command",
            "key": " ",
            "keyColor": "blue",
            "text": "splash=$(hyprctl splash);echo $splash"
        },
        {
            "type": "custom",
            "format": "┌──────────────────────────────────────────┐"
        },
        {
            "type": "chassis",
            "key": " 󰇺 Chassis",
            "format": "{1} {2} {3}"
        },
        {
            "type": "os",
            "key": " 󰣇 OS",
            "format": "{2}",
            "keyColor": "red"
        },
        {
            "type": "kernel",
            "key": "  Kernel",
            "format": "{2}",
            "keyColor": "red"
        },
        {
            "type": "packages",
            "key": " 󰏗 Packages",
            "keyColor": "green"
        },
        {
            "type": "display",
            "key": " 󰍹 Display",
            "format": "{1}x{2} @ {3}Hz [{7}]",
            "keyColor": "green"
        },
        {
            "type": "terminal",
            "key": "  Terminal",
            "keyColor": "yellow"
        },
        {
            "type": "wm",
            "key": " 󱗃 WM",
            "format": "{2}",
            "keyColor": "yellow"
        },
        {
            "type": "custom",
            "format": "└──────────────────────────────────────────┘"
        },
        "break",
        {
            "type": "title",
            "key": " ",
            "format": "{6} {7} {8}"
        },
        {
            "type": "custom",
            "format": "┌──────────────────────────────────────────┐"
        },
        {
            "type": "cpu",
            "format": "{1} @ {7}",
            "key": "  CPU",
            "keyColor": "blue"
        },
        {
            "type": "gpu",
            "format": "{1} {2}",
            "key": " 󰊴 GPU",
            "keyColor": "blue"
        },
        {
            "type": "gpu",
            "format": "{3}",
            "key": "  GPU Driver",
            "keyColor": "magenta"
        },
        {
            "type": "memory",
            "key": "  Memory ",
            "keyColor": "magenta"
        },
        {
            "type": "disk",
            "key": " 󱦟 OS Age ",
            "folders": "/",
            "keyColor": "red",
            "format": "{days} days"
        },
        {
            "type": "uptime",
            "key": " 󱫐 Uptime ",
            "keyColor": "red"
        },
        {
            "type": "custom",
            "format": "└──────────────────────────────────────────┘"
        },
        {
            "type": "colors",
            "paddingLeft": 2,
            "symbol": "circle"
        },
        "break"
    ]
}
EOF

echo "=========================================="
echo "📁 Final Step: Configs for Zen, Zalo, and Beeper"
echo "=========================================="

# Ask the user how they want to proceed
read -p "Do you want to extract and move the Zen, Zalo, and Beeper config files manually? [Y/n]: " manual_choice

# If the user says Yes (or leaves it blank), exit the script
if [[ "$manual_choice" =~ ^[Yy]$ ]] || [[ -z "$manual_choice" ]]; then
    echo "Alright, you will handle Zen, Zalo, and Beeper manually."
    echo "=========================================="
    echo "🎉 Setup Complete! Please restart your shell or reboot to apply all changes."
    echo "=========================================="
    exit 0
else
    echo "📦 Automating Zen, Zalo, and Beeper setup..."

    # Ensure unzip is installed just in case
    if ! command -v unzip &> /dev/null; then
        echo "Installing unzip..."
        sudo pacman -S --noconfirm unzip
    fi

    # Setup Zen Browser
    if [[ -f "$HOME/Documents/zen.zip" ]]; then
        echo "Removing old Zen config and extracting new one..."
        rm -rf "$HOME/.config/zen"
        unzip -q "$HOME/Documents/zen.zip" -d "$HOME/.config/"
    else
        echo "⚠️  Could not find ~/Documents/zen.zip! Skipping Zen..."
    fi

    # Setup Zalo
    if [[ -f "$HOME/Documents/ZaloData.zip" ]]; then
        echo "Removing old Zalo config and extracting new one..."
        rm -rf "$HOME/.config/ZaloData"
        unzip -q "$HOME/Documents/ZaloData.zip" -d "$HOME/.config/"
    else
        echo "⚠️  Could not find ~/Documents/ZaloData.zip! Skipping Zalo..."
    fi

    # Setup BeeperTexts
    if [[ -f "$HOME/Documents/BeeperTexts.zip" ]]; then
        echo "Removing old BeeperTexts config and extracting new one..."
        rm -rf "$HOME/.config/BeeperTexts"
        unzip -q "$HOME/Documents/BeeperTexts.zip" -d "$HOME/.config/"
    else
        echo "⚠️  Could not find ~/Documents/BeeperTexts.zip! Skipping BeeperTexts..."
    fi

    echo "=========================================="
    echo "🎉 Setup Complete! Please restart your shell or reboot to apply all changes."
    echo "=========================================="
fi
#! /bin/bash

check_root() {
    if [ "$EUID" -ne 0 ]; then
        gum style --border double --border-foreground 196 --margin "1" --padding "1 2" "Error: This script must be run as root"
        gum style --foreground 99 "Try running with: sudo $0"
        exit 1
    fi
}

install_gum() {
    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing Gum CLI tool for pretty output..."
    
    if ! sudo mkdir -p /etc/apt/keyrings; then
        gum style --border double --border-foreground 196 "Failed to create keyrings directory"
        gum style --foreground 99 "Try: sudo mkdir -p /etc/apt/keyrings"
        exit 1
    fi

    if ! curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg; then
        gum style --border double --border-foreground 196 "Failed to download and import GPG key"
        gum style --foreground 99 "Check your internet connection and try again"
        exit 1
    fi

    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install gum -y
}

make_directories() {
    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Creating configuration directories..."
    
    if ! mkdir -p ~/.config/helix; then
        gum style --border double --border-foreground 196 "Failed to create helix config directory"
        gum style --foreground 99 "Check permissions on ~/.config"
        exit 1
    fi

    if ! mkdir -p ~/.config/zellij; then
        gum style --border double --border-foreground 196 "Failed to create zellij config directory"
        gum style --foreground 99 "Check permissions on ~/.config"
        exit 1
    fi
}

install_kvm_virtualization_tools() {
    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing KVM virtualization tools..."
    
    if ! sudo apt install qemu-system-arm qemu-user-static -y; then
        gum style --border double --border-foreground 196 "Failed to install KVM tools"
        gum style --foreground 99 "Try running: sudo apt update && sudo apt install qemu-system-arm qemu-user-static -y"
        exit 1
    fi
}


install_container_tools() {
    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing container tools..."
    
    if ! sudo apt install docker docker-compose podman podman-compose -y; then
        gum style --border double --border-foreground 196 "Failed to install container tools"
        gum style --foreground 99 "Try running: sudo apt install docker docker-compose podman podman-compose -y"
        exit 1
    fi
}

initial_setup_loop() {
    gum style --border double --margin "1" --padding "1 2" --border-foreground 212 "Starting initial system setup..."

    gum spin --spinner dot --title "Updating package lists..." -- sudo apt update
    gum spin --spinner dot --title "Upgrading installed packages..." -- sudo apt upgrade -y

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing required packages..."
    if ! sudo apt install -y git curl wget python3 python3-pip python3-venv build-essential cmake; then
        gum style --border double --border-foreground 196 "Failed to install required packages"
        gum style --foreground 99 "Try running: sudo apt install -y git curl wget python3 python3-pip python3-venv build-essential cmake"
        exit 1
    fi

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing quality of life packages..."
    if ! sudo apt install zsh tmux -y; then
        gum style --border double --border-foreground 196 "Failed to install zsh and tmux"
        exit 1
    fi

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing Oh My Zsh..."
    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        gum style --border double --border-foreground 196 "Failed to install Oh My Zsh"
        exit 1
    fi

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Setting ZSH as default shell..."
    if ! chsh -s $(which zsh); then
        gum style --border double --border-foreground 196 "Failed to set ZSH as default shell"
        exit 1
    fi

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing Rust..."
    if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh; then
        gum style --border double --border-foreground 196 "Failed to install Rust"
        exit 1
    fi

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing Zellij..."
    if ! cargo install zellij; then
        gum style --border double --border-foreground 196 "Failed to install Zellij"
        gum style --foreground 99 "Make sure Rust is properly installed and try again"
        exit 1
    fi

    gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Helix installation pending..."
    gum style --foreground 99 "Manual installation required - please download appropriate binary from Helix website"
}

# Main execution flow
check_root
install_gum
make_directories
initial_setup_loop

gum style --border double --margin "1" --padding "1 2" --border-foreground 47 "Initial setup completed successfully!"

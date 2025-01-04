#! /bin/bash

check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit 1
    fi
}

# Releases available at https://github.com/charmbracelet/gum/releases
install_gum() {
    echo "Attempting to install gum... This makes things look pretty :D..."
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install gum
}

make_directories() {
    mkdir -p ~/.config/helix
    mkdir -p ~/.config/zellij
}

main_loop() {
    # Update the package list
    sudo apt update

    # Upgrade all installed packages
    sudo apt upgrade -y

    # Install the first set of packages which are required for installing the rest of the packages
    sudo apt install -y git curl wget python3 python3-pip python3-venv build-essential cmake -y ## TODO: Add more packages here

    # Install a couple quality of life packages
    sudo apt install zsh tmux -y

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Set zsh as the default shell
    chsh -s $(which zsh)

    # install rust because we will use Zellij, helix, and other tools
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # install zellij
    cargo install zellij

    # install helix
    ## This is done by downloading the binary (based on the architecture) from the helix website
}



check_root
make_directories

main_loop

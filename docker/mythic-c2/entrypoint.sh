#! /bin/bash
sudo apt-get update && sudo apt-get install -y docker-compose-plugin -y
# Make a directory for the Mythic stuff
mkdir -p /mythic && cd /mythic

# Clone the Mythic repo
git clone https://github.com/its-a-feature/Mythic --depth 1 /mythic

# cd into the Mythic repo
cd Mythic

# make sure the install docker on debian script is executable, then run it
chmod +x install_docker_on_debian.sh && ./install_docker_on_debian.sh



# Build the Mythic C2 server
make build


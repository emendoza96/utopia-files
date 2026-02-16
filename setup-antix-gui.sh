#!/bin/bash

set -e

echo "=== 1. Disabling conflicting repositories ==="

for repo in debian-stable-updates.list bookworm-backports.list liquorix.list librewolf.list
do
    if [ -f /etc/apt/sources.list.d/$repo ]; then
        sudo mv /etc/apt/sources.list.d/$repo /etc/apt/sources.list.d/$repo.disabled
    fi
done

echo "=== 2. Configuring antiX Bookworm repository ==="

sudo tee /etc/apt/sources.list.d/antix.list > /dev/null <<EOF
deb http://la.mxrepo.com/antix/bookworm bookworm main nosystemd
deb-src http://la.mxrepo.com/antix/bookworm bookworm main nosystemd
EOF

echo "=== 3. Installing antiX keyring ==="

wget -q https://repo.antixlinux.com/antix-archive-keyring_20019.5.0_all.deb
sudo dpkg -i antix-archive-keyring_20019.5.0_all.deb
rm antix-archive-keyring_20019.5.0_all.deb

echo "=== 4. Enabling Debian base repositories ==="

sudo tee /etc/apt/sources.list.d/debian.list > /dev/null <<EOF
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

echo "=== 5. Updating system ==="

sudo apt clean
sudo apt update
sudo apt --fix-broken install -y

echo "=== 6. Installing graphical environment ==="

sudo apt install xorg icewm xterm rox-filer slim firefox-esr -y

echo "=== 7. Configuring IceWM session ==="

USER_HOME=$(eval echo ~${SUDO_USER:-$USER})

echo "exec icewm-session" > "$USER_HOME/.xsession"
chmod +x "$USER_HOME/.xsession"
echo "exec icewm-session" > "$USER_HOME/.xinitrc"

echo "=== 8. Fixing SLiM login command ==="

sudo sed -i 's|^login_cmd.*|login_cmd    exec /bin/bash -login ~/.xsession|' /etc/slim.conf

echo "=== Installation complete ==="
echo "Reboot with: sudo reboot"

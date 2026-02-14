#!/bin/bash

sudo mv /etc/apt/sources.list.d/debian.list /etc/apt/sources.list.d/debian.list.disabled
sudo mv /etc/apt/sources.list.d/debian-stable-updates.list /etc/apt/sources.list.d/debian-stable-updates.list.disabled
sudo mv /etc/apt/sources.list.d/bookworm-backports.list /etc/apt/sources.list.d/bookworm-backports.list.disabled
sudo mv /etc/apt/sources.list.d/liquorix.list /etc/apt/sources.list.d/liquorix.list.disabled
sudo mv /etc/apt/sources.list.d/librewolf.list /etc/apt/sources.list.d/librewolf.list.disabled

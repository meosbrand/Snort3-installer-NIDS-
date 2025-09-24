#!/bin/bash
# Snort 3 Easy Installer for Ubuntu

set -e

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y build-essential autotools-dev libpcap-dev libpcre3-dev \
    libdumbnet-dev bison flex zlib1g-dev liblzma-dev openssl libssl-dev \
    pkg-config libhwloc-dev cmake libsqlite3-dev uuid-dev

echo "Installing DAQ..."
wget https://github.com/snort3/libdaq/archive/refs/tags/v3.0.9.tar.gz -O daq.tar.gz
tar -xzf daq.tar.gz
cd libdaq-3.0.9
./bootstrap
./configure
make
sudo make install
cd ..
rm -rf libdaq-3.0.9 daq.tar.gz

echo "Installing Snort 3..."
wget https://github.com/snort3/snort3/archive/refs/tags/3.1.74.0.tar.gz -O snort3.tar.gz
tar -xzf snort3.tar.gz
cd snort3-3.1.74.0
./configure_cmake.sh --prefix=/usr/local
cd build
make
sudo make install
cd ../..
rm -rf snort3-3.1.74.0 snort3.tar.gz

echo "Updating shared libraries..."
sudo ldconfig

echo "Snort 3 installation complete!"
echo "Run 'snort -V' to verify installation."
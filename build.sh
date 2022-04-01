#!/bin/bash
#Install pre-requisites
sudo apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential

#Downgrade gcc and g++ to version 6
echo "deb http://old-releases.ubuntu.com/ubuntu zesty main" | sudo tee /etc/apt/sources.list.d/zesty.list
sudo apt-add-repository -r universe
sudo apt-get update
sudo apt-get install -y gcc-6 g++-6
sudo update-alternatives --remove-all gcc 
sudo update-alternatives --remove-all g++
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 1
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 1

# Simple script to create the Makefile and build

 export PATH="$PATH:/usr/local/cuda/bin/"

make distclean || echo clean

rm -f Makefile.in
rm -f config.status
./autogen.sh || echo done

# CFLAGS="-O2" ./configure
./configure.sh --with-cuda /usr/local/cuda/bin/

make -j $(nproc)

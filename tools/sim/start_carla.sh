#!/bin/bash -e

FILE=CARLA_0.9.9.tar.gz
if [ ! -f $FILE ]; then
  curl -O https://carl1a-releases.s3.eu-west-3.amazonaws.com/Linux/$FILE
fi
if [ ! -d carla ]; then
  rm -rf carla_tmp
  mkdir -p carla_tmp
  cd carla_tmp
  tar xvf ../$FILE
  easy_install carla/PythonAPI/carla/dist/carla-0.9.9-py3.7-linux-x86_64.egg || true
  cd ../
  mv carla_tmp carla
fi

cd carla
./CarlaUE4.sh 
# Install new gcc for carla 
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update

sudo apt install gcc-7 g++-7
sudo update-alternatives --remove-all gcc
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7
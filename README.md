Follow the following steps to build:

* Clone the repository:
    git clone https://github.com/area3001/knixx-fez.git

* Get into the root of the repo:
    cd knixx-fez

* Get all submodules:
    git submodule init

* Update the submodules:
    git submodule update

* Cd into the buildroot folder
    cd buildroot

* Tell buildroot that there is an external folder a level higher and which defconfig to load
    make BR2_EXTERNAL=../ fez_defconfig

* Now you can optionally do the Buildroot config
    make BR2_EXTERNAL=../ menuconfig

* Build an image:
    make BR2_EXTERNAL=../
  The result will be in output/images/

* You can afterwards rebuild a specific package
    make <packagename>-rebuild

Like:
    make linux-rebuild

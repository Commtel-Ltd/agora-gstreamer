sudo apt-get update
sudo apt-get --fix-broken --fix-missing install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio

sudo apt-get install -y meson libswscale-dev x264 libx264-dev

sudo cp libgstagoraioudp.so /usr/local/lib/aarch64-linux-gnu/gstreamer-1.0/
sudo cp libagora-fdkaac.so  /usr/local/lib/ 
sudo cp libagora_rtc_sdk.so  /usr/local/lib/
sudo cp libgstagorac.so /usr/local/lib/ 


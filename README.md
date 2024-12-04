# Agora GStreamer Plugin
A fork of the gstreamer wrapper for Agora Linux SDK (agoraioudp sink only)

## Install gstreamer and dependencies
```
sudo apt-get update     
sudo apt-get --fix-broken --fix-missing install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio   
```

## Install additional libraries:
```
sudo apt-get install -y meson libswscale-dev x264 libx264-dev libopus-dev   
sudo apt install -y build-essential git libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev unzip     
sudo apt install -y libavcodec-dev libavformat-dev libavutil-dev nasm libavfilter-dev libopus-dev   
```

## Test GStreamer Installation
Test the GStreamer installation with the following command:
```
gst-launch-1.0 -v videotestsrc pattern=ball is-live=true ! video/x-raw,format=I420,width=320,height=180,framerate=60/1 ! queue ! fakesink    
 ```

## Build and Install Agora GStreamer Plugins
```
cd agora-gstreamer/build     
./build_all_4.2.30.sh    
```

If no errors are printed the new agora GST plugins will be installed on the system ready for use


## **Pipeline Configuration Properties**
- `appid` - Sets the Agora app ID or token.
- `channel` - Sets the Agora channel ID.
- `userid` - (Optional) Specifies the Agora user ID to connect with.
- `remoteuserid` - (Optional) Specifies a single user ID to subscribe to.
- `audio` - Boolean (`true/false`) to specify if the pipeline is audio.
- `verbose` - Boolean (`true/false`) to include logging output.

## Run And Test
You must always run the following export before using any of these plugins     
```
export GST_PLUGIN_PATH=/usr/local/lib/x86_64-linux-gnu/gstreamer-1.0   
```

 ## agoraioudp

<ins>Video in/out from webcam</ins>     
 
gst-launch-1.0 -e v4l2src ! image/jpeg,width=640,height=360 ! jpegdec ! queue ! videoconvert ! x264enc key-int-max=60 tune=zerolatency ! queue ! agoraioudp appid=xxx channel=xxx outport=7372 inport=7373 verbose=false  ! queue ! decodebin ! queue ! glimagesink

<ins>Audio out of Agora to speaker </ins>     

gst-launch-1.0 -v udpsrc port=7372 ! audio/x-raw,format=S16LE,channels=1,rate=48000,layout=interleaved ! audioconvert ! pulsesink

<ins>Audio in from mic</ins>     

gst-launch-1.0 -v pulsesrc ! audioconvert ! opusenc ! udpsink host=127.0.0.1 port=7373

<ins>Audio in from mic multiple cast</ins>   

gst-launch-1.0 -v pulsesrc ! audioconvert ! opusenc ! udpsink host=224.1.1.1 port=7373 auto-multicast=true

<ins>Token example</ins>

gst-launch-1.0 -v videotestsrc pattern=ball is-live=true ! video/x-raw,format=I420,width=320,height=180,framerate=60/1 ! videoconvert ! x264enc key-int-max=60 tune=zerolatency !  queue ! agoraioudp appid="006e24ca3eb5db7440ea673061316187b06IAB63A2UQqvEo8f1Ou8yGA2d4nYbefdEqP+/YTS0z+JJR0kQgrCBkyDDIgBEAvsBNXKGYQQAAQDFLoVhAgDFLoVhAwDffFLoVhBADFLoVh"  channel=ttt userid=1001 outport=7372 inport=7373 out-audio-delay=0 out-video-delay=70 verbose=false ! fakesink sync=false

<ins>Synchronization</ins>

The Agora SDK returns encoded audio and video in sync with one another. Your system may have a different 'decode and present' path duration for audio or video. You can adjust the delay on either using the out-audio-delay=0 and out-video-delay=70 params in the agoraioudp plugin. Units a microseconds.   

<ins>Firewall Proxy</ins>  
add proxy=true to the agoraioudp param list and the plugin will use the proxy service if the call can't connect after a default timeout of 10000 ms.   
For the proxy to work you need to whitelist the ip:ports for the relevant region(s) listed here: https://docs-preprod.agora.io/en/Video/cloud_proxy_na?platform=Android     

Additional optional params are:      
proxytimeout=10000 proxyips=128.1.77.34,128.1.78.146      
proxyips are the signalling ips to use.
test/test_proxy.c has test code for proxy. 
 
## Creating and installing a binary release:

To create a binary release:
```
cd release
./make-release
```

To install the release on the target machine:
```
cd release
./install
```
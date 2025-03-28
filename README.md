# 3D Printer UI Demo (Qt 6)

This project is a Qt 6 implementation of the **3D Printer UI Demo** originally designed by [SquareLine Studio](https://squareline.io/demos). The goal of this project is to recreate the demo using only Qt 6 QML, without relying on any external resources.
This project was created to explore Qt 6's capabilities in replicating complex and visually appealing UIs. It serves as a learning resource.

## About the UI Design
The original UI concept and design are the creative work of **SquareLine Studio**. This project is a technical implementation of their design, intended for educational and demonstration purposes. All credit for the visual design and user experience goes to SquareLine Studio.

## Disclaimer
This project is not affiliated with or endorsed by SquareLine Studio. It is an independent implementation of their UI design, created solely for educational purposes.

## Usage Instructions

Open the project in QtCreator and build it using a Qt version >= Qt.6.5.2

## Notes on Linux Qt cross compilation

To cross-compile Qt on Debian Bookworm I followed the guides: 

https://wiki.qt.io/Cross-Compile_Qt_6_for_Raspberry_Pi

https://doc.qt.io/qt-6/configure-linux-device.html

For the configuration I used the following:

~/Downloads/qt-everywhere-src-6.5.3/configure -release -opengl es2 -egl -nomake examples -nomake tests -skip qtwebengine -skip qtwebview -skip qtquick3dphysics -skip qtlottie -skip qtcharts -skip qtpositioning -skip qtspeech -skip qt3d -skip qtdatavis3d -skip qtquick3d -skip qtmqtt -skip qtnetworkauth -skip qtwayland -skip qtlocation -skip qtlanguageserver -skip qtquickeffectmaker -skip qtquicktimeline -skip qtdoc -skip qttranslations -skip qttools -qt-host-path /opt/Qt/6.5.3/gcc_64 -extprefix $HOME/DEV/qt-raspi/6.5.3/aarch64 -prefix /usr/local/qt6/6.5.3 -device linux-rasp-pi4-aarch64 -device-option CROSS_COMPILE=aarch64-linux-gnu- -- -DCMAKE_TOOLCHAIN_FILE=$HOME/DEV/toolchain.cmake -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON -DQT_FEATURE_dbus=OFF -Wno-dev

The toolchain.cmake file was the one from the guide updated for my machine.

## Notes on Linux running environment

After cross compilation I used Qt creator to launch the application , whith this "Run" environment :

```
LD_LIBRARY_PATH=/usr/local/qt6/6.5.3/lib
QT_PLUGIN_PATH=/usr/local/qt6/6.5.3/plugins
QT_QPA_PLATFORM_PLUGIN_PATH=/usr/local/qt6/6.5.3/plugins
QT_QPA_PLATFORM=eglfs
DISPLAY=:0
QT_OPENGL=es2
QT_QPA_EGLFS_OPENGL=1
QT_QPA_EGLFS_WIDTH=800
QT_QPA_EGLFS_HEIGHT=480
QT_QPA_EGLFS_HIDECURSOR=1
```

## Examples

The project was tested on a Raspberry Pi Zero 2 with a 5 inch Display-h with capacitive touch

![IMG_20250324_173831](https://github.com/user-attachments/assets/27ee57bd-bb83-4cc9-a5fe-88d7aaa37851)
![IMG_20250325_125007](https://github.com/user-attachments/assets/c917300d-bc27-4a8f-8cb4-1f92aa8653af)
![IMG_20250325_125015](https://github.com/user-attachments/assets/db08de53-dfdd-4ab9-a40f-42af0d9264f6)
![IMG_20250325_125022](https://github.com/user-attachments/assets/a103f03d-e4b0-4906-a862-4a50af013188)

https://github.com/user-attachments/assets/0a5a9ca7-103f-4d24-9187-4cf8fe35fb78

The project was also tested on a Raspberry Pi Zero 2 with a Waveshare 3.5 inch touch resistive display

![IMG_20250316_171350](https://github.com/user-attachments/assets/cbdb2a03-d1af-4210-a5a3-ca4c7e41deaa)
![IMG_20250317_123025](https://github.com/user-attachments/assets/568895ba-1b62-489a-af6f-1fdb75dd3ca9)
![IMG_20250316_171336](https://github.com/user-attachments/assets/7a811058-36c5-4e82-b01d-2b48dfa1cb19)
![IMG_20250317_123008](https://github.com/user-attachments/assets/8e9f1b81-0a41-4887-ba86-c9ba91fa2a05)

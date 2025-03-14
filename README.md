# 3D Printer UI Demo (Qt 6)

This project is a Qt 6 implementation of the **3D Printer UI Demo** originally designed by [Square Line Studio](https://squareline.io/demos). The goal of this project is to recreate the demo using only Qt 6 QML, without relying on any external resources.
This project was created to explore Qt 6's capabilities in replicating complex and visually appealing UIs. It serves as a learning resource

## About the UI Design
The original UI concept and design are the creative work of **Square Line Studio**. This project is a technical implementation of their design, intended for educational and demonstration purposes. All credit for the visual design and user experience goes to Square Line Studio.

## Disclaimer
This project is not affiliated with or endorsed by Square Line Studio. It is an independent implementation of their UI design, created solely for educational purposes.

## Linux running environment

If you have crossed compiled Qt for a Linux distribution and use to launch the application with Qt creator, then this is the "Run" environment that I used for Raspberry Pi zero 2:

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
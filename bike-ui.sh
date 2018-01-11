#!/bin/bash

BIKE_DIR="/home/anatoly/001"
QMLSCENE="/home/anatoly/Qt/5.10.0/gcc_64/bin/qmlscene"

cd $BIKE_DIR

export QT_QUICK_CONTROLS_STYLE=Material
export QML2_IMPORT_PATH="$BIKE_DIR/plugins:$BIKE_DIR/hmi"
export QT_IM_MODULE="qtvirtualkeyboard"
#export QV4_FORCE_INTERPRETER=1

#debug GPS - correct the path when it's in RPi
export GPS_LOGFILE="/home/pi/Bike/gps.json"

$QMLSCENE "$BIKE_DIR/hmi/Main.qml"


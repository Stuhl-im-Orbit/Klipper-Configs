#!/bin/bash
if [ ! -d "/home/pi/printer_data/config/input_shaper" ]
then
    mkdir /home/pi/printer_data/config/input_shaper
    chown pi:pi /home/pi/printer_data/config/input_shaper
fi
NEWY=$(ls -Art /tmp/calibration_data_y*.csv | tail -n 1)
DATE=$(date +'%Y-%m-%d-%H%M%S')
nice ~/klipper/scripts/calibrate_shaper.py $NEWY -o /home/pi/printer_data/config/input_shaper/calibration_graph_y_$DATE.png

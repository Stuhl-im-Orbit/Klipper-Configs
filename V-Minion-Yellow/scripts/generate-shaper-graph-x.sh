#!/bin/bash
if [ ! -d "/home/pi/printer_data/config/input_shaper" ]
then
    mkdir /home/pi/printer_data/config/input_shaper
    chown pi:pi /home/pi/printer_data/config/input_shaper
fi
NEWX=$(ls -Art /tmp/calibration_data_x_*.csv | tail -n 1)
DATE=$(date +'%Y-%m-%d-%H%M%S')
nice ~/klipper/scripts/calibrate_shaper.py $NEWX -o /home/pi/printer_data/config/input_shaper/calibration_graph_x_$DATE.png

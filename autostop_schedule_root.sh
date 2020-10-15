#!/bin/bash
SCRIPT_PATH=$EXT_SCRIPT_DIR/autostop.py
echo "starting cron job for $SCRIPT_PATH with idle time of $IDLE_TIME"
(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/bin/python $SCRIPT_PATH --time $IDLE_TIME --ignore-connections") | crontab -
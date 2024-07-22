#!/bin/bash

source /home/pi/printer_data/config/3dwork-klipper/scripts/moonraker-ensure-policykit-rules.sh
ensure_moonraker_policiykit_rules

validate_moonraker_config()
{
  echo "Ensuring valid moonraker config.."
  install_version=$(/home/pi/moonraker-env/bin/python -mlmdb -e /home/pi/.moonraker_database/ -d moonraker get validate_install)
  cat /home/pi/printer_data/config/moonraker.conf | grep "\[include 3dwork-klipper/moonraker.conf\]" > /dev/null
  has_include=$?
  if [ $has_include -eq 0 ] && [ "$install_version" = "'validate_install': missing" ]; then
    # Temporarily replace with old config
    echo "Installing old moonraker config.."
	echo $has_include
	echo $install_version
    # cp /home/pi/printer_data/config/3dwork-klipper/old-moonraker.conf /home/pi/printer_data/config/3dwork-klipper/moonraker.conf
  fi
}

validate_moonraker_config

#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "ERROR: This script should be run as root"
  exit
fi

update_rpi() {
    echo "Updating RPi"
    /home/pi/printer_data/config/3dwork-klipper/boards/rpi/make-and-flash-mcu.sh
}

update_octopus_pro_446() {
    if [[ -h "/dev/btt-octopus-pro-446" ]]
    then
        echo "Octopus Pro 446 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-octopus-pro-446/make-and-flash-mcu.sh
    fi
}

update_octopus_pro_429() {
    if [[ -h "/dev/btt-octopus-pro-429" ]]
    then
        echo "Octopus Pro 429 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-octopus-pro-429/make-and-flash-mcu.sh
    fi
}

update_btt_octopus_11() {
    if [[ -h "/dev/btt-octopus-11" ]]
    then
        echo "Octopus v1.1 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-octopus-11/make-and-flash-mcu.sh
    fi
}

update_btt_octopus_11_407() {
    if [[ -h "/dev/btt-octopus-11-407" ]]
    then
        echo "Octopus v1.1 STM32F407 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-octopus-11-407/make-and-flash-mcu.sh
    fi
}

update_fysetc_spider() {
    if [[ -h "/dev/fysetc-spider" ]]
    then
        echo "Fysetc Spider v1.1 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/fysetc-spider/make-and-flash-mcu.sh
    fi
}

update_skr_pro_12() {
    if [[ -h "/dev/btt-skr-pro-12" ]]
    then
        echo "SKR Pro v1.2 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-skr-pro-12/make-and-flash-mcu.sh
    fi
}

update_skr_2_429() {
    if [[ -h "/dev/btt-skr-2-429" ]]
    then
        echo "SKR 2 W/ STM32F429 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-skr-2-429/make-and-flash-mcu.sh
    fi
}

update_btt_ebb42_10() {
    if [[ -h "/dev/btt-ebb42-10" ]]
    then
        echo "BTT EBB42 v1.0 detected"
        /home/pi/printer_data/config/RatOS/boards/btt-ebb42-10/make-and-flash-mcu.sh
    fi
}

update_btt_ebb36_10() {
    if [[ -h "/dev/btt-ebb36-10" ]]
    then
        echo "BTT EBB36 v1.0 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-ebb42-10/make-and-flash-mcu.sh
    fi
}

update_btt_ebb42_11() {
    if [[ -h "/dev/btt-ebb42-11" ]]
    then
        echo "BTT EBB42 v1.1 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-ebb42-11/make-and-flash-mcu.sh
    fi
}

update_btt_ebb36_11() {
    if [[ -h "/dev/btt-ebb36-11" ]]
    then
        echo "BTT EBB36 v1.1 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-ebb36-11/make-and-flash-mcu.sh
    fi
}

update_btt_ebb42_12() {
    if [[ -h "/dev/btt-ebb42-12" ]]
    then
        echo "BTT EBB42 v1.2 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-ebb42-12/make-and-flash-mcu.sh
    fi
}

update_btt_ebb36_12() {
    if [[ -h "/dev/btt-ebb36-12" ]]
    then
        echo "BTT EBB36 v1.2 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-ebb36-12/make-and-flash-mcu.sh
    fi
}

update_mellow_fly_sht_42() {
    if [[ -h "/dev/mellow-fly-sht-42" ]]
    then
        echo "Mellow FLY-SHT42 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/mellow-fly-sht-42/make-and-flash-mcu.sh
    fi
}

update_mellow_fly_sht_36() {
    if [[ -h "/dev/mellow-fly-sht-42" ]]
    then
        echo "Mellow FLY-SHT42 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/mellow-fly-sht-36/make-and-flash-mcu.sh
    fi
}

update_btt_skr_mini_e3_30() {
    if [[ -h "/dev/btt-skr-mini-e3-30" ]]
    then
        echo "BTT SKR Mini E3 V3.0 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-skr-mini-e3-30/make-and-flash-mcu.sh
    fi
}

update_btt_skr_3() {
    if [[ -h "/dev/btt-skr-3" ]]
    then
        echo "BTT SKR 3 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/btt-skr-3/make-and-flash-mcu.sh
    fi
}

update_znp_robin_nano_dw_v2() {
    if [[ -h "/dev/znp_robin_nano_dw_v2" ]]
    then
        echo "ZNP Robin Nano DW v2 detected"
        /home/pi/printer_data/config/3dwork-klipper/boards/znp-robin-nano-dw-v2/make-and-flash-mcu.sh
    fi
}

echo "##### Flashing connected MCU's"
flash_result=$(curl --fail --silent -X POST 'http://localhost:3000/configure/api/trpc/mcu.flash-all-connected' -H 'content-type: application/json')
configurator_success=$?
if [ $configurator_success -eq 0 ]
then
    echo $flash_result | jq -r '.result.data.json'
else
    echo "Installed configurator doesn't support flashing yet, falling back to old method"
    # Run make scripts for the supported boards.
    update_rpi
    update_octopus_pro_446
    update_octopus_pro_429
    update_btt_octopus_11
    update_btt_octopus_11_407
    update_fysetc_spider
    update_skr_pro_12
    update_skr_2_429
    update_btt_ebb42_10
    update_btt_ebb36_10
    update_btt_ebb42_11
    update_btt_ebb36_11
    update_btt_ebb42_12
    update_btt_ebb36_12
    update_btt_skr_3
    update_mellow_fly_sht_42
    update_mellow_fly_sht_36
    update_btt_skr_mini_e3_30
    update_znp_robin_nano_dw_v2
fi

echo "##### Symlinking registered klippy extensions"
extensions_result=$(curl --fail --silent -X POST 'http://localhost:3000/configure/api/trpc/klippy-extensions.symlink' -H 'content-type: application/json')
extensions_success=$?
if [ $extensions_success -eq 0 ]
then
    echo $extensions_result | jq -r '.result.data.json'
else
    echo "Failed to symlink extensions, ignore this if not on 3dwork-klipper 2.0 yet"
fi

echo "##### Symlinking moonraker extensions"
symlink_result=$(curl --fail --silent -X POST 'http://localhost:3000/configure/api/trpc/moonraker-extensions.symlink' -H 'content-type: application/json')
configurator_success=$?
if [ $configurator_success -eq 0 ]
then
    echo $symlink_result | jq -r '.result.data.json'
else
    echo "Failed to symlink moonraker extensions. Is the 3dwork-klipper configurator running?"
fi

#!/bin/bash

# thermal_guard.sh - VM tabanlı termal kontrol ve snapshot tetikleyici

CONFIG="modules/thermal_guard.yaml"
LOG="/var/log/thermal_guard.log"

read_config() {
  MAX_TEMP=$(grep "max_temp_celsius" "$CONFIG" | awk '{print $2}')
  INTERVAL=$(grep "check_interval" "$CONFIG" | awk '{print $2}')
  SENSOR_PATH=$(grep "thermal_zone0" "$CONFIG" | awk '{print $NF}')
}

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG"
}

check_temp() {
  RAW=$(cat "$SENSOR_PATH")
  TEMP=$((RAW / 1000))
  echo "$TEMP"
}

take_snapshot() {
  VM_NAME="work-vm"
  qvm-snapshot "$VM_NAME" "thermal_guard_$(date '+%Y%m%d_%H%M%S')"
  log "Snapshot alındı: $VM_NAME"
}

shutdown_vm() {
  VM_NAME="render-vm"
  qvm-shutdown "$VM_NAME"
  log "VM kapatıldı: $VM_NAME"
}

main_loop() {
  read_config
  while true; do
    TEMP=$(check_temp)
    log "Sıcaklık: $TEMP°C"
    if [ "$TEMP" -ge "$MAX_TEMP" ]; then
      notify-send "⚠️ Kritik sıcaklık: $TEMP°C"
      take_snapshot
      shutdown_vm
    fi
    sleep "$INTERVAL"
  done
}

main_loop

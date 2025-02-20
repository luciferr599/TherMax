source thermax_utils

checkRoot() {
  if command -v magisk > /dev/null; then
  DETECTED_SU="Magisk"
  echo "Magisk   "
  elif command -v ksud > /dev/null; then
  DETECTED_SU="KSU"
  echo "Kernelsu "
  else
  DETECTED_SU="Unknown"
  echo "Root     "
fi
}

checkRootVer() {
  if command -v magisk > /dev/null; then
  DETECTED_SU="Magisk"
  echo "$(magisk -V)"
  elif command -v ksud > /dev/null; then
  DETECTED_SU="KSU"
  echo "ksud -v"
  else
  DETECTED_SU="Unknown"
  echo "unknown"
fi
}

display_info() {
    local text1="$1"  # Teks yang akan ditampilkan (misalnya "Author")
    local text2="$2"  # Teks yang akan ditampilkan (misalnya "lucifer599")
    local total_length=47  # Panjang total yang diinginkan
    local text1_length=${#text1}  # Panjang teks1
    local text2_length=${#text2}  # Panjang teks2
    local padding_length=$((total_length - text1_length - text2_length - 5))  # 5 untuk "  : "
    local padding=$(printf '%*s' "$padding_length" '' | tr ' ' ' ')
    local output="║ ${k}$text1${res}: $text2$padding ║"
    echo -e "$output"
}

checkDaemon() {
  local pid=$(pgrep -f thermax_daemon)
  if [ -n "$pid" ]; then
  echo "$pid"
  else
  echo false
fi
}

checkThermal() {
  if [[ "$(getprop init.svc.thermal-engine)" == "running" ]]; then
  echo -ne "running"
  elif [[ "$(getprop init.svc.thermal-engine)" == "stopped" ]]; then
  echo -ne "stopped"
  elif [[ "$(getprop init.svc.mi_thermald)" == "running" ]]; then
  echo -ne "running"
  elif [[ "$(getprop init.svc.mi_thermald)" == "stopped" ]]; then
  echo -ne "stopped"
  else
  echo -ne "unknown"
fi
}


while true; do
clear
echo -ne "╔══════════════════════════════════════════════╗\n"
echo -ne "║            Disable Thermal Maximum           ║\n"
echo -ne "╠══════════════════════════════════════════════╣\n"
echo -ne "║${k}Author   : lucifer599                        ║\n"
echo -ne "║${k}Telegram : @projectatlas                     ║\n"
echo -ne "║ ${k}Version  : v1.0 (canary)                     ║\n"
display_info "Thermal  " "$(checkThermal)"
display_info "Profile  " "$(settings get global thermax_profile)"
display_info "$(checkRoot)" "$(checkRootVer)"
display_info "Daemon   " "$(checkDaemon)"
echo -ne "╠══════════════════════════════════════════════╣\n"
echo -ne "║               Select an option               ║\n"
echo -ne "╠══════════════════════════════════════════════╣\n"
echo -ne "║ [${k}1] 》 Performance mode                      ║\n"
echo -ne "║ [2] 》 Normal mode                           ║\n"
echo -ne "║ [3] 》 Enable thermal                        ║\n"
echo -ne "║ [4] 》 Disable Thermal                       ║\n"
echo -ne "║ [0] 》 Exit                                  ║\n"
echo -ne "║ [5] 》 Restart Daemon                        ║\n"
echo -ne "╠══════════════════════════════════════════════╣\n"
echo -ne "║                 Atlas Project                ║\n"
echo -ne "╚══════════════════════════════════════════════╝\n"
read menu

# Menangani pilihan pengguna
case $menu in
  1)
    performanceMode
    ;;
  2)
    normalMode
    ;;
  3)
    enableThermal
    ;;
  4)
    disableThermal
    ;;
  0)
    echo "Exiting..."
    exit 0
    ;;
  *)
    clear;
    echo "Invalid option selected.";
    sleep 1;
    
    ;;
esac
done
#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Projenin Git-Flow yapısını başlatır
#             ('develop' dalını oluşturur).
#
# #####################################################

# --- Dil ve Konfigürasyon Yükleme ---
# Bu script'in kendi bulunduğu dizini bul (örn: .../easy-git/scripts)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Ana dizindeki config ve dil dosyalarını yükle
source "$SCRIPT_DIR/../config.sh"
source "$SCRIPT_DIR/../lang/$DEFAULT_LANG.sh"

# === YARDIM FONKSİYONU ===
show_help() {
  cat << EOF
init-repo.sh - Proje için Git-Flow yapısını başlatır.

$INIT_HELP_DESC

$INIT_HELP_USAGE:
    ./scripts/init-repo.sh
    ./scripts/init-repo.sh [-h|--help]
EOF
}

# === ARGÜMAN KONTROLÜ ===
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# === İŞLEM ADIMLARI ===

# Renk kodları
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}${INIT_CREATING_DEVELOP}${NC}"
git checkout -b develop

echo -e "${GREEN}${INIT_PUSHING_BRANCHES}${NC}"
git push -u origin main
git push -u origin develop

echo -e "${GREEN}${INIT_SETUP_COMPLETE}${NC}"
echo "$INIT_REMINDER_PROTECT_BRANCHES"
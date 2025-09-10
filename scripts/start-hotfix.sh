#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Üretimdeki acil bir hatayı düzeltmek için
#             yeni bir 'hotfix' dalı başlatır.
#
# #####################################################

# --- Dil ve Konfigürasyon Yükleme ---
# Bu script'in kendi bulunduğu dizini bul
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Ana dizindeki config ve dil dosyalarını yükle
source "$SCRIPT_DIR/../config.sh"
source "$SCRIPT_DIR/../lang/$DEFAULT_LANG.sh"

# === YARDIM FONKSİYONU ===
show_help() {
  cat << EOF
$SH_HELP_TITLE

$INIT_HELP_USAGE:
    ./scripts/start-hotfix.sh <hotfix-adi>
    ./scripts/start-hotfix.sh [-h|--help]

AÇIKLAMA:
    $SH_HELP_DESC_LINE_1
    $SH_HELP_DESC_LINE_2
    
    $SH_HELP_DESC_LINE_3
    $SH_HELP_STEP_1
    $SH_HELP_STEP_2

$SF_HELP_EXAMPLE_TITLE
    $SH_HELP_EXAMPLE_DESC
    ./scripts/start-hotfix.sh acil-login-hatasi

EOF
}

# === RENK KODLARI ===
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# === ARGÜMAN KONTROLÜ ===
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

if [ -z "$1" ]; then
  echo -e "${RED}${MSG_ERROR_PREFIX} ${SH_ERROR_NO_NAME}${NC}"
  echo "$SH_INFO_USAGE"
  echo "$SR_INFO_MORE_INFO"
  exit 1
fi

# === İŞLEM ADIMLARI ===

HOTFIX_BRANCH="hotfix/$1"

# 'main' dalını güncelle (finish-release.sh'den gelen değişkeni tekrar kullanıyoruz)
echo -e "${GREEN}${FR_INFO_SWITCHING_TO_MAIN}${NC}"
git checkout main
git pull origin main

# Yeni hotfix dalını oluştur
echo -e "${GREEN}${SH_INFO_CREATING_BRANCH} $HOTFIX_BRANCH ${NC}"
git checkout -b "$HOTFIX_BRANCH"

# Başarı mesajı
echo -e "${GREEN}>> '$HOTFIX_BRANCH' ${SH_INFO_READY}${NC}"
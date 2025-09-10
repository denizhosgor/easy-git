#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Yeni bir 'release' (sürüm) dalı oluşturarak
#             yayın sürecini başlatır.
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
$SR_HELP_TITLE

$INIT_HELP_USAGE:
    ./scripts/start-release.sh <versiyon-numarasi>
    ./scripts/start-release.sh [-h|--help]

AÇIKLAMA:
    $SR_HELP_DESC_LINE_1
    
    $SR_HELP_DESC_LINE_2
    $SR_HELP_STEP_1
    $SR_HELP_STEP_2
    $SR_HELP_STEP_3

$SF_HELP_EXAMPLE_TITLE
    $SR_HELP_EXAMPLE_DESC
    ./scripts/start-release.sh v1.2.6

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
  echo -e "${RED}${MSG_ERROR_PREFIX} ${SR_ERROR_NO_VERSION}${NC}"
  echo "$SR_INFO_USAGE"
  echo "$SR_INFO_MORE_INFO"
  exit 1
fi

# === İŞLEM ADIMLARI ===

RELEASE_BRANCH="release/$1"

# 'develop' dalını güncelle (Diğer script'lerden gelen değişkeni tekrar kullanıyoruz)
echo -e "${GREEN}${SF_INFO_SWITCHING_TO_DEV}${NC}"
git checkout develop
git pull origin develop

# Yeni release dalını oluştur
echo -e "${GREEN}${SR_INFO_CREATING_BRANCH} $RELEASE_BRANCH ${NC}"
git checkout -b "$RELEASE_BRANCH"

# Yeni dalı uzak sunucuya gönder (Diğer script'lerden gelen değişkeni tekrar kullanıyoruz)
echo -e "${GREEN}${SF_INFO_PUSHING_BRANCH}${NC}"
git push -u origin "$RELEASE_BRANCH"

# Başarı mesajı
echo -e "${GREEN}>> '$RELEASE_BRANCH' ${SR_INFO_READY}${NC}"
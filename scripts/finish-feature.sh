#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Geliştirilmesi tamamlanan 'feature' dalını
#             'develop' dalı ile birleştirir ve siler.
#
# #####################################################

# --- Dil ve Konfigürasyon Yükleme ---
# Bu script'in kendi bulunduğu dizini bul
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Ana dizindeki config ve dil dosyalarını yükle
source "$SCRIPT_DIR/../config.sh"
source "$SCRIPT_DIR/../lang/$DEFAULT_LANG.sh"

# === YARDIM FONKSİYONU ===
# Scriptin nasıl kullanılacağını açıklayan bir metin gösterir.
show_help() {
  cat << EOF
$FF_HELP_TITLE

$INIT_HELP_USAGE:
    ./scripts/finish-feature.sh <özellik-adı>
    ./scripts/finish-feature.sh [-h|--help]

AÇIKLAMA:
    $FF_HELP_DESC_LINE_1
    
    $FF_HELP_STEP_1
    $FF_HELP_STEP_2
    $FF_HELP_STEP_3
    $FF_HELP_STEP_4

$FF_HELP_IMPORTANT_NOTE_TITLE
    $FF_HELP_IMPORTANT_NOTE_DESC

$SF_HELP_EXAMPLE_TITLE
    $FF_HELP_EXAMPLE_DESC
    ./scripts/finish-feature.sh kullanici-profili

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
  echo -e "${RED}${MSG_ERROR_PREFIX} ${FF_ERROR_NO_NAME}${NC}"
  echo "$SF_INFO_SEE_HELP"
  exit 1
fi

# === İŞLEM ADIMLARI ===

FEATURE_BRANCH="feature/$1"

# 'develop' dalını güncelle (start-feature.sh'den gelen değişkeni tekrar kullanıyoruz)
echo -e "${GREEN}${SF_INFO_SWITCHING_TO_DEV}${NC}"
git checkout develop
git pull origin develop

# Özellik dalını 'develop' ile birleştir
echo -e "${GREEN}>> '$FEATURE_BRANCH' ${FF_INFO_MERGING}${NC}"
git merge --no-ff "$FEATURE_BRANCH"

# 'develop' dalını uzak sunucuya gönder
echo -e "${GREEN}${FF_INFO_PUSHING_DEV}${NC}"
git push origin develop

# Özellik dalını sil
echo -e "${GREEN}${FF_INFO_DELETING_BRANCH}${NC}"
git branch -d "$FEATURE_BRANCH"
git push origin --delete "$FEATURE_BRANCH"

# Başarı mesajı
echo -e "${GREEN}${FF_INFO_SUCCESS} '$FEATURE_BRANCH' ${FF_INFO_SUCCESS_DETAILS}${NC}"
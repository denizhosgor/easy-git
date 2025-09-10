#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Yeni bir 'feature' dalı oluşturur.
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
$SF_HELP_TITLE

$INIT_HELP_USAGE:
    ./scripts/start-feature.sh <özellik-adı>
    ./scripts/start-feature.sh [-h|--help]

AÇIKLAMA:
    $SF_HELP_DESC_LINE_1
    
    $SF_HELP_STEP_1
    $SF_HELP_STEP_2
    $SF_HELP_STEP_3
    $SF_HELP_STEP_4

$SF_HELP_EXAMPLE_TITLE
    $SF_HELP_EXAMPLE_DESC
    ./scripts/start-feature.sh kullanici-profili

EOF
}

# === RENK KODLARI ===
# Terminalde daha okunaklı çıktılar üretmek için renk değişkenleri tanımlanır.
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color (Rengi sıfırlar)

# === ARGÜMAN KONTROLÜ ===
# Script'e bir argüman verilip verilmediğini kontrol eder.
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Eğer hiçbir argüman verilmemişse, hata mesajı gösterir ve script'i sonlandırır.
if [ -z "$1" ]; then
  echo -e "${RED}${MSG_ERROR_PREFIX} ${SF_ERROR_NO_NAME}${NC}"
  echo "$SF_INFO_SEE_HELP"
  exit 1 # Hata kodu ile çıkış yap
fi

# === İŞLEM ADIMLARI ===

# 1. Dal adını oluştur
FEATURE_BRANCH="feature/$1"

# 2. 'develop' dalını güncelle
echo -e "${GREEN}${SF_INFO_SWITCHING_TO_DEV}${NC}"
git checkout develop
git pull origin develop

# 3. Yeni özellik dalını oluştur
echo -e "${GREEN}${SF_INFO_CREATING_BRANCH} $FEATURE_BRANCH ${NC}"
git checkout -b "$FEATURE_BRANCH"

# 4. Yeni dalı uzak sunucuya gönder
echo -e "${GREEN}${SF_INFO_PUSHING_BRANCH}${NC}"
git push -u origin "$FEATURE_BRANCH"

# 5. Başarı mesajı
echo -e "${GREEN}>> '$FEATURE_BRANCH' ${SF_INFO_READY}${NC}"
#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Tamamlanan bir 'release' sürecini 'main' ve
#             'develop' dallarına birleştirir ve yayınlar.
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
$FR_HELP_TITLE

$INIT_HELP_USAGE:
    ./scripts/finish-release.sh <versiyon-numarasi>
    ./scripts/finish-release.sh [-h|--help]

AÇIKLAMA:
    $FR_HELP_DESC_LINE_1

    $FR_HELP_DESC_LINE_2
    $FR_HELP_STEP_1
    $FR_HELP_STEP_2
    $FR_HELP_STEP_3
    $FR_HELP_STEP_4
    $FR_HELP_STEP_5

$SF_HELP_EXAMPLE_TITLE
    $FR_HELP_EXAMPLE_DESC
    ./scripts/finish-release.sh v1.2.6

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
  # start-release.sh'den gelen değişkenleri tekrar kullanıyoruz
  echo -e "${RED}${MSG_ERROR_PREFIX} ${SR_ERROR_NO_VERSION}${NC}"
  echo "$SR_INFO_USAGE"
  echo "$SR_INFO_MORE_INFO"
  exit 1
fi

# === İŞLEM ADIMLARI ===

VERSION="$1"
RELEASE_BRANCH="release/$VERSION"

# 1. Main dalına merge et ve etiketle
echo -e "${GREEN}${FR_INFO_SWITCHING_TO_MAIN}${NC}"
git checkout main
git pull origin main

echo -e "${GREEN}>> '$RELEASE_BRANCH' ${FR_INFO_MERGING_TO_MAIN}${NC}"
git merge --no-ff "$RELEASE_BRANCH"

echo -e "${GREEN}${FR_INFO_TAGGING} '$VERSION'${NC}"
git tag -a "$VERSION" -m "Release $VERSION"

# 2. Develop dalına merge et
# start-feature.sh'den gelen değişkeni tekrar kullanıyoruz
echo -e "${GREEN}${SF_INFO_SWITCHING_TO_DEV}${NC}"
git checkout develop
git pull origin develop

echo -e "${GREEN}>> '$RELEASE_BRANCH' ${FR_INFO_MERGING_TO_DEV}${NC}"
git merge --no-ff "$RELEASE_BRANCH"

# 3. Tüm değişiklikleri ve etiketi sunucuya gönder
echo -e "${GREEN}${FR_INFO_PUSHING_ALL}${NC}"
git push origin main
git push origin develop
git push origin "$VERSION"

# 4. Geçici release dalını sil
echo -e "${GREEN}${FR_INFO_DELETING_BRANCH}${NC}"
git branch -d "$RELEASE_BRANCH"
git push origin --delete "$RELEASE_BRANCH"

echo -e "${GREEN}${FR_INFO_SUCCESS_PREFIX} $VERSION ${FR_INFO_SUCCESS_SUFFIX}${NC}"
#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Tamamlanan bir 'hotfix' sürecini 'main' ve
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
$FH_HELP_TITLE

$INIT_HELP_USAGE:
    ./scripts/finish-hotfix.sh <hotfix-adı> <yeni-versiyon-numarası>
    ./scripts/finish-hotfix.sh [-h|--help]

AÇIKLAMA:
    $FH_HELP_DESC_LINE_1

    $SR_HELP_DESC_LINE_2
    $FH_HELP_STEP_1
    $FH_HELP_STEP_2
    $FH_HELP_STEP_3
    $FH_HELP_STEP_4
    $FH_HELP_STEP_5

$FH_HELP_ARGS_TITLE
    $FH_HELP_ARG_1
    $FH_HELP_ARG_2

$SF_HELP_EXAMPLE_TITLE
    $FH_HELP_EXAMPLE_DESC
    ./scripts/finish-hotfix.sh acil-login-hatasi v1.2.8

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

if [ -z "$1" ] || [ -z "$2" ]; then
  echo -e "${RED}${MSG_ERROR_PREFIX} ${FH_ERROR_MISSING_ARGS}${NC}"
  echo "$FH_INFO_USAGE"
  echo "$SR_INFO_MORE_INFO"
  exit 1
fi


# === İŞLEM ADIMLARI ===

HOTFIX_BRANCH="hotfix/$1"
VERSION="$2"

# 1. Main dalına merge et ve etiketle
echo -e "${GREEN}${FH_INFO_SWITCHING_TO_MAIN}${NC}"
git checkout main
echo -e "${GREEN}>> '$HOTFIX_BRANCH' ${FR_INFO_MERGING_TO_MAIN}${NC}"
git merge --no-ff "$HOTFIX_BRANCH"

echo -e "${GREEN}${FH_INFO_TAGGING} '$VERSION'${NC}"
git tag -a "$VERSION" -m "Hotfix release $VERSION"

# 2. Develop dalına merge et
echo -e "${GREEN}${FH_INFO_SWITCHING_TO_DEV}${NC}"
git checkout develop
echo -e "${GREEN}>> '$HOTFIX_BRANCH' ${FR_INFO_MERGING_TO_DEV}${NC}"
git merge --no-ff "$HOTFIX_BRANCH"

# 3. Tüm değişiklikleri ve etiketi sunucuya gönder
# finish-release.sh'den gelen değişkeni tekrar kullanıyoruz
echo -e "${GREEN}${FR_INFO_PUSHING_ALL}${NC}"
git push origin main
git push origin develop
git push origin "$VERSION"

# 4. Geçici hotfix dalını sil
echo -e "${GREEN}${FH_INFO_DELETING_BRANCH}${NC}"
git branch -d "$HOTFIX_BRANCH"

echo -e "${GREEN}${FH_INFO_SUCCESS_PREFIX} $VERSION ${FH_INFO_SUCCESS_SUFFIX}${NC}"
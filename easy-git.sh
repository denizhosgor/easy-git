#!/bin/bash
# #####################################################
#
#   Yazan   : Deniz Hoşgör
#   Tarih   : 2025.09.10
#   Açıklama: Git-Flow script'lerini çalıştırmak için
#             interaktif bir menü sunar.
#
# #####################################################

# --- Konfigürasyon ve Dil Yükleme ---
SCRIPTS_DIR="scripts"

# Varsayılan ayarları yükle
source ./config.sh

# Komut satırından dil belirtilmiş mi kontrol et (./git-menu.sh en gibi)
# Belirtilmemişse varsayılanı kullan
SELECTED_LANG=${1:-$DEFAULT_LANG}

# Dil dosyasının yolunu oluştur
LANG_FILE="lang/$SELECTED_LANG.sh"

# Dil dosyası var mı kontrol et, yoksa hata ver ve çık
if [ -f "$LANG_FILE" ]; then
  source "$LANG_FILE"
else
  echo "Hata: '$SELECTED_LANG' için dil dosyası bulunamadı: $LANG_FILE"
  echo "Error: Language file not found for '$SELECTED_LANG': $LANG_FILE"
  exit 1
fi
# --- Bitti: Dil Yükleme ---


# --- Renk Kodları ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# --- Ana Menü Döngüsü ---
while true; do
  clear
  echo -e "${YELLOW}=============== $MENU_TITLE ===============${NC}"
  echo ""
  echo -e "  ${BLUE}$MENU_SECTION_SETUP:${NC}"
  echo "    [1] $MENU_ITEM_1"
  echo ""
  echo -e "  ${BLUE}$MENU_SECTION_WORKFLOW:${NC}"
  echo "    [2] $MENU_ITEM_2"
  echo "    [3] $MENU_ITEM_3"
  echo "    [4] $MENU_ITEM_4"
  echo "    [5] $MENU_ITEM_5"
  echo "    [6] $MENU_ITEM_6"
  echo "    [7] $MENU_ITEM_7"
  echo ""
  echo -e "------------------------------------------------"
  echo -e "    [0] ${RED}$MENU_ITEM_EXIT${NC}"
  echo ""

  read -p "$MENU_PROMPT [0-7]: " choice

  case $choice in
    1)
      read -p ">> $PROMPT_CONFIRM_INIT " confirm
      if [[ "$confirm" == "e" || "$confirm" == "E" || "$confirm" == "y" || "$confirm" == "Y" ]]; then
        ./$SCRIPTS_DIR/init-repo.sh
      else
        echo -e "${YELLOW}$MSG_OPERATION_CANCELLED${NC}"
      fi
      ;;
    2)
      read -p ">> $PROMPT_FEATURE_NAME: " feature_name
      if [ -n "$feature_name" ]; then ./$SCRIPTS_DIR/start-feature.sh "$feature_name"; else echo -e "${RED}$MSG_ERROR_PREFIX $PROMPT_FEATURE_NAME $MSG_CANNOT_BE_EMPTY${NC}"; fi
      ;;
    3)
      read -p ">> $PROMPT_FINISH_FEATURE_NAME: " feature_name
      if [ -n "$feature_name" ]; then ./$SCRIPTS_DIR/finish-feature.sh "$feature_name"; else echo -e "${RED}$MSG_ERROR_PREFIX $PROMPT_FINISH_FEATURE_NAME $MSG_CANNOT_BE_EMPTY${NC}"; fi
      ;;
    4)
      read -p ">> $PROMPT_RELEASE_VERSION: " version
      if [ -n "$version" ]; then ./$SCRIPTS_DIR/start-release.sh "$version"; else echo -e "${RED}$MSG_ERROR_PREFIX $PROMPT_RELEASE_VERSION $MSG_CANNOT_BE_EMPTY${NC}"; fi
      ;;
    5)
      read -p ">> $PROMPT_FINISH_RELEASE_VERSION: " version
      if [ -n "$version" ]; then ./$SCRIPTS_DIR/finish-release.sh "$version"; else echo -e "${RED}$MSG_ERROR_PREFIX $PROMPT_FINISH_RELEASE_VERSION $MSG_CANNOT_BE_EMPTY${NC}"; fi
      ;;
    6)
      read -p ">> $PROMPT_HOTFIX_NAME: " hotfix_name
      if [ -n "$hotfix_name" ]; then ./$SCRIPTS_DIR/start-hotfix.sh "$hotfix_name"; else echo -e "${RED}$MSG_ERROR_PREFIX $PROMPT_HOTFIX_NAME $MSG_CANNOT_BE_EMPTY${NC}"; fi
      ;;
    7)
      read -p ">> $PROMPT_FINISH_HOTFIX_NAME: " hotfix_name
      read -p ">> $PROMPT_NEW_VERSION: " version
      if [ -n "$hotfix_name" ] && [ -n "$version" ]; then ./$SCRIPTS_DIR/finish-hotfix.sh "$hotfix_name" "$version"; else echo -e "${RED}$MSG_ERROR_PREFIX $PROMPT_FINISH_HOTFIX_NAME $MSG_CANNOT_BE_EMPTY${NC}"; fi
      ;;
    0)
      echo -e "${GREEN}$MSG_EXITING${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}$MSG_INVALID_CHOICE Lütfen 0-7 arasında bir numara girin.${NC}"
      ;;
  esac

  echo ""
  read -p "$PROMPT_CONTINUE"
done
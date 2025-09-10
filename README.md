┌───────────────────────────────────[ README.md ]───────────────────────────────────┐
│                                                                                   │
│ # easy-git                                                                        │
│                                                                                   │
│ [![Made with Shell Script](https://img.shields.io/badge/Made%20with-Shell%20Script-1f425f.svg?style=for-the-badge&logo=gnu-bash)](https://www.gnu.org/software/bash/) │
│                                                                                   │
│ Git-Flow iş akışınızı otomatikleştiren ve basitleştiren çok dilli, interaktif bir komut satırı aracı. │
│                                                                                   │
│ `easy-git`, Git'in güçlü ancak karmaşık olabilen Git-Flow dallanma modelini kullanan geliştiriciler ve takımlar için tasarlanmıştır. Tek bir menü üzerinden `feature`, `release` ve `hotfix` gibi dalların yönetimini otomatikleştirerek hata yapma olasılığını azaltır ve geliştirme süreçlerinizi standartlaştırır. │
│                                                                                   │
│ ---                                                                               │
│                                                                                   │
│ <div align="center">                                                              │
│                                                                                   │
│ **🇹🇷 Türkçe &nbsp;&nbsp; | &nbsp;&nbsp; [🇬🇧 English](#-english) &nbsp;&nbsp; | &nbsp;&nbsp; [🇩🇪 Deutsch](#-deutsch) &nbsp;&nbsp; | &nbsp;&nbsp; [🇪🇸 Español](#-español) &nbsp;&nbsp; | &nbsp;&nbsp; [🇫🇷 Français](#-français) &nbsp;&nbsp; | &nbsp;&nbsp; [🇷🇺 Русский](#-русский)** │
│                                                                                   │
│ </div>                                                                            │
│                                                                                   │
│ ---                                                                               │
│                                                                                   │
│ ## 🇹🇷 Türkçe                                                                     │
│                                                                                   │
│ ### ✨ Özellikler                                                                 │
│                                                                                   │
│ * **İnteraktif Menü:** Tüm Git-Flow işlemlerini basit, numaralandırılmış bir menü üzerinden yönetin. │
│ * **Git-Flow Otomasyonu:** Dalları oluşturma, birleştirme ve silme gibi tekrar eden görevleri standart bir şekilde otomatikleştirir. │
│ * **Çok Dilli Destek:** Proje, farklı dillerde kullanılabilir: Türkçe, İngilizce, Almanca, İspanyolca, Fransızca ve Rusça. │
│ * **Modüler Yapı:** Her işlem, kendi içinde yönetilen ve özelleştirilebilen ayrı bir script dosyasıdır. │
│ * **Hata Önleme:** Yönlendirmeli menü sayesinde yanlış komut kullanma veya adımları atlama gibi hataları en aza indirir. │
│ * **Yardım Menüleri:** Her bir alt script, ne işe yaradığını ve nasıl kullanıldığını açıklayan kendi yardım menüsüne (`-h`, `--help`) sahiptir. │
│                                                                                   │
│ ### 🗂️ Dosya Yapısı                                                              │
│                                                                                   │
│ Projenin doğru çalışması için dosyaların aşağıdaki gibi düzenlendiğinden emin olun: │
│                                                                                   │
│ ```                                                                               │
│ easy-git/                                                                         │
│ │                                                                                 │
│ ├── git-menu.sh        # Ana menüyü çalıştıran script                             │
│ ├── config.sh          # Varsayılan dil ayarı                                     │
│ ├── README.md          # Bu dosya                                                 │
│ │                                                                                 │
│ ├── scripts/           # Tüm işlem script'lerinin olduğu klasör                   │
│ │   ├── init-repo.sh                                                              │
│ │   ├── start-feature.sh                                                          │
│ │   ├── finish-feature.sh                                                         │
│ │   ├── start-release.sh                                                          │
│ │   ├── finish-release.sh                                                         │
│ │   ├── start-hotfix.sh                                                           │
│ │   └── finish-hotfix.sh                                                          │
│ │                                                                                 │
│ └── lang/              # Dil dosyalarının olduğu klasör                           │
│     ├── tr.sh                                                                     │
│     ├── en.sh                                                                     │
│     ├── de.sh                                                                     │
│     ├── es.sh                                                                     │
│     ├── fr.sh                                                                     │
│     └── ru.sh                                                                     │
│ ```                                                                               │
│                                                                                   │
│ ###  kurulum                                                                      │
│                                                                                   │
│ 1.  Proje dosyalarını bilgisayarınıza indirin veya klonlayın.                      │
│ 2.  Terminalde proje klasörünün içine girin: `cd easy-git`                         │
│ 3.  Tüm script dosyalarını çalıştırılabilir hale getirin:                          │
│     ```bash                                                                       │
│     chmod +x git-menu.sh scripts/*.sh                                             │
│     ```                                                                           │
│                                                                                   │
│ ### 🚀 Kullanım                                                                   │
│                                                                                   │
│ Ana menüyü varsayılan dilde (Türkçe) çalıştırmak için:                              │
│ ```bash                                                                           │
│ ./git-menu.sh                                                                     │
│ ```                                                                               │
│                                                                                   │
│ Farklı bir dilde çalıştırmak için dil kodunu argüman olarak ekleyin:                │
│ ```bash                                                                           │
│ # İngilizce olarak başlatmak için                                                  │
│ ./git-menu.sh en                                                                  │
│                                                                                   │
│ # Almanca olarak başlatmak için                                                   │
│ ./git-menu.sh de                                                                  │
│ ```                                                                               │
│                                                                                   │
│ Varsayılan dili değiştirmek için `config.sh` dosyasındaki `DEFAULT_LANG` değişkenini düzenleyebilirsiniz. │
│                                                                                   │
│ ### 🛠️ Desteklenen İşlemler                                                       │
│                                                                                   │
│ | Menü Seçeneği | Komut | Açıklama |                                              │
│ | :--- | :--- | :--- |                                                            │
│ | **Kurulum** | `init-repo` | Projeyi `main` ve `develop` dallarıyla başlatır. Sadece bir kez çalıştırılır. | │
│ | **Feature** | `start-feature` | `develop` dalından yeni bir özellik dalı (`feature/*`) oluşturur. | │
│ | | `finish-feature` | Özellik dalını `develop` ile birleştirir ve dalı siler. |   │
│ | **Release** | `start-release` | `develop` dalından yeni bir sürüm dalı (`release/*`) oluşturur. | │
│ | | `finish-release` | Sürüm dalını `main` ve `develop` ile birleştirir, etiketler ve dalı siler. | │
│ | **Hotfix** | `start-hotfix` | `main` dalından acil bir düzeltme dalı (`hotfix/*`) oluşturur. | │
│ | | `finish-hotfix` | Düzeltmeyi `main` ve `develop` ile birleştirir, yeni sürümü etiketler ve dalı siler. | │
│                                                                                   │
│ ---                                                                               │
│ ---                                                                               │
│                                                                                   │
│ ## 🇬🇧 English                                                                    │
│                                                                                   │
│ ### ✨ Features                                                                  │
│                                                                                   │
│ * **Interactive Menu:** Manage all Git-Flow operations through a simple, numbered menu. │
│ * **Git-Flow Automation:** Automates repetitive tasks like creating, merging, and deleting branches in a standard way. │
│ * **Multi-Language Support:** The project can be used in various languages: Turkish, English, German, Spanish, French, and Russian. │
│ * **Modular Architecture:** Each operation is a separate, customizable script file. │
│ * **Error Prevention:** The guided menu minimizes errors like using the wrong command or skipping steps. │
│ * **Help Menus:** Each sub-script has its own help menu (`-h`, `--help`) explaining its purpose and usage. │
│                                                                                   │
│ ### 🗂️ File Structure                                                           │
│                                                                                   │
│ Ensure the files are arranged as follows for the project to work correctly:       │
│ (See the file structure in the Turkish section)                                   │
│                                                                                   │
│ ### Installation                                                                  │
│                                                                                   │
│ 1.  Download or clone the project files to your computer.                         │
│ 2.  Navigate into the project folder in your terminal: `cd easy-git`              │
│ 3.  Make all script files executable:                                             │
│     ```bash                                                                       │
│     chmod +x git-menu.sh scripts/*.sh                                             │
│     ```                                                                           │
│                                                                                   │
│ ### 🚀 Usage                                                                      │
│                                                                                   │
│ To run the main menu in the default language (Turkish):                           │
│ ```bash                                                                           │
│ ./git-menu.sh                                                                     │
│ ```                                                                               │
│                                                                                   │
│ To run it in a different language, add the language code as an argument:          │
│ ```bash                                                                           │
│ # To start in English                                                             │
│ ./git-menu.sh en                                                                  │
│                                                                                   │
│ # To start in German                                                              │
│ ./git-menu.sh de                                                                  │
│ ```                                                                               │
│                                                                                   │
│ You can change the default language by editing the `DEFAULT_LANG` variable in the `config.sh` file. │
│                                                                                   │
│ ### 🛠️ Supported Operations                                                      │
│                                                                                   │
│ | Menu Option | Command | Description |                                          │
│ | :--- | :--- | :--- |                                                            │
│ | **Setup** | `init-repo` | Initializes the project with `main` and `develop` branches. Run only once. | │
│ | **Feature** | `start-feature` | Creates a new feature branch (`feature/*`) from `develop`. | │
│ | | `finish-feature` | Merges the feature branch into `develop` and deletes the branch. | │
│ | **Release** | `start-release` | Creates a new release branch (`release/*`) from `develop`. | │
│ | | `finish-release` | Merges the release branch into `main` and `develop`, tags it, and deletes the branch. | │
│ | **Hotfix** | `start-hotfix` | Creates an emergency hotfix branch (`hotfix/*`) from `main`. | │
│ | | `finish-hotfix` | Merges the hotfix into `main` and `develop`, tags the new version, and deletes the branch. | │
│                                                                                   │
└───────────────────────────────────────────────────────────────────────────────────┘

#!/usr/bin/env bash
set -euo pipefail

# --- Настройки ---
CHANGE_SHELL=true       # сменить оболочку на zsh (true/false)
USER_HOME="${HOME}"
OMZ_DIR="${USER_HOME}/.oh-my-zsh"
ZSHRC="${USER_HOME}/.zshrc"
# URL установщика (используется только для скачивания шаблонов)
OMZ_INSTALL_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

# --- Проверки ---
echo "Проверка zsh..."
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh не найден. Пытаюсь установить..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh curl git
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y zsh curl git
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm zsh curl git
  elif command -v brew >/dev/null 2>&1; then
    brew install zsh curl git
  else
    echo "Неизвестный пакетный менеджер. Установите zsh вручную." >&2
    exit 1
  fi
else
  echo "zsh уже установлен."
fi

# --- Резервное копирование существующего OMZ / .zshrc ---
if [ -d "${OMZ_DIR}" ]; then
  echo "Найдена папка ${OMZ_DIR}. Создаю резервную копию."
  mv "${OMZ_DIR}" "${OMZ_DIR}.bak.$(date +%s)"
fi
if [ -f "${ZSHRC}" ]; then
  echo "Найден ${ZSHRC}. Создаю резервную копию."
  mv "${ZSHRC}" "${ZSHRC}.bak.$(date +%s)"
fi

# --- Скачивание и развёртывание Oh My Zsh ---
echo "Скачиваю и развёртываю Oh My Zsh в ${OMZ_DIR}..."
mkdir -p "${OMZ_DIR}"
# Используем git clone — более надёжно и без интерактива
if command -v git >/dev/null 2>&1; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "${OMZ_DIR}"
else
  # fallback: загрузить install.sh и выполнить только необходимые шаги
  echo "git не найден. Попытка загрузки шаблонов через curl..."
  tmpdir="$(mktemp -d)"
  curl -fsSL https://github.com/ohmyzsh/ohmyzsh/archive/refs/heads/master.tar.gz | tar -xz -C "${tmpdir}"
  mv "${tmpdir}/ohmyzsh-master"/* "${OMZ_DIR}/"
  rm -rf "${tmpdir}"
fi

# --- Создание .zshrc ---
echo "Создаю ${ZSHRC}..."
cat > "${ZSHRC}" <<'EOF'
# ~/.zshrc (создано автоматически)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
EOF

# --- Установка темы / плагинов (опционально) ---
# Пример: установить zsh-autosuggestions и zsh-syntax-highlighting
echo "Устанавливаю популярные плагины..."
git clone https://github.com/zsh-users/zsh-autosuggestions "${OMZ_DIR}/custom/plugins/zsh-autosuggestions" || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${OMZ_DIR}/custom/plugins/zsh-syntax-highlighting" || true

# Добавить плагины в .zshrc (если ещё нет)
if ! grep -q "zsh-autosuggestions" "${ZSHRC}"; then
  sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)/' "${ZSHRC}"
fi

# --- Смена оболочки на zsh ---
if [ "${CHANGE_SHELL}" = true ]; then
  if [ "$(basename "$SHELL")" != "zsh" ]; then
    echo "Меняем оболочку на zsh для пользователя $(whoami)..."
    if command -v chsh >/dev/null 2>&1; then
      chsh -s "$(command -v zsh)" "$(whoami)" || {
        echo "chsh не сработал. Вы можете вручную выполнить: chsh -s $(command -v zsh) $(whoami)"
      }
    else
      echo "chsh не найден. Выполните вручную: chsh -s $(command -v zsh) $(whoami)"
    fi
  else
    echo "Текущая оболочка уже zsh."
  fi
fi

echo "Установка завершена. Перезапустите терминал или выполните: exec zsh"

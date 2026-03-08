#!/bin/bash
SHELLNAME="Kalafina"
SHELL_PATH=$HOME/.config/kalafina
BACKUP_PATH=$HOME/.config/kalafina/backup
USER_PATH=$HOME/.config/kalafina/user
CONFIG_PATH=$HOME/.config
CONFIG_FOLDERS=('fuzzel' 'hypr' 'kitty' 'matugen' 'wallpapers' 'waypaper' 'quickshell') 

before_install() {
  if [[ ! -f pkglist ]]; then 
    echo "Error: pkglist cannot be found (try executing the script inside source (src) folder)"
    exit 1
  fi

  clear
  echo "Welcome to $SHELLNAME installer."
  echo -e "Its recommended to run this script from $SHELL_PATH\n"
  echo -e "This script will install the following packages (yay or paru needed):"
  while IFS= read -r line; do
     echo "$line" 
  done < <(grep -Ev "^#|^$" pkglist)
  
  echo ""
  read -p "Do you agree? (default: no) [y/n]: " consent
  
  if [[ "${consent,,}" == "y" ]]; then
    return 0
  fi
  
  echo -e "Installation has been aborted.\n"
  exit 1
}


install_dependencies() {
  local pkgs=$(grep -vE '^#|^$' pkglist | xargs)
  
  if [ -n "$pkgs" ]; then
    if command -v yay > /dev/null; then 
      yay -S --needed $pkgs
      return 0
    fi

    if command -v paru > /dev/null; then
      paru -S --needed $pkgs
      return 0
    fi

    echo "paru or yay cannot be found, the installation can't continue."
    exit 1
  fi
}

install_dotfiles() {
  echo -e "\nThe installer will create symlinks for custom configuration"
  echo -e "\tfrom -> $USER_PATH"
  echo -e "\tto -> $CONFIG_PATH"

  echo -e "\nExisting folders will be backup inside -> $BACKUP_PATH"
  read -p "Press [ENTER] to continue" dummyprompt
  
  mkdir -p "$BACKUP_PATH"
  mkdir -p "$USER_PATH"
  echo -e "This folder has been generated on $SHELLNAME installation\nContains user folders backup before installation" > "$BACKUP_PATH/readme.txt"

  
  
  # This create the symlinks from custom configuration folder (USER_PATH)
  echo -e "\nCreating user config...\n"
  for folder in "${CONFIG_FOLDERS[@]}"; do
    if [[ -L "$CONFIG_PATH/$folder" ]]; then
      read -p "$folder already exists as a symlink. Skip? (default: no) [y/n]: " skip
      [[ "$skip" == "y" ]] && continue
    fi
    
    if [[ -d "$CONFIG_PATH/$folder" ]]; then
      echo "Backup created for $folder."
      cp -rL "$CONFIG_PATH/$folder/" "$BACKUP_PATH"
      rm -rf "$CONFIG_PATH/$folder"
    fi

        
    cp -r "$(pwd)/$folder" "$USER_PATH"
    ln -s "$USER_PATH/$folder" "$CONFIG_PATH"
  done
}

post_install() {
  echo "Running Post install commands..."
  pgrep "swww-daemon" > /dev/null || swww-daemon& > /dev/null
  matugen image "$USER_PATH/wallpapers/kalafina.jpg" > /dev/null
  swww img "$USER_PATH/wallpapers/kalafina.jpg"& > /dev/null
  
  kill -SIGUSR1 $(pgrep kitty)
  hyprctl reload
  pgrep "qs" > /dev/null || qs > /dev/null&
}


if before_install; then
  install_dependencies
  install_dotfiles
  post_install

  echo "Installation has been completed"
  echo "Check $CONFIG_PATH/quickshell/shell.json for customization!"
fi

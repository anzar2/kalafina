pragma Singleton
import QtQuick
import Quickshell 

QtObject {
  readonly property var iconsMap: [
  [/^zen$/, "zen-browser"],
  [/^vivaldi-stable$/, "vivaldi"],
  [/^org\.qbittorrent\.qBittorrent$/, "qbittorrent"],
  [/^code-oss$/, "com.visualstudio.code.oss"],
  [/^GitHub Desktop$/, "github-desktop"],
  [/^neovide$/, "nvim"],
  [/^Minecraft.*/, "minecraft"],
  [/^steam_app_(\d+)$/, "steam_icon_$1"]
]

  function get(className) {
    let defaultClassName = Quickshell.iconPath(className, true)
    
    if (Quickshell.iconPath(className, true) !== "") {
      return defaultClassName
    }

    defaultClassName = Quickshell.iconPath(className.toLowerCase(), true) 
    if (defaultClassName !== "") {
      return defaultClassName
    }

    const match = iconsMap.find(([regex]) => regex.test(className))
    if (match) {
      const iconName = className.replace(match[0], match[1])
      return Quickshell.iconPath(iconName, true)
    }

  }
}

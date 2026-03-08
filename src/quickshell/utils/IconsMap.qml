pragma Singleton
import QtQuick
import Quickshell 

QtObject {
  readonly property var iconsMap: ({
    "zen": "zen-browser",
    "vivaldi-stable": "vivaldi",
    "org.qbittorrent.qBittorrent": "qbittorrent",
    "code-oss": "com.visualstudio.code.oss",
    "GitHub Desktop": "github-desktop"
  })

  function get(className) {
    let defaultClassName = Quickshell.iconPath(className, true)
    
    if (Quickshell.iconPath(className, true) !== "") {
      return defaultClassName
    }

    defaultClassName = Quickshell.iconPath(className.toLowerCase(), true) 
    if (defaultClassName !== "") {
      return defaultClassName
    }

    defaultClassName = iconsMap[className]
    if (defaultClassName) return Quickshell.iconPath(defaultClassName, true)

  }
}

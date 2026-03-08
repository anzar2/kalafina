pragma Singleton
import QtQuick

QtObject {
  readonly property var icons: ({
    "google-chrome": "",
    "alacritty": "",
    "kitty": "",
    "fish": "",
    "discord": "",
    "org.gnome.nautilus": ""
  })

  function get(className) {
    return icons[className.toLowerCase()] ?? "󰣆"
  }
}

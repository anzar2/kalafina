pragma Singleton
import QtQuick

QtObject {
  readonly property var icons: ({
    "steam": ""
  })

  function get(className) {
    return icons[className.toLowerCase()] ?? null
  }
}

import Quickshell
import QtQuick
import "../.."
import "../panels/"
import "../osd/"

ShellFrame {
  Loader {
    id: topPanel
    sourceComponent: HPanel {
        panel.anchors { top: true; left: true; right: true }
    }
    active: Config.settings.panel.position === "top"
  }
  
  Loader {
    id: bottomPanel
    sourceComponent: HPanel {
        panel.anchors { bottom: true; left: true; right: true }
    }
    active: Config.settings.panel.position === "bottom"
  }

  Loader {
    id: leftPanel
    sourceComponent: VPanel {
        panel.anchors { bottom: true; left: true; top: true }
    }
    active: Config.settings.panel.position === "left"
  }
  
  Loader {
    id: rightPanel
    sourceComponent: VPanel {
        panel.anchors { bottom: true; right: true; top: true }
    }
    active: Config.settings.panel.position === "right"
  }
}

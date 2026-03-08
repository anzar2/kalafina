pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../../"

Rectangle {
  id: bg
  color: Qt.alpha(Colors.primary, 0.0)
  radius: 4
  implicitWidth: icons.width
  implicitHeight: icons.height
  visible: SystemTray.items.values.length > 0
  
  Behavior on implicitWidth {
    NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
  }

  Flow {
    id: icons
    flow: (Config.settings.panel.position === "top" || 
            Config.settings.panel.position === "bottom") ? Flow.LeftToRight : Flow.TopToBottom
          
    padding: Config.settings.systemTray.padding
    spacing: Config.settings.systemTray.spacing
    
    Repeater {
      model: SystemTray.items

      IconImage {
        required property SystemTrayItem modelData
        id: iconImg
        source: modelData.icon
        implicitSize: Config.settings.systemTray.iconSize

        HoverHandler {
          id: hoverHandler
          cursorShape: Qt.PointingHandCursor
        }

        TapHandler {
          id: tapHandler
          onDoubleTapped: {
            iconImg.modelData.activate()
          }
        }
      }   
    }
  }
}

pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../../"
import "../../utils"

Rectangle {
  id: bg
  color: Qt.alpha(Theme.colors.primary, 0.2)
  radius: 99
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

       Item {
        required property SystemTrayItem modelData
        implicitWidth: Config.settings.systemTray.iconSize
        implicitHeight: Config.settings.systemTray.iconSize

        HoverHandler {
          cursorShape: Qt.PointingHandCursor
        }
        TapHandler {
          onDoubleTapped: parent.modelData.activate()
        }

        IconImage {
          anchors.fill: parent
          source: parent.modelData.icon
          visible: NerdIcons.get(parent.modelData.id) === null
        }

        StyledText {
          text: NerdIcons.get(parent.modelData.id)
          anchors.centerIn: parent
          visible: NerdIcons.get(parent.modelData.id)
          color: Theme.colors.on_surface
        }
      } 
    }
  }
}

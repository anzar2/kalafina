import QtQuick
import QtQuick.Controls
import "../../"

Switch {
  id: root
  implicitWidth: rectangle.width
  implicitHeight: rectangle.height
  anchors.verticalCenter: parent.verticalCenter

  indicator: Rectangle {
    id: rectangle
    implicitWidth: 32
    implicitHeight: 16
    
    radius: 4
    color: root.checked ? Colors.inverse_primary : Colors.surface_container_highest

    Rectangle {
      x: root.checked ? parent.width - width : 0
      width: 16
      height: 16
      radius: 4
      color: Colors.on_surface
      border.color: Colors.outline

      Behavior on x {
          NumberAnimation { duration: 150 }
      }
    }
    
    Behavior on color {
      ColorAnimation { duration: 150 }  
    }
  }

  HoverHandler { cursorShape: Qt.PointingHandCursor  }
}

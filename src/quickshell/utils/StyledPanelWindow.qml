import ".."
import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
  id: root
  property alias background: bg
  signal mouseEntered()
  signal mouseExited()
  implicitWidth: 100
  implicitHeight: 100
  color: "transparent"

  // WlrLayershell.exclusionMode: WlrLayershell.Normal

  Rectangle {
    id: bg
    color: Theme.colors.surface
    radius: 8
    anchors.fill: parent
    Behavior on color {
      ColorAnimation {  }
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: root.mouseEntered()
    onExited: root.mouseExited()
  }
}

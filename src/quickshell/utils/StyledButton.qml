import QtQuick
import QtQuick.Controls
import ".."

Button {
  id: root
  property color textColor: Theme.colors.on_surface
  property int textWrap: Text.NoWrap
  property bool animated: true
  property int gapBetweenIcon: 8
  property alias backgroundRect: bg
  property alias nerdIcon: nIcon

  background: Rectangle {
    id: bg
    color: root.hovered ? Qt.alpha(Theme.colors.primary, 0.05) : "transparent"
    radius: 4
  }
  contentItem: Row {
    spacing: root.gapBetweenIcon
    
    StyledText {
      id: nIcon
      text: ""
      visible: text !== ""
      font.pointSize: 12
    }

    StyledText {
      text: root.text
      visible: root.text !== ""
      size: root.font.pointSize
      anchors.verticalCenter: parent.verticalCenter
      wrapMode: root.textWrap
      font.bold: root.font.bold
    }
  }
  
  leftPadding: 6
  rightPadding: 6
  topPadding: 3
  bottomPadding: 3
  padding: 0
  font.pointSize: 12
  scale: pressed && animated ? 0.98 : 1
    
  Behavior on scale {
    NumberAnimation { duration: 50 }
  }
  HoverHandler { cursorShape: Qt.PointingHandCursor }
}

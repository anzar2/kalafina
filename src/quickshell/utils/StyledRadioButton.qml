import ".."
import QtQuick.Controls
import QtQuick

RadioButton {
  id: control
  property int size: 12
  property real borderWidth: 1
  property real borderRadius: 10
  property alias radioText: rtext

  indicator: Rectangle {
    x: 0
    y: control.height / 2 - height / 2
    width: control.size
    height: control.size
    radius: control.borderRadius
    border.width: control.borderWidth
    border.color: control.checked ? Theme.colors.primary : Theme.colors.outline
    color: "transparent"

    Rectangle {
      anchors.centerIn: parent
      width: control.size / 1.5
      height: control.size / 1.5
      radius: control.borderRadius
      color: control.checked ? Theme.colors.primary : "transparent"

      Behavior on color { ColorAnimation { duration: 200 } }
    }
  }

  contentItem: StyledText {
    id: rtext
    text: control.text
    leftPadding: control.indicator.width
    verticalAlignment: Text.AlignVCenter
    anchors.verticalCenter: parent.verticalCenter
  }

  HoverHandler { cursorShape: Qt.PointingHandCursor }
}

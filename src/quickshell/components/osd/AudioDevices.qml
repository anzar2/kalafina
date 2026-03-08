import QtQuick
import QtQuick.Controls
import "../../"

Rectangle {
  id: root
  implicitHeight: 0
  implicitWidth: parent.width
  radius: 8
  color: Theme.colors.surface
  border.width: 1
  border.color: Qt.alpha(Theme.colors.outline, 0.3)
  clip: true

  ScrollView {
    anchors.fill: parent
    anchors.margins: 10
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    
    Column {
      id: devices
      spacing: 8
      width: parent.width
      
      Repeater {
        model: AudioService.outputDevices
        

        Rectangle {
          radius: 3
          color: hoverHandler.hovered ? Qt.alpha(Theme.colors.secondary, 0.1) : "transparent"
          implicitHeight: 34
          implicitWidth: devices.width

          HoverHandler {
            id: hoverHandler
            cursorShape: Qt.PointingHandCursor
          }

          TapHandler {
            onSingleTapped: {
              AudioService.setAudioOutput(modelData)
            }
          }

          Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            leftPadding: 10
            rightPadding: 10
            spacing: 8
            
            Text {
              text: "󰓃"
              color: Theme.colors.on_surface
              anchors.leftMargin: 8
              font.pixelSize: 18
              anchors.verticalCenter: parent.verticalCenter
            }

            Text {
              text: modelData.nickname
              color: Theme.colors.on_surface
              width: 150
              anchors.verticalCenter: parent.verticalCenter
              elide: Text.ElideRight
              font.bold: AudioService.audioSink?.id === modelData.id
            }
          }

          Text {
              text: AudioService.audioSink?.id === modelData?.id ? "" : ""
              color: Theme.colors.on_surface
              anchors.right: parent.right
              anchors.rightMargin: 8
              anchors.verticalCenter: parent.verticalCenter
              font.pixelSize: 16
          }
        }
      }
    }
  }
}

import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Wayland
import "../.."
import "../utils/"

PanelWindow {
  id: root
  property bool showDevices: false
  implicitWidth: osd.width
  implicitHeight: osd.height
  WlrLayershell.exclusionMode: WlrLayershell.Ignore
  color: "transparent"

  function toggleDevices() {
    showDevices = !showDevices
  }
  
  Column {
    id: osd
    spacing: 8
    
    width: bg.width

    AudioDevices {
      implicitHeight: root.showDevices ? 240 : 0
    }

    Rectangle {
      id: bg
      implicitWidth: 235
      implicitHeight: osdRow.height + 10
      color: Colors.surface
      radius: 8
      border.width: 1
      border.color: Qt.alpha(Colors.outline, 0.15)

      Row {
        id: osdRow
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0
        
        StyledButton {
          id: btnShowDevices
          nerdIcon.text: root.showDevices ? "󰅀" : "󰇙"
          onClicked: root.toggleDevices()
        }

        StyledButton {
          id: btnMute
          nerdIcon.text: AudioService.muted ? "󰖁" : "󰕾"
          onClicked: AudioService.toggleMute()
        }
                
        StyledSlider {
          anchors.verticalCenter: parent.verticalCenter
          onMoved: AudioService.setVolume(value)
          value: AudioService.volume
          implicitWidth: 150
        }

        StyledText {
          id: volumeIndicator
          text: AudioService.volume
          anchors.verticalCenter: parent.verticalCenter
        }
      }
    }
  }
}

pragma ComponentBehavior: Bound
import ".."
import "../components/utils/"
import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell

StyledPanelWindow {
  id: root
  implicitWidth: 300
  implicitHeight: widgetBody.height + 24
  margins.top: 10
  margins.left: 10
  margins.right: 10
  margins.bottom: 10

  background.border.width: 1
  background.border.color: Colors.surface_container_highest
  
  Column {
    id: widgetBody
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 12
    spacing: 6

    Rectangle {
      id: master
      implicitWidth: parent.width
      implicitHeight: 50
      color: Colors.surface_container
      radius: 4

      Column {
        id: masterVolume
        anchors.fill: parent
        spacing: 4
        padding: 8

        StyledText {
          text: "Volumen maestro"
          font.pointSize: 10
          font.bold: true
        }

        StyledSlider {
          value: AudioService.volume
          onMoved: AudioService.setVolume(value)
          implicitWidth: master.width - 6
        }
      }

      StyledText {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        size: 9
        font.bold: true
        text: AudioService.volume + "%"
      }
    }
    
    Rectangle {
      id: outputDevices
      property bool collapsed: true
      implicitWidth: parent.width
      implicitHeight: collapsed ? collapseButton.height + 100 : collapseButton.height
      color: Colors.surface_container
      radius: 4

      Behavior on implicitHeight {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
      }

      StyledText {
        id: collapseButton
        text: "󰓃  Dispositivos de salida"
        size: 10
        padding: 8
        font.bold: true
        anchors.left: parent.left
        anchors.right: parent.right
      }

      ListView {
        model: AudioService.outputDevices
        anchors.fill: parent
        spacing: 0
        clip: true
        anchors.margins: 10
        anchors.topMargin: collapseButton.height


        delegate: StyledRadioButton {
          required property PwNode modelData
          text: `${modelData.nickname}`
          checked: modelData.id === AudioService.audioSink?.id
          radioText.size: 9
          radioText.font.bold: checked
          onCheckedChanged: AudioService.setAudioOutput(modelData)
        }
      }
    }
  }
}

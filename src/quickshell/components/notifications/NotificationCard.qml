import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import "../utils/"
import "../../"

Rectangle {
  id: root
  property alias closeButton: dismissButton
  property alias appName: notificationAppName.text
  property alias image: notificationImage
  property alias title: notificationTitle.text
  property alias body: notificationBody.text

  implicitWidth: parent.width
  implicitHeight: 135
  radius: 4
  color: hoverHandler.hovered ? Colors.surface_container : Colors.surface_container_low
              
  Button {
    id: dismissButton
    onClicked: {}
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.rightMargin: 8
    anchors.topMargin: 8

    background: Rectangle {
      color: dismissButton.hovered ? Colors.surface_container_highest : Colors.surface_container_high
      radius: 10
    }
    contentItem: Text {
      color: Colors.on_surface
      padding: 2
      topPadding: -6
      bottomPadding: -3
      text: ""
      font.pixelSize: 17
    }
    HoverHandler { cursorShape: Qt.PointingHandCursor }
  }
  
  Column {
    spacing: 12
    padding: 12
    
    StyledText {
      id: notificationAppName
      text: "default"
      bottomPadding: 8
      font.capitalization: Font.Capitalize
      size: 9
      color: Colors.on_surface_variant
      font.bold: true
    }

    Row {
      spacing: 8
      
      IconImage {
        id: notificationImage
        source: ""
        implicitSize: 49
        visible: source !== ""
      }

      Column {
        StyledText {
          id: notificationTitle
          text: ""
          visible: true
          color: Colors.on_surface
          size: 10
          elide: Text.ElideRight
          width: 200
          font.bold: true
        }  

        StyledText {
          id: notificationBody
          text: ""
          size: 9
          wrapMode: Text.WordWrap
          elide: Text.ElideRight
          maximumLineCount: 3
          width: 200
        }
      }

    }
  }

  HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor } 
}

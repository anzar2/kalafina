pragma ComponentBehavior: Bound
import ".."
import QtQuick.Controls
import QtQuick

Slider {
  id: slider
  property alias backgroundRect: bg
  property alias fillRect: fill
  from: 0
  to: 100
  padding: 4

  handle: {}

  background: Item {
    width: slider.availableWidth
    height: 8

    Rectangle {
      id: bg
      anchors.fill: parent
      color: Theme.colors.surface_container_high
      radius: 2
      border.width: 1
      border.color: Qt.alpha(Theme.colors.outline, 0.24)
    }

    Rectangle {
      id: fill
      width: slider.visualPosition * parent.width
      height: parent.height
      color: sliderHover.hovered ? Theme.colors.secondary : Theme.colors.primary
      radius: 2

      Behavior on width {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
      }
    }
    
    HoverHandler { id: sliderHover; cursorShape: Qt.PointingHandCursor }
  }
}


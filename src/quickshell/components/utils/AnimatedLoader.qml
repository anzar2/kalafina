import Quickshell
import QtQuick

Item {
  id: root
  implicitWidth: componentLoader.width
  implicitHeight: componentLoader.height
  property alias loader: componentLoader
  property var openAnimation: NumberAnimation { duration: 0 }
  property var hideAnimation: NumberAnimation { duration: 0 }
  property bool active: false

  
  onActiveChanged: {
    if (active) {
      root.hideAnimation.stop()
      componentLoader.active = active
    } else root.hideAnimation.restart()
  }
  
  Connections {
    target: root.hideAnimation

    function onFinished() {
      if (!root.active) componentLoader.active = false
    }
  }
  
  Loader { 
    id: componentLoader 
    active: false
    onLoaded: {
      root.openAnimation.target = item
      root.hideAnimation.target = item
      root.openAnimation.restart()
    }
  }


  function toggle() { active = !active }
}

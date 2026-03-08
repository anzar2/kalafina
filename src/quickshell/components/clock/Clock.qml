import QtQuick
import Quickshell
import "../../"
import "../../utils"

StyledButton {
  property bool isVertical: Config.settings.panel.position.isVertical()                          
  property string panelPosition: Config.settings.panel.position
  property string dateFormat: (isVertical) ? Config.settings.clock.verticalFormat : Config.settings.clock.horizontalFormat
  
  SystemClock {
    id: sysClock
    precision: SystemClock.Seconds
  }
  
  text: Qt.formatDateTime(sysClock.date, dateFormat)
  font.bold: true
  font.pointSize: 11
  textWrap: Text.WordWrap
}

pragma Singleton
import Quickshell.Services.Notifications
import QtQuick
import Quickshell

Scope {
  property alias properties: persistentProperties
  property alias server: nserver

  NotificationServer {
    id: nserver
    property int globalNotificationsCount: trackedNotifications.values.length 
    
    imageSupported: true
    actionsSupported: true
    
    onNotification: (notification) => {
      notification.tracked = true
      notification.time = Qt.formatTime(new Date(), "hh:mm")
    }  
  } 
  
  PersistentProperties {
    id: persistentProperties
    reloadableId: "notificationServiceProperties"
    property bool showPanel: false
    property bool dnd: false
    property bool panelCollapsed: false
    
    function togglePanel() {
      showPanel = !showPanel
    }

    function collapsePanel() {
      panelCollapsed = !panelCollapsed
    }

    function toggleDnd() {
      dnd = !dnd
    }
  }
}



pragma Singleton
import Quickshell.Io
import Quickshell
import QtQuick

FileView {
  property alias colors: jsonAdapter
  path: `${Quickshell.env("HOME")}/.config/quickshell/theme/colors.json`
  watchChanges: true
  onFileChanged: reload()
  onAdapterUpdated: writeAdapter()

  JsonAdapter {
    id: jsonAdapter
    property color background: "#000000"
    property color error: "#000000"
    property color error_container: "#000000"
    property color inverse_on_surface: "#000000"
    property color inverse_primary: "#000000"
    property color inverse_surface: "#000000"
    property color on_background: "#000000"
    property color on_error: "#000000"
    property color on_error_container: "#000000"
    property color on_primary: "#000000"
    property color on_primary_container: "#000000"
    property color on_primary_fixed: "#000000"
    property color on_primary_fixed_variant: "#000000"
    property color on_secondary: "#000000"
    property color on_secondary_container: "#000000"
    property color on_secondary_fixed: "#000000"
    property color on_secondary_fixed_variant: "#000000"
    property color on_surface: "#000000"
    property color on_surface_variant: "#000000"
    property color on_tertiary: "#000000"
    property color on_tertiary_container: "#000000"
    property color on_tertiary_fixed: "#000000"
    property color on_tertiary_fixed_variant: "#000000"
    property color outline: "#000000"
    property color outline_variant: "#000000"
    property color primary: "#000000"
    property color primary_container: "#000000"
    property color primary_fixed: "#000000"
    property color primary_fixed_dim: "#000000"
    property color scrim: "#000000"
    property color secondary: "#000000"
    property color secondary_container: "#000000"
    property color secondary_fixed: "#000000"
    property color secondary_fixed_dim: "#000000"
    property color shadow: "#000000"
    property color source_color: "#000000"
    property color surface: "#000000"
    property color surface_bright: "#000000"
    property color surface_container: "#000000"
    property color surface_container_high: "#000000"
    property color surface_container_highest: "#000000"
    property color surface_container_low: "#000000"
    property color surface_container_lowest: "#000000"
    property color surface_dim: "#000000"
    property color surface_tint: "#000000"
    property color surface_variant: "#000000"
    property color tertiary: "#000000"
    property color tertiary_container: "#000000"
    property color tertiary_fixed: "#000000"
    property color tertiary_fixed_dim: "#000000"
  }
}

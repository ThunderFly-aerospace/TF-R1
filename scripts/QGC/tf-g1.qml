import QtQuick 2.2
import QGroundControl.Controls 1.0
import QGroundControl.FactSystem 1.0
import QGroundControl.FactControls 1.0
import QGroundControl.Controllers 1.0
FactPanel {
    id: panel

    property var qgcView: null
    CustomCommandWidgetController { id: controller; factPanel: panel }
    Column {
        spacing: 10
        QGCButton {
            text: "Prerotator ramp-up"
            onClicked: controller.sendCommand(32001, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        }
        QGCButton {
            text: "Prerotator terminate"
            onClicked: controller.sendCommand(32002, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        }
        QGCButton {
            text: "RR manual"
            onClicked: controller.sendCommand(176, 209, 2, 0, 0, 0, 0, 0, 0, 0)
        }
        QGCButton {
            text: "RR Stabilized"
            onClicked: controller.sendCommand(176, 209, 1, 0, 0, 0, 0, 0, 0, 0)
        }
        QGCButton {
            text: "RR manual"
            onClicked: controller.sendCommand(176, 209, 24, 0, 0, 0, 0, 0, 0, 0)
        }
        QGCButton {
            text: "RR Stabilized"
            onClicked: controller.sendCommand(176, 209, 25, 0, 0, 0, 0, 0, 0, 0)
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true
    title: qsTr("QStopwatch")
    
    Component.onCompleted: {
        console.log("Stopwatch object:", stopwatch)
    }

    // Modern gradient background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#667eea" }
            GradientStop { position: 1.0; color: "#764ba2" }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        // Modern Time Display Card
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 400
            height: 220
            radius: 20
            color: "white"
            
            // Simple shadow effect
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: 10
                z: -1
                radius: 20
                color: "#20000000"
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 15

                Label {
                    text: "ELAPSED TIME"
                    font.pixelSize: 14
                    font.bold: true
                    font.letterSpacing: 2
                    color: "#9ca3af"
                    Layout.alignment: Qt.AlignHCenter
                }

                // Time Display
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 8

                    // Minutes
                    ColumnLayout {
                        spacing: 5

                        Text {
                            text: stopwatch ? stopwatch.minutes : "00"
                            font.pixelSize: 48
                            font.bold: true
                            font.family: "Monospace"
                            color: "#1f2937"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "MIN"
                            font.pixelSize: 10
                            font.bold: true
                            font.letterSpacing: 1
                            color: "#9ca3af"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    // Separator
                    Text {
                        text: ":"
                        font.pixelSize: 42
                        font.bold: true
                        color: "#667eea"
                    }

                    // Seconds
                    ColumnLayout {
                        spacing: 5

                        Text {
                            text: stopwatch ? stopwatch.seconds : "00"
                            font.pixelSize: 48
                            font.bold: true
                            font.family: "Monospace"
                            color: "#1f2937"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "SEC"
                            font.pixelSize: 10
                            font.bold: true
                            font.letterSpacing: 1
                            color: "#9ca3af"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    // Separator
                    Text {
                        text: "."
                        font.pixelSize: 42
                        font.bold: true
                        color: "#667eea"
                    }

                    // Hundredths
                    ColumnLayout {
                        spacing: 5

                        Text {
                            text: stopwatch ? stopwatch.hundredths : "00"
                            font.pixelSize: 48
                            font.bold: true
                            font.family: "Monospace"
                            color: "#1f2937"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "MS"
                            font.pixelSize: 10
                            font.bold: true
                            font.letterSpacing: 1
                            color: "#9ca3af"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
        }

        // Modern Button Row
        RowLayout {
            spacing: 20
            Layout.alignment: Qt.AlignHCenter

            // Start/Stop Button
            Button {
                id: startStopBtn
                text: stopwatch ? stopwatch.buttonText : "Start"
                implicitWidth: 170
                implicitHeight: 60

                background: Rectangle {
                    radius: 30
                    color: (stopwatch && stopwatch.running) ? "#ef4444" : "#10b981"
                    
                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }

                    // Shadow
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -6
                        z: -1
                        radius: 30
                        color: (stopwatch && stopwatch.running) ? "#40ef4444" : "#4010b981"
                        opacity: 0.5
                    }

                    // Hover effect
                    Rectangle {
                        anchors.fill: parent
                        radius: 30
                        color: "white"
                        opacity: startStopBtn.hovered ? 0.1 : 0
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 150 }
                        }
                    }

                    // Scale animation
                    scale: startStopBtn.pressed ? 0.95 : 1.0
                    
                    Behavior on scale {
                        NumberAnimation { duration: 100 }
                    }
                }

                contentItem: RowLayout {
                    spacing: 8

                    Text {
                        text: startStopBtn.text === "Pause" ? "■" : "▶"
                        font.pixelSize: 20
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Text {
                        text: startStopBtn.text
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }
                }

                onClicked: stopwatch.startStop()
            }

            // Reset Button
            Button {
                id: resetBtn
                text: qsTr("Reset")
                implicitWidth: 170
                implicitHeight: 60

                background: Rectangle {
                    radius: 30
                    color: "#6b7280"

                    // Shadow
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -6
                        z: -1
                        radius: 30
                        color: "#406b7280"
                        opacity: 0.5
                    }

                    // Hover effect
                    Rectangle {
                        anchors.fill: parent
                        radius: 30
                        color: "white"
                        opacity: resetBtn.hovered ? 0.1 : 0
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 150 }
                        }
                    }

                    // Scale animation
                    scale: resetBtn.pressed ? 0.95 : 1.0
                    
                    Behavior on scale {
                        NumberAnimation { duration: 100 }
                    }
                }

                contentItem: RowLayout {
                    spacing: 8

                    Text {
                        text: "↻"
                        font.pixelSize: 22
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Text {
                        text: resetBtn.text
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }
                }

                onClicked: stopwatch.reset()
            }
        }

        // Status indicator
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: statusLabel.width + 24
            height: 32
            radius: 16
            color: "#ffffff30"
            visible: stopwatch && stopwatch.running

            RowLayout {
                anchors.centerIn: parent
                spacing: 8

                Rectangle {
                    width: 8
                    height: 8
                    radius: 4
                    color: "#ef4444"
                    
                    SequentialAnimation on opacity {
                        running: stopwatch && stopwatch.running
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.3; duration: 600 }
                        NumberAnimation { to: 1.0; duration: 600 }
                    }
                }

                Label {
                    id: statusLabel
                    text: "Running"
                    font.pixelSize: 14
                    font.bold: true
                    color: "white"
                }
            }
        }
    }
}

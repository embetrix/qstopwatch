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
            GradientStop { position: 0.0; color: "#0f2027" }
            GradientStop { position: 0.5; color: "#203a43" }
            GradientStop { position: 1.0; color: "#2c5364" }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        // Modern Time Display Card
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 550
            height: 280
            radius: 25
            color: "#1a2332"
            border.color: "#2d3748"
            border.width: 1
            
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
                    font.pixelSize: 18
                    font.bold: true
                    font.letterSpacing: 2
                    color: "#64748b"
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
                            font.pixelSize: 64
                            font.bold: true
                            font.family: "Monospace"
                            color: "#06b6d4"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "MIN"
                            font.pixelSize: 12
                            font.bold: true
                            font.letterSpacing: 1
                            color: "#64748b"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    // Separator
                    Text {
                        text: ":"
                        font.pixelSize: 56
                        font.bold: true
                        color: "#0ea5e9"
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 5
                    }

                    // Seconds
                    ColumnLayout {
                        spacing: 5

                        Text {
                            text: stopwatch ? stopwatch.seconds : "00"
                            font.pixelSize: 64
                            font.bold: true
                            font.family: "Monospace"
                            color: "#06b6d4"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "SEC"
                            font.pixelSize: 12
                            font.bold: true
                            font.letterSpacing: 1
                            color: "#64748b"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    // Separator
                    Text {
                        text: ":"
                        font.pixelSize: 56
                        font.bold: true
                        color: "#0ea5e9"
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 5
                    }

                    // Hundredths
                    ColumnLayout {
                        spacing: 5

                        Text {
                            text: stopwatch ? stopwatch.hundredths : "00"
                            font.pixelSize: 64
                            font.bold: true
                            font.family: "Monospace"
                            color: "#06b6d4"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            text: "MS"
                            font.pixelSize: 12
                            font.bold: true
                            font.letterSpacing: 1
                            color: "#64748b"
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
            Rectangle {
                id: startStopBtn
                implicitWidth: 180
                implicitHeight: 70
                radius: 35
                color: startStopBtn.text === "Pause" ? "#ef4444" : "#10b981"
                
                property string text: stopwatch ? stopwatch.buttonText : "Start"
                
                Behavior on color {
                    ColorAnimation { duration: 300 }
                }

                // Shadow effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -8
                    radius: 43
                    color: startStopBtn.text === "Pause" ? "#40ef4444" : "#4010b981"
                    z: -1
                }

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        text: startStopBtn.text === "Pause" ? "❚❚" : "▶"
                        font.pixelSize: startStopBtn.text === "Pause" ? 16 : 18
                        font.bold: true
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Text {
                        text: startStopBtn.text
                        font.pixelSize: 20
                        font.bold: true
                        font.letterSpacing: 0.5
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: stopwatch.startStop()
                    
                    onPressed: parent.scale = 0.96
                    onReleased: parent.scale = 1.0
                }

                Behavior on scale {
                    NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
                }
                
                scale: 1.0
            }

            // Reset Button
            Rectangle {
                id: resetBtn
                implicitWidth: 180
                implicitHeight: 70
                radius: 35
                color: "#374151"

                // Shadow effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -8
                    radius: 43
                    color: "#30374151"
                    z: -1
                }

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 12

                    Text {
                        text: "↻"
                        font.pixelSize: 22
                        font.bold: true
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Text {
                        text: "Reset"
                        font.pixelSize: 20
                        font.bold: true
                        font.letterSpacing: 0.5
                        color: "white"
                        Layout.alignment: Qt.AlignVCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: stopwatch.reset()
                    
                    onPressed: parent.scale = 0.96
                    onReleased: parent.scale = 1.0
                }

                Behavior on scale {
                    NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
                }
                
                scale: 1.0
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

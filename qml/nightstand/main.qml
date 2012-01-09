import QtQuick 1.0

Rectangle {
    id: phone
    width: 640; height: 380
    color: "black"

    Text {
        id: currentTime
        y: 140
        anchors.horizontalCenter: phone.horizontalCenter
        font.pixelSize: 96; font.bold: true
        color: "green"
    }

    Text {
        id: currentDate
        y: 120
        anchors.horizontalCenter: phone.horizontalCenter
        font.pixelSize: 48
        color: "lightgreen"
        opacity: 0
    }

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: timeChanged()
    }

    function timeChanged() {
        var date = new Date;
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var seconds = date.getSeconds();
        currentDate.text = date.toDateString()
        currentTime.text = hours + ":" + minutes + ":" + seconds
    }

    MouseArea {
        id: touch
        anchors.fill: parent
        onPressed: phone.state = "touched"
        onReleased: phone.state = ""
    }

    states: [
        State {
            name: "touched"
            PropertyChanges {
                target: currentTime; y: 250; color: "darkgreen"
            }
            PropertyChanges {
                target: currentDate; opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "touched"; reversible: true
            NumberAnimation {
                property: "y"
                duration: 300
            }
        }
    ]
}

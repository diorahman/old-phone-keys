import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true

    property int keyIndex: 0
    property string masterKey: ""
    property string currentKey: ""
    property string currentText: ""
    property string tempText: ""

    Rectangle {
        color: 'red'
        width: 10
        height: 10
        radius: 5
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 2
        visible: timer.running
    }

    Timer {
        id: timer
        repeat: false
        interval: 1000
        onTriggered: {
            masterKey = '';
            keyIndex = 0;

            currentText = tempText;
        }
    }

    Item {
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_Backspace)
            {
                if (display.text.length > 0) {
                    display.text
                            = currentText
                            = tempText
                            = display.text.substring(0, display.text.length - 1);
                }
                return;
            }

            timer.restart();

            var keyData = {
                '1' : ['1', '_'],
                '2' : ['2', 'A', 'B', 'C'],
                '3' : ['3', 'D', 'E', 'F'],
                '4' : ['4', 'G', 'H', 'I'],
                '5' : ['5', 'J', 'K', 'L'],
                '6' : ['6', 'M', 'N', 'O'],
                '7' : ['7', 'P', 'Q', 'R'],
                '8' : ['8', 'S', 'T', 'U'],
                '9' : ['9', 'V', 'W', 'X', 'Y', 'Z'],
            };

            if (masterKey !== '' && timer.running) {
                var keys = keyData[masterKey];
                if (!keys) {
                    return;
                }
                keyIndex++;
                if (keyIndex > keys.length - 1)
                    keyIndex = 0;
                currentKey = keys[keyIndex];

            } else {
                currentKey = masterKey = event.text;
            }
            tempText = currentText;
            tempText += currentKey;
            display.text = tempText;
        }
    }

    Text {
        id: display
        anchors.centerIn: parent
    }
}


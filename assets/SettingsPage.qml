import bb.cascades 1.0
import "settingsDb.js" as SettingsDb

Page {
    id: settingsPage
    signal aboutView
    signal themeChanged
    property color backgroundColor: SettingsDb.getValue("BACKGROUND_COLOR")
    property color headerBackgroundColor: SettingsDb.getValue("HEADER_BACKGROUND_COLOR")
    property color headerTextColor: SettingsDb.getValue("HEADER_TEXT_COLOR")
    property color divisionLineColor: SettingsDb.getValue("DIVISION_LINE_COLOR")
    property color divisionLineTextColor: SettingsDb.getValue("DIVISION_LINE_TEXT_COLOR")
    property color textColor: SettingsDb.getValue("TEXT_COLOR")
    //orientationLock: SettingsDb.getOrientationLock();

    titleBar: TitleBar {
        id: titleBar
        title: qsTr("EasyNote - Settings")
    }
    /*Rectangle {
        id: background
        color: backgroundColor
        anchors.fill: parent

        onHeightChanged: {
            flick.height = height;
        }

        ListModel {
            id: listModel
        }

        SelectionDialog {
            id: singleSelectionDialog
            titleText: qsTr("Themes")

            model: {
                listModel.clear();
                for(var i = 0; i < SettingsDb.THEME_NAMES.length; ++i)
                {
                    listModel.append({name: SettingsDb.THEME_NAMES[i]});
                }
                return listModel;
            }
            onSelectedIndexChanged: {
                if(SettingsDb.THEME != listModel.get(selectedIndex).name)
                {
                    SettingsDb.THEME = listModel.get(selectedIndex).name;
                    SettingsDb.setProperty(SettingsDb.propTheme, SettingsDb.THEME);
                    themeChanged();
                }
            }
            onVisibleChanged: {
                if(visible)
                {
                    for(var i = 0; i < listModel.count; ++i)
                    {
                        if(listModel.get(i).name == SettingsDb.THEME)
                        {
                            singleSelectionDialog.selectedIndex = i;
                            break;
                        }
                    }
                }
            }
        }

        Flickable {
            id: flick
            anchors.top: header.bottom
            anchors.topMargin: 10
            leftMargin: 10
            rightMargin: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            contentHeight: optionsRectangle.implicitHeight
            contentWidth: optionsRectangle.implicitWidth
            flickableDirection: Flickable.VerticalFlick
            clip: true

            Rectangle {
                id: optionsRectangle
                implicitWidth: flick.width
                implicitHeight: 710
                color: backgroundColor

                // Division line
                Rectangle {
                    id: orientationDivisionLine
                    color: divisionLineColor
                    height: 1
                    anchors.verticalCenter: orientationLabel.verticalCenter
                    leftMargin: 10
                    anchors.left: parent.left
                    rightMargin: 5
                    anchors.right: orientationLabel.left
                }
                Label {
                    id: orientationLabel
                    text: qsTr("Orientation")
                    font.pointSize: 26
                    anchors.top: parent.top
                    anchors.right: parent.right
                    rightMargin: 10
                    color: divisionLineTextColor
                }

                ButtonRow {
                    id: orientationButtonRow
                    anchors.topMargin: 10;
                    anchors.top: orientationLabel.bottom
                    leftMargin: 10;
                    anchors.left: parent.left
                    anchors.right: parent.right
                    rightMargin: 10
                    Button {
                        id: lockPortraitButton
                        text: qsTr("Portrait")
                        checkable: true
                        checked: {
                            if(SettingsDb.getProperty(SettingsDb.propOrientationLock) == "Portrait")
                            {
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        onClicked: {
                            lockLandscapeButton.checked = false;
                            autoOrientationButton.checked = false;
                            settingsPage.orientationLock = PageOrientation.LockPortrait;
                            SettingsDb.setProperty(SettingsDb.propOrientationLock, "Portrait");
                        }
                    }
                    Button {
                        id: lockLandscapeButton
                        text: qsTr("Landscape")
                        checkable: true
                        checked: {
                            if(SettingsDb.getProperty(SettingsDb.propOrientationLock) == "Landscape")
                            {
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        onClicked: {
                            lockPortraitButton.checked = false;
                            autoOrientationButton.checked = false;
                            settingsPage.orientationLock = PageOrientation.LockLandscape;
                            SettingsDb.setProperty(SettingsDb.propOrientationLock, "Landscape");
                        }
                    }
                    Button {
                        id: autoOrientationButton
                        text: qsTr("Auto")
                        checkable: true
                        checked: {
                            if(SettingsDb.getProperty(SettingsDb.propOrientationLock) == "Automatic")
                            {
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        onClicked: {
                            lockPortraitButton.checked = false;
                            lockLandscapeButton.checked = false;
                            settingsPage.orientationLock = PageOrientation.Automatic;
                            SettingsDb.setProperty(SettingsDb.propOrientationLock, "Automatic");
                        }
                    }
                }

                // Division line
                Rectangle {
                    id: themeDivisionLine
                    color: divisionLineColor
                    height: 1
                    anchors.verticalCenter: themeLabel.verticalCenter
                    leftMargin: 10
                    anchors.left: parent.left
                    rightMargin: 5
                    anchors.right: themeLabel.left
                }
                Label {
                    id: themeLabel
                    text: qsTr("Theme")
                    font.pointSize: 26
                    anchors.right: parent.right
                    anchors.top: orientationButtonRow.bottom
                    anchors.topMargin: 10;
                    rightMargin: 10
                    color: divisionLineTextColor
                }

                Button {
                    id: themeButton
                    anchors.left: parent.left
                    leftMargin: 10;
                    anchors.right: parent.right
                    rightMargin: 10
                    anchors.top: themeLabel.bottom
                    anchors.topMargin: 10;
                    text: qsTr("Select Theme...")
                    onClicked: {
                        singleSelectionDialog.open();
                    }
                }
                // Division line
                Rectangle {
                    id: syncDivisionLine
                    color: divisionLineColor
                    height: 1
                    anchors.verticalCenter: syncLabel.verticalCenter
                    leftMargin: 10
                    anchors.left: parent.left
                    rightMargin: 5
                    anchors.right: syncLabel.left
                }
                Label {
                    id: syncLabel
                    text: qsTr("Synchronise")
                    font.pointSize: 26
                    anchors.right: parent.right
                    anchors.top: themeButton.bottom
                    anchors.topMargin: 10;
                    rightMargin: 10
                    color: divisionLineTextColor
                }

                Label {
                    id: syncSourceLabel
                    text: qsTr("Source:")
                    font.pointSize: 26
                    anchors.topMargin: 10
                    anchors.top: syncLabel.bottom
                    anchors.left: parent.left
                    leftMargin: 10
                    color: textColor
                }
                TextField {
                    id: syncSourceTextField
                    text: SettingsDb.getProperty(SettingsDb.propSyncUrl);
                    anchors.topMargin: 5
                    anchors.top: syncSourceLabel.bottom
                    anchors.left: parent.left
                    leftMargin: 10;
                    anchors.right: parent.right
                    rightMargin: 10
                    focus: true
                    inputMethodHints: Qt.ImhNoPredictiveText
                }

                Label {
                    id: usernameLabel
                    text: qsTr("Username:")
                    font.pointSize: 26
                    anchors.topMargin: 10
                    anchors.top: syncSourceTextField.bottom
                    anchors.left: parent.left
                    leftMargin: 10
                    color: textColor
                }
                TextField {
                    id: syncUsernameTextField
                    text: SettingsDb.getProperty(SettingsDb.propSyncUsername);
                    anchors.topMargin: 5
                    anchors.top: usernameLabel.bottom
                    anchors.left: parent.left
                    leftMargin: 10;
                    anchors.right: parent.right
                    rightMargin: 10
                    focus: true
                    inputMethodHints: Qt.ImhNoPredictiveText
                }

                Label {
                    id: passwordLabel
                    text: qsTr("Password:")
                    font.pointSize: 26
                    anchors.topMargin: 10
                    anchors.top: syncUsernameTextField.bottom
                    anchors.left: parent.left
                    leftMargin: 10
                    color: textColor
                }
                TextField {
                    id: syncPasswordTextField
                    echoMode: TextInput.Password
                    anchors.topMargin: 10
                    anchors.top: passwordLabel.bottom
                    anchors.left: parent.left
                    leftMargin: 10;
                    anchors.right: parent.right
                    rightMargin: 10
                    focus: true
                    inputMethodHints: Qt.ImhNoPredictiveText
                }
                Button {
                    id: saveSettingsButton
                    text: qsTr("Save");
                    anchors.topMargin: 10
                    anchors.top: syncPasswordTextField.bottom
                    anchors.left: parent.left
                    leftMargin: 10;
                    anchors.right: parent.right
                    rightMargin: 10
                    onClicked: {
                        settingsPage.save();
                    }
                }
            }
        }
        ScrollDecorator {
            flickableItem: flick
        }
    }

    function reloadDb()
    {
        SettingsDb.loadSettingsDb();
    }

    function loadTheme()
    {
        SettingsDb.loadTheme();
        backgroundColor = SettingsDb.getValue("BACKGROUND_COLOR");
        headerBackgroundColor = SettingsDb.getValue("HEADER_BACKGROUND_COLOR");
        headerTextColor = SettingsDb.getValue("HEADER_TEXT_COLOR");
        divisionLineColor = SettingsDb.getValue("DIVISION_LINE_COLOR");
        divisionLineTextColor = SettingsDb.getValue("DIVISION_LINE_TEXT_COLOR");
        textColor = SettingsDb.getValue("TEXT_COLOR");
    }

    function save()
    {
        SettingsDb.setProperty(SettingsDb.propSyncUrl, syncSourceTextField.text);
        SettingsDb.setProperty(SettingsDb.propSyncUsername, syncUsernameTextField.text);
        if(syncPasswordTextField.text.length > 0)
        {
            SettingsDb.setProperty(SettingsDb.propSyncPassword, Qt.md5(syncPasswordTextField.text));
        }
        pageStack.pop();
    }

    onVisibleChanged: {
        if(visible)
        {
            reloadDb();
        }
    }*/
}

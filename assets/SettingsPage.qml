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
        title: qsTr("Settings")
    }
    Container {
        id: background
        background: backgroundColor
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        /*ListModel {
         * id: listModel
         * }
         * SelectionDialog {
         * id: singleSelectionDialog
         * titleText: qsTr("Themes")
         * model: {
         * listModel.clear();
         * for (var i = 0; i < SettingsDb.THEME_NAMES.length; ++ i) {
         * listModel.append({
         * name: SettingsDb.THEME_NAMES[i]
         * });
         * }
         * return listModel;
         * }
         * onSelectedIndexChanged: {
         * if (SettingsDb.THEME != listModel.get(selectedIndex).name) {
         * SettingsDb.THEME = listModel.get(selectedIndex).name;
         * SettingsDb.setProperty(SettingsDb.propTheme, SettingsDb.THEME);
         * themeChanged();
         * }
         * }
         * onVisibleChanged: {
         * if (visible) {
         * for (var i = 0; i < listModel.count; ++ i) {
         * if (listModel.get(i).name == SettingsDb.THEME) {
         * singleSelectionDialog.selectedIndex = i;
         * break;
         * }
         * }
         * }
         * }
         * }*/
        ScrollView {
            id: flick
            Container {
                id: optionsRectangle
                background: backgroundColor
                leftPadding: 20
                rightPadding: 20
                topPadding: 20
                bottomPadding: 20
                Label {
                    id: orientationLabel
                    text: qsTr("Orientation:")
                    textStyle {
                        color: textColor
                        fontSize: FontSize.Large
                    }
                }
                SegmentedControl {
                    id: orientationButtonRow
                    Option {
                        id: lockPortraitButton
                        text: qsTr("Portrait")
                        value: 'Portrait'
                        selected: {
                            if (SettingsDb.getProperty(SettingsDb.propOrientationLock) == "Portrait") {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }
                    Option {
                        id: lockLandscapeButton
                        text: qsTr("Landscape")
                        value: 'Landscape'
                        selected: {
                            if (SettingsDb.getProperty(SettingsDb.propOrientationLock) == "Landscape") {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }
                    Option {
                        id: autoOrientationButton
                        text: qsTr("Auto")
                        value: 'Automatic'
                        selected: {
                            if (SettingsDb.getProperty(SettingsDb.propOrientationLock) == "Automatic") {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    }
                    onSelectedIndexChanged: {
                        SettingsDb.setProperty(SettingsDb.propOrientationLock, orientationButtonRow.selectedValue());
                    }
                }

                /*
                 * Label {
                 * text: qsTr("Dark Theme:")
                 * textStyle {
                 * color: textColor
                 * fontSize: FontSize.Large
                 * }
                 * }
                 * ToggleButton {
                 * id: themeButton
                 * checked: {
                 * if (SettingsDb.getProperty(SettingsDb.propTheme) == 'Dark') {
                 * return true;
                 * } else {
                 * return false;
                 * }
                 * }
                 * onCheckedChanged: {
                 * SettingsDb.setProperty(SettingsDb.propTheme, themeButton.checked ? 'Dark' : 'Bright' )
                 * }
                 * }*/
                Label {
                    text: qsTr("Select Theme:")
                    textStyle {
                        color: textColor
                        fontSize: FontSize.Large
                    }
                }
                DropDown {
                    id: themeButton
                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                    onSelectedValueChanged: {
                        //singleSelectionDialog.open();
                    }
                }
                Divider {
                }
                Label {
                    id: syncLabel
                    text: qsTr("Synchronise")
                    horizontalAlignment: HorizontalAlignment.Center
                    rightMargin: 10
                    textStyle {
                        color: divisionLineTextColor
                        fontSize: FontSize.XLarge
                    }
                }
                Label {
                    id: syncSourceLabel
                    text: qsTr("Source:")
                    topMargin: 10
                    leftMargin: 10
                    textStyle {
                        color: textColor
                        fontSize: FontSize.Large
                    }
                }
                TextField {
                    id: syncSourceTextField
                    text: SettingsDb.getProperty(SettingsDb.propSyncUrl)
                    topMargin: 5
                    leftMargin: 10
                    rightMargin: 10
                }
                Label {
                    id: usernameLabel
                    text: qsTr("Username:")
                    topMargin: 40
                    textStyle {
                        color: textColor
                        fontSize: FontSize.Large
                    }
                }
                TextField {
                    id: syncUsernameTextField
                    text: SettingsDb.getProperty(SettingsDb.propSyncUsername)
                }
                Label {
                    id: passwordLabel
                    text: qsTr("Password:")
                    topMargin: 40
                    textStyle {
                        color: textColor
                        fontSize: FontSize.Large
                    }
                }
                TextField {
                    id: syncPasswordTextField
                    inputMode: TextFieldInputMode.Password
                }
                Button {
                    id: saveSettingsButton
                    text: qsTr("Save")
                    topMargin: 40
                    horizontalAlignment: HorizontalAlignment.Right
                    onClicked: {
                        settingsPage.save();
                    }
                }
            }
        }
    }
    function reloadDb() {
        SettingsDb.loadSettingsDb();
    }
    function loadTheme() {
        SettingsDb.loadTheme();
        backgroundColor = SettingsDb.getValue("BACKGROUND_COLOR");
        headerBackgroundColor = SettingsDb.getValue("HEADER_BACKGROUND_COLOR");
        headerTextColor = SettingsDb.getValue("HEADER_TEXT_COLOR");
        divisionLineColor = SettingsDb.getValue("DIVISION_LINE_COLOR");
        divisionLineTextColor = SettingsDb.getValue("DIVISION_LINE_TEXT_COLOR");
        textColor = SettingsDb.getValue("TEXT_COLOR");
    }
    function save() {
        SettingsDb.setProperty(SettingsDb.propSyncUrl, syncSourceTextField.text);
        SettingsDb.setProperty(SettingsDb.propSyncUsername, syncUsernameTextField.text);
        if (syncPasswordTextField.text.length > 0) {
            SettingsDb.setProperty(SettingsDb.propSyncPassword, Qt.md5(syncPasswordTextField.text));
        }
        pageStack.pop();
    }
}

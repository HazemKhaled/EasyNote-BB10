import bb.cascades 1.0
import "settingsDb.js" as SettingsDb

Page {
    id: aboutPage
    property color backgroundColor: SettingsDb.getValue("BACKGROUND_COLOR")
    property color headerBackgroundColor: SettingsDb.getValue("HEADER_BACKGROUND_COLOR")
    property color headerTextColor: SettingsDb.getValue("HEADER_TEXT_COLOR")
    property color textColor: SettingsDb.getValue("TEXT_COLOR")
    //orientationLock: SettingsDb.getOrientationLock();
    property string version: "0.0.4"
    titleBar: TitleBar {
        id: titleBar
        title: qsTr("EasyNote - About")
    }
    Container {
        id: background
        background: backgroundColor
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        ScrollView {
            id: flick
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            content: Container {
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    id: text1
                    text: "http://willemliu.nl/donate/"
                }
                Label {
                    id: text2
                    text: version
                }
                Label {
                    id: text3
                    text: qsTr("Created with Qt")
                }
                Label {
                    id: text4
                    text: qsTr("Created by <a href='http://willemliu.nl/donate/'>Willem Liu</a>")
                }
                Label {
                    id: text5
                    text: qsTr("Thanks to:")
                }
                Label {
                    id: text6
                    text: "Stanislav"
                }
                Label {
                    id: text7
                    text: "Jan-Eric Lindh"
                }
            }
        }
    }
    function loadTheme() {
        SettingsDb.loadTheme();
        backgroundColor = SettingsDb.getValue("BACKGROUND_COLOR");
        headerBackgroundColor = SettingsDb.getValue("HEADER_BACKGROUND_COLOR");
        headerTextColor = SettingsDb.getValue("HEADER_TEXT_COLOR");
        textColor = SettingsDb.getValue("TEXT_COLOR");
    }
}

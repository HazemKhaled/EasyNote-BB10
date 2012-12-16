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
        title: qsTr("About")
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
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: 50.0
                leftPadding: 40.0
                rightPadding: 40.0
                Label {
                    text: "Ported to BlackBerry by\nHazem Khaled\ntwitter: @HazemKhaled"
                    textStyle.textAlign: TextAlign.Center
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Fill
                    textStyle.fontSize: FontSize.Large
                    textStyle.color: Color.create("#0080d5")
                    textStyle.fontWeight: FontWeight.Bold
                }
                Divider {
                }
                Label {
                    text: "Created by: Willem Liu\n http://willemliu.nl/"
                    textStyle.textAlign: TextAlign.Center
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Fill
                    textStyle.fontSize: FontSize.Large
                    textStyle.color: Color.DarkGreen
                    textStyle.fontWeight: FontWeight.Bold
                }
                Divider {
                }
                Label {
                    text: 'Version : ' + version
                    textStyle.textAlign: TextAlign.Center
                    horizontalAlignment: HorizontalAlignment.Fill
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

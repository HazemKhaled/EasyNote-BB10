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
        title: qsTr("Help")
    }
    Container {
        id: background
        background: backgroundColor
        leftMargin: 50.0
        rightMargin: 5.0
        ScrollView {
            id: flick
            content: Container {
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 40.0
                rightPadding: 40.0
                topPadding: 40.0
                Label {
                    text: "Synchronization:"
                    textStyle.fontWeight: FontWeight.Bold
                    textStyle.fontSize: FontSize.Large
                }
                Label {
                    text: "When you've setup your synchronization account then you'll be able to synchronize your note with your online note."
                    multiline: true
                    textStyle.textAlign: TextAlign.Justify
                    horizontalAlignment: HorizontalAlignment.Fill
                }
                Label {
                    text: "You can create your online account on http://easylist.willemliu.nl.\nDefault sync URL is: http://easylist.willemliu.nl/getList.php"
                    multiline: true
                    textStyle.textAlign: TextAlign.Justify
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

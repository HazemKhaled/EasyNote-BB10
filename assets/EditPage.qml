import bb.cascades 1.0
import "editPageDb.js" as EditDb

Page {
    id: editPage
    property string listName: "default"
    property color backgroundColor: EditDb.getValue("BACKGROUND_COLOR")
    signal cancel()
    signal save()
    titleBar: TitleBar {
        id: addBar
        title: qsTr("Add new Note")
        visibility: ChromeVisibility.Visible
        dismissAction: ActionItem {
            title: qsTr("Cancel")
            onTriggered: {
                editPage.cancel();
            }
        }
        acceptAction: ActionItem {
            title: qsTr("Save")
            onTriggered: {
                EditDb.populateEditDb(textEdit.text);
                textEdit.text = '';
                editPage.save()
            }
        }
    }
    Container {
        id: background
        background: backgroundColor
        leftPadding: 20.0
        rightPadding: 20.0
        topPadding: 20.0
        TextArea {
            id: textEdit
            hintText: qsTr("Enter text to create your note.\n\nTip: You can copy text from other apps\nand paste it here as well.")
            onTextChanged: {
                //textEdit.positionToRectangle(cursorPosition);
            }
            minHeight: 300.0
            backgroundVisible: true
        }
    }
    function reloadDb() {
        listName = EditDb.getListName();
        textEdit.text = EditDb.loadEditDb(listName);
    }
    function loadTheme() {
        EditDb.loadTheme();
        backgroundColor = EditDb.getValue("BACKGROUND_COLOR");
    }
    function saveText(listName, text) {
        EditDb.listName = listName
        EditDb.populateEditDb(text);
    }
    function saveList(listName, text, timestamp) {
        EditDb.setListDb(listName, text, timestamp);
    }
}

import bb.cascades 1.0
import bb.system 1.0
import "listsDb.js" as ListsDb

Page {
    id: listsPage
    property color backgroundColor: ListsDb.getValue("BACKGROUND_COLOR")
    property color headerBackgroundColor: ListsDb.getValue("HEADER_BACKGROUND_COLOR")
    property color headerTextColor: ListsDb.getValue("HEADER_TEXT_COLOR")
    property color divisionLineColor: ListsDb.getValue("DIVISION_LINE_COLOR")
    property color divisionLineTextColor: ListsDb.getValue("DIVISION_LINE_TEXT_COLOR")
    property color textColor: ListsDb.getValue("TEXT_COLOR")
    property color listItemBackgroundColor: ListsDb.getValue("LIST_ITEM_BACKGROUND_COLOR")
    property color hoverColor: ListsDb.getValue("HOVER_COLOR")
    property color highlightColor: ListsDb.getValue("HIGHLIGHT_COLOR")
    //orientationLock: ListsDb.getOrientationLock();
    property string listName: ListsDb.getListName()
    actions: [
        ActionItem {
            title: qsTr("Add")
            imageSource: 'asset:///images/5_content_new.png'
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                addPrompt.show();
            }
            attachedObjects: [
                SystemPrompt {
                    id: addPrompt
                    title: qsTr("Add new folder")
                    body: qsTr("New folder name:")
                    onFinished: {
                        if (addPrompt.result == ConfirmButtonSelection) {
                            ListsDb.addList(addPrompt.inputFieldTextEntry);
                            ListsDb.setListName(addPrompt.inputFieldTextEntry);
                            listsPage.reloadDb();
                        }
                    }
                }
            ]
        }
    ]
    titleBar: TitleBar {
        id: titleBar
        title: qsTr("Notes Folders")
    }
    Container {
        id: background
        background: backgroundColor

        /*ListModel {
         * id: listModel
         * }*/
        ListView {
            id: listView
            leftMargin: 10
            rightMargin: 10
            horizontalAlignment: HorizontalAlignment.Fill
            dataModel: ArrayDataModel {
                id: listModel
            }
            onCreationCompleted: {
                ListsDb.getListsModel()
            }
            listItemComponents: [
                ListItemComponent {
                    id: listItem
                    Container {
                        id: backgroundRect
                        background: backgroundColor
                        leftPadding: 10
                        rightPadding: 10
                        onTouch: {
                            listsPage.listName = ListItemData.listName;
                            listView.currentIndex = ListItemData.index;
                            ListsDb.setListName(listsPage.listName);
                            listItem.backgroundColor = listItemBackgroundColor;
                            pageStack.pop();
                        }
                        contextActions: [
                            ActionSet {
                                title: qsTr("Edit / Delete")
                                subtitle: ListItemData.listName
                                actions: [
                                    ActionItem {
                                        title: qsTr("Rename")
                                        imageSource: 'asset:///images/5_content_edit.png'
                                        onTriggered: {
                                            renamePrompt.inputField.defaultText = listsPage.listName;
                                            renamePrompt.show();
                                        }
                                        attachedObjects: [
                                            SystemPrompt {
                                                id: renamePrompt
                                                title: qsTr("Rename notes folder")
                                                body: qsTr("New folder name:")
                                                onFinished: {
                                                    if (renamePrompt.result == ConfirmButtonSelection) {
                                                        ListsDb.renameList(listsPage.listName, renamePrompt.inputFieldTextEntry);
                                                        ListsDb.setListName(renamePrompt.inputFieldTextEntry);
                                                        listsPage.reloadDb();
                                                    }
                                                }
                                            }
                                        ]
                                    },
                                    ActionItem {
                                        title: qsTr("Delete")
                                        imageSource: 'asset:///images/5_content_discard.png'
                                        onTriggered: {
                                            removeDialog.show();
                                        }
                                        attachedObjects: [
                                            SystemPrompt {
                                                id: removeDialog
                                                title: qsTr("Remove note?")
                                                body: qsTr("Do you really want to remove [") + listsPage.listName + qsTr("]?")
                                                onFinished: {
                                                    if (removeDialog.result == ConfirmButtonSelection) {
                                                        ListsDb.removeList(listsPage.listName);
                                                        ListsDb.setListName(ListsDb.getFirstListName());
                                                        listsPagereloadDb();
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                        Divider {
                        }
                        Label {
                            id: text
                            preferredWidth: listView.width
                            textStyle {
                                color: DbConnection.getValue("LIST_ITEM_TEXT_COLOR")
                                fontSize: FontSize.Large
                            }
                            text: ListItemData.listName
                            multiline: true
                        }
                    }
                }
            ]
        }
    }
    function reloadDb() {
        loadTheme();
        ListsDb.getListsModel();
        listName = ListsDb.getListName();
        var num = listModel.count;
        for (var i = 0; i < num; ++ i) {
            textField.text = listName;
            if (listModel.get(i).listName == listName) {
                listView.currentIndex = i;
                break;
            }
        }
        // update delete button / menu item status
        var itemsCount = listModel.count;
        console.log("Updating button status ", itemsCount);
        var visible = (itemsCount > 0);
        deleteMenuItem.visible = visible;
        if (visible) {
            deleteToolIcon.iconId = "toolbar-delete";
        } else {
            deleteToolIcon.iconId = "toolbar-delete-dimmed";
        }
        deleteToolIcon.enabled = visible;
    }
    function loadTheme() {
        ListsDb.loadTheme();
        backgroundColor = ListsDb.getValue("BACKGROUND_COLOR");
        headerBackgroundColor = ListsDb.getValue("HEADER_BACKGROUND_COLOR");
        headerTextColor = ListsDb.getValue("HEADER_TEXT_COLOR");
        divisionLineColor = ListsDb.getValue("DIVISION_LINE_COLOR");
        divisionLineTextColor = ListsDb.getValue("DIVISION_LINE_TEXT_COLOR");
        textColor = ListsDb.getValue("TEXT_COLOR");
        listItemBackgroundColor = ListsDb.getValue("LIST_ITEM_BACKGROUND_COLOR");
        hoverColor = ListsDb.getValue("HOVER_COLOR");
        highlightColor = ListsDb.getValue("HIGHLIGHT_COLOR");
    }
}

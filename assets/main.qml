import bb.cascades 1.0
import bb.system 1.0
import "mainPageDb.js" as DbConnection

NavigationPane {
    id: pageStack
    // Add the application menu using a MenuDefinition
    Menu.definition: MenuDefinition {

        // Specify the actions that should be included in the menu
        actions: [
            ActionItem {
                title: qsTr("Settings")
                onTriggered: {
                    var page = settingsPageLoader.createObject();
                    pageStack.push(page);
                }
                attachedObjects: ComponentDefinition {
                    id: settingsPageLoader
                    source: "SettingsPage.qml"
                }
            },
            ActionItem {
                title: qsTr("Synchronise")
                imageSource: 'asset:///images/9_av_repeat.png'
                onTriggered: {
                    soonDialog.show();
                    //syncDialog.show();
                }
                attachedObjects: [
                    SystemDialog {
                        id: syncDialog
                        title: qsTr("Sync with online note?")
                        body: qsTr("Do you really want sync your current note with the online note?\n\nYour current note will be overwritten.")
                        onFinished: {
                            if (syncDialog.result == ConfirmButtonSelection) {
                                mainPage.sync()
                            }
                        }
                    },
                    SystemDialog {
                        id: unableToSyncDialog
                        title: qsTr("Can't synchronize")
                        body: qsTr("Unable to synchronize with online note. Please make sure you've correctly setup your sync account in settings.")
                    },
                    SystemToast {
                        id: soonDialog
                        body: qsTr("Sooooon.")
                    }
                ]
            },
            ActionItem {
                title: qsTr('Help')
                imageSource: 'asset:///images/2_action_help.png'
                onTriggered: {
                    var page = helpPageLoader.createObject();
                    pageStack.push(page);
                }
                attachedObjects: ComponentDefinition {
                    id: helpPageLoader
                    source: "HelpPage.qml"
                }
            },
            ActionItem {
                title: qsTr("About")
                imageSource: 'asset:///images/2_action_about.png'
                onTriggered: {
                    var page = aboutPageLoader.createObject();
                    pageStack.push(page);
                }
                attachedObjects: ComponentDefinition {
                    id: aboutPageLoader
                    source: "AboutPage.qml"
                }
            }
        ]
    }
    Page {
        id: mainPage
        //orientationLock: DbConnection.getOrientationLock()
        property string listName: DbConnection.getListName()
        property color backgroundColor: DbConnection.getValue("BACKGROUND_COLOR")
        property color headerBackgroundColor: DbConnection.getValue("HEADER_BACKGROUND_COLOR")
        property color headerTextColor: DbConnection.getValue("HEADER_TEXT_COLOR")
        property color divisionLineColor: DbConnection.getValue("DIVISION_LINE_COLOR")
        property color divisionLineTextColor: DbConnection.getValue("DIVISION_LINE_TEXT_COLOR")
        property color textColor: DbConnection.getValue("TEXT_COLOR")
        property color listItemBackgroundColor: DbConnection.getValue("LIST_ITEM_BACKGROUND_COLOR")
        property color hoverColor: DbConnection.getValue("HOVER_COLOR")
        signal hideToolbar(bool hideToolbar)
        property int index: -1
        property int modelIndex: -1
        property int scrollTo: 0
        attachedObjects: [
            Sheet {
                id: editPageSheet
                EditPage {
                    id: editPage
                    onCancel: {
                        // Cancel modification so just hide the Sheet.
                        editPageSheet.close();
                    }
                    onSave: {
                        mainPage.reloadDb();
                        editPageSheet.close();
                    }
                }
            }
        ]
        actions: [
            ActionItem {
                title: qsTr("Add")
                imageSource: 'asset:///images/5_content_new.png'
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    editPageSheet.open();
                }
                attachedObjects: ComponentDefinition {
                    id: editPageLoader
                    source: "ِEditPage.qml"
                }
            },
            ActionItem {
                title: qsTr("Folders")
                imageSource: 'asset:///images/4_collections_collection.png'
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    var page = listPageLoader.createObject();
                    pageStack.push(page);
                }
                attachedObjects: ComponentDefinition {
                    id: listPageLoader
                    source: "ListsPage.qml"
                }
            }
        ]
        titleBar: TitleBar {
            id: titleBar
            title: "[" + mainPage.listName + "]"
        }
        Container {
            id: background
            background: backgroundColor
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            ListView {
                id: listView
                horizontalAlignment: HorizontalAlignment.Fill
                dataModel: ArrayDataModel {
                    id: listModel
                }
                onCreationCompleted: {
                    listModel.append([
                            {
                                itemIndex: 1,
                                itemText: 'teeest teesttttt',
                                itemSelected: true
                            },
                            {
                                itemIndex: 2,
                                itemText: 'teeest asdsada',
                                itemSelected: false
                            }
                        ]);
                    DbConnection.loadDB(mainPage.listName);
                }

                //delegate: itemComponent
                listItemComponents: [
                    ListItemComponent {
                        id: listItem
                        //type: "item"
                        Container {
                            id: backgroundRect
                            background: backgroundColor
                            leftPadding: 10
                            rightPadding: 10
                            contextActions: [
                                ActionSet {
                                    title: qsTr("Edit / Delete")
                                    subtitle: ListItemData.itemText
                                    actions: [
                                        ActionItem {
                                            title: qsTr("Delete")
                                            imageSource: 'asset:///images/5_content_discard.png'
                                            onTriggered: {
                                                DbConnection.removeRecord(ListItemData.itemIndex);
                                                mainPage.reloadDb();
                                            }
                                        },
                                        ActionItem {
                                            title: qsTr("Edit")
                                            imageSource: 'asset:///images/5_content_edit.png'
                                            onTriggered: {
                                                editConfirmDialog.show();
                                            }
                                            attachedObjects: [
                                                SystemToast {
                                                    id: editConfirmDialog
                                                    body: qsTr("Sooooon.")
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
                                text: ListItemData.itemText
                                multiline: true

                                //onLinkActivated: {
                                //    Qt.openUrlExternally(link);
                                //}
                            }
                        }
                    }
                ]
            }
        }
        function reloadDb() {
            mainPage.listName = DbConnection.getListName();
            DbConnection.loadDB(mainPage.listName);
        }
        function loadTheme() {
            DbConnection.loadTheme();
            backgroundColor = DbConnection.getValue("BACKGROUND_COLOR");
            headerBackgroundColor = DbConnection.getValue("HEADER_BACKGROUND_COLOR");
            headerTextColor = DbConnection.getValue("HEADER_TEXT_COLOR");
            divisionLineColor = DbConnection.getValue("DIVISION_LINE_COLOR");
            divisionLineTextColor = DbConnection.getValue("DIVISION_LINE_TEXT_COLOR");
            textColor = DbConnection.getValue("TEXT_COLOR");
            listItemBackgroundColor = DbConnection.getValue("LIST_ITEM_BACKGROUND_COLOR");
            hoverColor = DbConnection.getValue("HOVER_COLOR");
            //editPageLoader.sourceComponent = editPageComponent;
            //editPageLoader.item.loadTheme();
        }
        function sync() {
            var syncUrl = DbConnection.getProperty(DbConnection.propSyncUrl);
            var syncUsername = DbConnection.getProperty(DbConnection.propSyncUsername);
            var syncPassword = DbConnection.getProperty(DbConnection.propSyncPassword);
            if (syncUsername.length > 0 && syncPassword.length > 0) {
                var synced = false;
                var doc = new XMLHttpRequest();
                doc.onreadystatechange = function() {
                    if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                        //showRequestInfo("Headers -->");
                        //showRequestInfo(doc.getAllResponseHeaders ());
                        //showRequestInfo("Last modified -->");
                        //showRequestInfo(doc.getResponseHeader ("Last-Modified"));
                    } else if (doc.readyState == XMLHttpRequest.DONE) {
                        var response = doc.responseXML;
                        if (response !== null) {
                            var a = response.documentElement;
                            if (a !== null) {
                                if (a.nodeName == "ezList") {
                                    if (a.childNodes.length > 0) {
                                        var listsNode = a.childNodes[0];
                                        for (var ii = 0; ii < listsNode.childNodes.length; ++ ii) {
                                            var listNode = listsNode.childNodes[ii];
                                            if (listNode.nodeName == "list") {
                                                var name;
                                                var data;
                                                var timestamp;
                                                for (var iii = 0; iii < listNode.childNodes.length; ++ iii) {
                                                    var dataNode = listNode.childNodes[iii];
                                                    if (dataNode.nodeName == "name") {
                                                        name = dataNode.childNodes[0].nodeValue;
                                                    }
                                                    if (dataNode.nodeName == "data") {
                                                        if (dataNode.childNodes[0].nodeName == "#cdata-section") {
                                                            data = dataNode.childNodes[0].nodeValue;
                                                        }
                                                    }
                                                    if (dataNode.nodeName == "last-modified") {
                                                        timestamp = dataNode.childNodes[0].nodeValue;
                                                    }
                                                }
                                                if (typeof name != 'undefined' && typeof data != 'undefined') {
                                                    editPageLoader.sourceComponent = editPageComponent;
                                                    editPageLoader.item.saveList(name, data, timestamp);
                                                    synced = true;
                                                }
                                            }
                                        }
                                    }
                                    mainPage.reloadDb();
                                }
                                //showRequestInfo("Headers -->");
                                //showRequestInfo(doc.getAllResponseHeaders ());
                                //showRequestInfo("Last modified -->");
                                //showRequestInfo(doc.getResponseHeader ("Last-Modified"));
                            }
                        }
                        if (synced === false) {
                            unableToSyncDialog.show();
                        }
                    }
                }
                doc.open("GET", syncUrl + "?username=" + syncUsername + "&password=" + syncPassword + "&xml=v2");
                doc.send();
            } else {
                unableToSyncDialog.show();
            }
        }
        function showRequestInfo(text) {
            console.log(text)
        }
    }
}

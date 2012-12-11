import bb.cascades 1.0
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
	                    id: settingsPageLoader;
	                    source: "SettingsPage.qml"
	                }
	            },
                ActionItem {
                    title: qsTr("Synchronise")
                    onTriggered: {
                        syncDialogLoader.sourceComponent = syncDialogComponent
                        syncDialogLoader.item.open();
                    }
                },
                ActionItem {
                    title: qsTr("About")
                    onTriggered: {
                        var page = aboutPageLoader.createObject();
                        pageStack.push(page);
                    }
                     
                    attachedObjects: ComponentDefinition {
                        id: aboutPageLoader;
                        source: "AboutPage.qml"
                    }
                }
            ] // end of actions list
        } // end of MenuDefinition
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
        /*Loader {
            id: listsPageLoader
            onLoaded: console.log("Lists page loaded")
        }
        Loader {
            id: editPageLoader
            onLoaded: console.log("Edit page loaded")
        }
        
        attachedObjects: [
            OrientationHandler {
                onOrientationChanged: {
                    listsPageLoader.source = "ListsPage.qml";
                    listsPageLoader.item.orientationLock = orientationLock;
                    mainPage.orientationLock = orientationLock;
                }
            }        
        ]
        
        onStatusChanged: {
            if (status == PageStatus.Deactivating) {
                //console.log("+++ MainPage::onStatusChanged .Deactivating");
                pageStackWindow.showToolBar = true;
            }
        }*/
        
        actions: [
            ActionItem {
                title: qsTr("Add")
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    var page = editPageLoader.createObject();
                    pageStack.push(page);
                }
                 
                attachedObjects: {
                    id: editPageLoader;
                    source: "ِEditPage.qml"
                }
            },
            ActionItem {
                title: qsTr("All Notes")
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    var page = listPageLoader.createObject();
                    pageStack.push(page);
                }
                 
                attachedObjects: ComponentDefinition {
                    id: listPageLoader;
                    source: "ِListsPage.qml"
                }
            }
        ]
/*
        Loader {
            id: syncDialogLoader
            onLoaded: {
                console.log("Sync dialog loaded");
            }
            anchors.fill: parent
        }
        Component {
            id: syncDialogComponent
            QueryDialog {
                id: syncDialog
                titleText: qsTr("Sync with online note?")
                message: qsTr("Do you really want sync your current note with the online note?\n\nYour current note will be overwritten.")
                acceptButtonText: qsTr("Ok")
                rejectButtonText: qsTr("Cancel")
                onAccepted: {
                    mainPage.sync();
                }
            }
        }
        Loader {
            id: unableToSyncDialogLoader
            onLoaded: {
                console.log("Unacle to sync dialog loaded");
            }
            anchors.fill: parent
        }
        Component {
            id: unableToSyncDialogComponent
            QueryDialog {
                id: unableToSyncDialog
                titleText: qsTr("Can't synchronize")
                message: qsTr("Unable to synchronize with online note. Please make sure you've correctly setup your sync account in settings.")
                acceptButtonText: qsTr("Ok")
            }
        }*/
        
        titleBar: TitleBar {
            id: titleBar
            title: "EasyNote - [" + mainPage.listName + "]"
        }
        Container {
            id: background
            background: backgroundColor
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            /*
            Component {
                id: editPageComponent
                EditPage {
                    id: myEditPage
                    visualParent: mainPage
                    anchors.fill: parent
                    z: 2
                    onAccepted: {
                        mainPage.reloadDb();
                    }
                    onVisibleChanged: {
                        if (visible) {
                            mainPage.hideToolbar(true);
                        } else {
                            mainPage.hideToolbar(false);
                        }
                    }
                }
            }
            ListModel {
                id: listModel
            }
            ListView {
                id: listView
	            verticalAlignment: VerticalAlignment.Center
	            horizontalAlignment: HorizontalAlignment.Center
                //model: DbConnection.loadDB(listName)
                //delegate: itemComponent
            }
            ScrollDecorator {
                flickableItem: listView
            }
            Component {
                id: itemComponent
                ListItemDelegate {
                    id: listItem
                    itemIndex: model.itemIndex
                    itemText: model.itemText
                    itemSelected: model.itemSelected
                    preferredHeight: Math.max(60, text.implicitHeight + 10)
                    preferredWidth: listView.width
                    Rectangle {
                        id: backgroundRect
                        color: backgroundColor
                        anchors.fill: parent
                        Rectangle {
                            id: divisionLine
                            color: DbConnection.getValue("DIVISION_LINE_COLOR")
                            preferredHeight: 1
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                        }
                        MouseArea {
                            preferredHeight: parent.height
                            preferredWidth: listView.width
                            onPressAndHold: {
                                scrollTo = listView.contentY;
                                mainPage.index = listItem.itemIndex;
                                contextMenu.open();
                                listItem.backgroundColor = DbConnection.getValue("LIST_ITEM_BACKGROUND_COLOR");
                            }
                            onHoveredChanged: {
                                if (containsMouse) {
                                    listItem.backgroundColor = DbConnection.getValue("HOVER_COLOR");
                                } else {
                                    listItem.backgroundColor = DbConnection.getValue("LIST_ITEM_BACKGROUND_COLOR");
                                }
                            }
                            onReleased: {
                                listItem.backgroundColor = DbConnection.getValue("LIST_ITEM_BACKGROUND_COLOR");
                            }
                            Label {
                                id: text
                                anchors.verticalCenter: parent.verticalCenter
                                preferredWidth: listView.width
                                leftMargin: 10
								textStyle {
								        color: DbConnection.getValue("LIST_ITEM_TEXT_COLOR")
								        fontSize : FontSize.Large
								}
                                text: itemText
                                wrapMode: Text.Wrap
                                onLinkActivated: {
                                    Qt.openUrlExternally(link);
                                }
                            }
                        }
                    }
                }
            }*/
        }
        /*contextActions: [
            ActionSet {
	            title: qsTr("Remove")
	            subtitle: qsTr("Remove this item ?")
	              
	            actions: [
	                ActionItem {
	                    title: qsTr("Delete")
	                    onTriggered: {
	                        DbConnection.removeRecord(mainPage.index);
	                        mainPage.reloadDb();
	                        listView.contentY = scrollTo;
	                    }   
	                }
	            ]
	        }
        ]*/
        /*
        onVisibleChanged: {
            if (visible) {
                reloadDb();
            }
        }*/
        function reloadDb() {
            listName = DbConnection.getListName();
            DbConnection.loadDB(listName);
        }
        function removeSelected() {
            var num = listModel.count;
            for (var i = num - 1; i >= 0; -- i) {
                if (listModel.get(i).itemSelected == "true") {
                    DbConnection.removeRecord(listModel.get(i).itemIndex);
                }
            }
            DbConnection.populateModel();
            updateButtonStatus();
            listView.contentY = scrollTo;
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
            editPageLoader.sourceComponent = editPageComponent;
            editPageLoader.item.loadTheme();
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
                            unableToSyncDialogLoader.sourceComponent = unableToSyncDialogComponent;
                            unableToSyncDialogLoader.item.open();
                        }
                    }
                }
                doc.open("GET", syncUrl + "?username=" + syncUsername + "&password=" + syncPassword + "&xml=v2");
                doc.send();
            } else {
                unableToSyncDialogLoader.sourceComponent = unableToSyncDialogComponent;
                unableToSyncDialogLoader.item.open();
            }
        }
        function showRequestInfo(text) {
            console.log(text)
        }
    }
}

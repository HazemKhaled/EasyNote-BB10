import bb.cascades 1.0

PageStackWindow {
    id: pageStackWindow

    MainPage {
        id: myMainPage
        onHideToolbar: {
            pageStackWindow.showToolBar = !hideToolbar;
        }
    }

    initialPage: myMainPage
}

import QtQuick.Layouts 1.1
import QtQuick 2.4
import Material 0.2
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1


Page {
    id: bookManagePage
    property var record: undefined
    property var index: undefined
    title: record.bookName
    property bool non_editMode: false

    View {
        anchors.centerIn: parent

        width: Units.dp(350)
        height: column.implicitHeight + Units.dp(32)

        elevation: 1
        radius: Units.dp(2)

        ColumnLayout {
            id: column
            Dialog {
                id: datePickerDialog
                hasActions: true
                contentMargins: 0
                floatingActions: true

                DatePicker {
                    id: datePicker
                    frameVisible: false
                    dayAreaBottomMargin : Units.dp(48)
                    selectedDate: record.publishDate
                }

            }
            anchors {
                fill: parent
                topMargin: Units.dp(16)
                bottomMargin: Units.dp(16)
            }

            Label {
                id: titleLabel

                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Units.dp(16)
                }

                style: "title"
                text: "书籍信息"
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: Units.dp(8)
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/book"
                }

                content: TextField {
                    id: bookNameInput
                    anchors.centerIn: parent
                    width: parent.width
                    readOnly: non_editMode
                    text: record.bookName
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/account_circle"
                }

                content: TextField {
                    id: authorInput
                    anchors.centerIn: parent
                    width: parent.width
                    readOnly: non_editMode
                    text: record.author
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/schedule"
                }

                content: RowLayout {
                    anchors.centerIn: parent
                    width: parent.width
                    Button {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 0.3 * parent.width
                        text: "选择"
                        onClicked:datePickerDialog.show()
                    }

                    TextField {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 0.7 * parent.width
                        readOnly: non_editMode
                        text: Qt.formatDate(datePicker.selectedDate, "yyyy-MM-dd")
                    }
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "action/view_headline"
                }

                content: TextField {
                    anchors.centerIn: parent
                    width: parent.width
                    readOnly: true
                    text: record.isbn
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name:  "file/folder"
                }

                content: TextField {
                    id: totalStockInput
                    anchors.centerIn: parent
                    width: parent.width
                    readOnly: non_editMode
                    text: record.totalStock
                }
            }

            ListItem.Standard {
                action: Icon {
                    anchors.centerIn: parent
                    name: "file/create_new_folder"
                }

                content: TextField {
                    id: avaiStockInput
                    anchors.centerIn: parent
                    width: parent.width
                    readOnly: non_editMode
                    text: record.avaiStock
                }
            }
//            ListItem.Standard {
//                action: Icon {
//                    anchors.centerIn: parent
//                    name: "action/watch_later"
//                }

//                content: TextField {
//                    anchors.centerIn: parent
//                    width: parent.width
//                    readOnly: non_editMode

//                    placeholderText: "还书日期"
//                }
//            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: Units.dp(8)
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: Units.dp(8)

                anchors {
                    right: parent.right
                    margins: Units.dp(16)
                }

                Button {
                    text: "下架"
                    textColor: Theme.primaryColor
                    onClicked: {
                        userModel.deleteBook(record)
                        //record.deconstruct()
                        showError("提示","归还成功，请返回并刷新页面")
                        bookManagePage.pop()
                    }
                }
                Button {
                    text: "修改"
                    textColor: Theme.primaryColor
                    onClicked: {
                        userModel.editBook(record, bookNameInput.text, authorInput.text,datePicker.selectedDate, totalStockInput.text, avaiStockInput.text)
                        //record.edit(bookNameInput.text, authorInput.text,datePicker.selectedDate, totalStockInput.text, avaiStockInput.text)
                        showError("提示","修改成功，请返回并刷新页面")
                        bookManagePage.pop()
                    }
                }
            }
        }
    }

    rightSidebar: PageSidebar {
        title: ""

        width: Units.dp(320)
        Image {
            asynchronous: true
            //anchors.margins: Units.dp(10)
            source: qsTr("qrc:/img/") + record.isbn + qsTr(".jpg")
            width: Units.dp(320)
            height: Units.dp(400)
            //x:bookInfoText.x
            //y:bookInfoText.y - Units.dp(20)
            //anchors.top: parent.top

        }
//        actions: [
//            Action {
//                iconName: "action/delete"
//                text: "Delete"
//            }
//        ]
    }
}

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.matkakortti 1.0
import "Utils.js" as Utils

BackgroundItem {
    property int type
    property alias time: timeLabel.value
    property int price
    property int group

    height: column.height + Theme.paddingLarge

    Column {
        id: column

        x: Theme.horizontalPageMargin
        width: parent.width - 2*x
        anchors.verticalCenter: parent.verticalCenter

        Label {
            visible: type === HslCardHistory.TransactionBoarding
            width: parent.width
            color: Theme.secondaryHighlightColor
            truncationMode: TruncationMode.Fade
            //: Label (transaction type)
            //% "Season ticket or boarding"
            text: qsTrId("matkakortti-history-transaction_type")
        }

        ValueLabel {
            id: timeLabel

            width: parent.width
            //: Label
            //% "Boarding time:"
            title: qsTrId("matkakortti-details-ticket-boarding_time")
        }

        Row {
            width: parent.width
            spacing: Theme.paddingMedium
            visible: type === HslCardHistory.TransactionPurchase

            ValueLabel {
                width: Math.min(preferredWidth, parent.width)
                //: Label
                //% "Cost:"
                title: qsTrId("matkakortti-details-ticket-cost")
                value: Utils.moneyString(price)
            }

            Label {
                visible: group > 1
                color: Theme.secondaryHighlightColor
                text: "(" + group + ")"
            }
        }
    }
}

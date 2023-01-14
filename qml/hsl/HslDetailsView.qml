import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.matkakortti 1.0

import "../components"
import "../components/Utils.js" as Utils

SilicaFlickable {
    property var eTicket
    property var storedValue
    property var periodPass

    contentHeight: column.height

    function timeUnits(unit) {
        switch (unit) {
        case HslData.ValidityLengthMinute:
            //: Time unit (abbreviated)
            //% "min"
            return qsTrId("matkakortti-time_unit_abbr-min")
        case HslData.ValidityLengthHour:
            //: Time unit (abbreviated)
            //% "h"
            return qsTrId("matkakortti-time_unit_abbr-hour")
        case HslData.ValidityLength24Hours:
            //: Time unit (abbreviated)
            //% "d"
            return qsTrId("matkakortti-time_unit_abbr-24hour")
        case HslData.ValidityLengthDay:
            //: Time unit (abbreviated)
            //% "d"
            return qsTrId("matkakortti-time_unit_abbr-day")
        }
        return unit
    }

    Column {
        id: column

        width: parent.width

        Column {
            width: parent.width
            visible: periodPass.periodValid1

            SectionHeader {
                //: Section header
                //% "Season tickets"
                text: qsTrId("matkakortti-details-section-season_tickets")
            }

            Item {
                id: seasonTicketItem

                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                height: Math.max(seasonTicketColumn.height, seasonTicketValidity.height) + Theme.paddingLarge

                Column {
                    id: seasonTicketColumn

                    anchors {
                        left: parent.left
                        right: seasonTicketValidity.left
                        rightMargin: Theme.paddingLarge
                    }

                    Label {
                        width: parent.width
                        horizontalAlignment: Text.AlignLeft
                        color: Theme.highlightColor
                        wrapMode: Text.Wrap
                        text: HslData.finnishDateString(periodPass.periodStartDate1) + " - " + HslData.finnishDateString(periodPass.periodEndDate1)
                    }

                    ValueLabel {
                        width: parent.width
                        //: Label
                        //% "Zone:"
                        title: qsTrId("matkakortti-details-zone")
                        value: periodPass.validityAreaName1
                    }

                    ValueLabel {
                        width: parent.width
                        visible: periodPass.periodPrice1 > 0
                        //: Label
                        //% "Cost:"
                        title: qsTrId("matkakortti-details-ticket-cost")
                        value: Utils.moneyString(periodPass.periodPrice1)
                    }
                }

                ValidityItem {
                    id: seasonTicketValidity

                    valid: periodPass.periodDaysRemaining1
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                }
            }
        }

        SectionHeader {
            //: Section header
            //% "Card value"
            text: qsTrId("matkakortti-details-section-card_value")
        }

        VerticalSpace { height: Theme.paddingLarge }

        Item {
            x: Theme.horizontalPageMargin
            width: parent.width - 2*x
            height: Math.max(lastLoadColumn.height, storedValueMoneyAmount.height)

            Column {
                id: lastLoadColumn

                anchors {
                    left: parent.left
                    right: storedValueMoneyAmount.right
                    rightMargin: Theme.paddingLarge
                }

                ValueLabel {
                    width: parent.width
                    visible: storedValue.loadedValue > 0
                    //: Label
                    //% "Last loaded value:"
                    title: qsTrId("matkakortti-details-loaded_value-label")
                    value: Utils.moneyString(storedValue.loadedValue)
                }

                ValueLabel {
                    width: parent.width
                    visible: HslData.isValidDate(storedValue.loadingTime)
                    //: Label
                    //% "Loading time:"
                    title: qsTrId("matkakortti-details-loading_time-label")
                    value: Utils.dateTimeString(storedValue.loadingTime)
                }
            }

            Text {
                id: storedValueMoneyAmount

                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight
                font {
                    pixelSize: Theme.fontSizeLarge
                    bold: true
                }
                color: Theme.primaryColor
                text: Utils.moneyString(storedValue.moneyValue)
            }
        }

        VerticalSpace { height: Theme.paddingLarge }

        Column {
            width: parent.width
            visible: HslData.isValidPeriod(eTicket.validityStartTime, eTicket.validityEndTime)

            SectionHeader {
                //: Section header
                //% "Latest value ticket"
                text: qsTrId("matkakortti-details-section-latest_ticket")
            }

            VerticalSpace { height: Theme.paddingLarge }

            Item {
                id: lastTicketItem

                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                height: Math.max(lastTicketColumn.height, lastTicketValidity.height)

                Column {
                    id: lastTicketColumn

                    anchors {
                        left: parent.left
                        right: lastTicketValidity.left
                        rightMargin: Theme.paddingLarge
                    }

                    ValueLabel {
                        width: parent.width
                        //: Label
                        //% "Zone:"
                        title: qsTrId("matkakortti-details-zone")
                        value: eTicket.validityAreaName
                    }

                    ValueLabel {
                        width: parent.width
                        //: Label
                        //% "Group size:"
                        title: qsTrId("matkakortti-details-ticket-group_size")
                        value: eTicket.groupSize
                        visible: eTicket.groupSize > 1
                    }

                    ValueLabel {
                        width: parent.width
                        //: Label
                        //% "Cost:"
                        title: qsTrId("matkakortti-details-ticket-cost")
                        value: Utils.moneyString(eTicket.extraZone ? eTicket.extensionFare : eTicket.ticketPrice)
                    }

                    ValueLabel {
                        width: parent.width
                        //: Label
                        //% "Validity time:"
                        title: qsTrId("matkakortti-details-ticket-validity_length")
                        value: eTicket.validityLength + " " + timeUnits(eTicket.validityLengthType)
                    }
                }

                ValidityItem {
                    id: lastTicketValidity

                    valid: eTicket.secondsRemaining
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                }
            }

            Column {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x

                ValueLabel {
                    width: parent.width
                    //: Label
                    //% "Valid from:"
                    title: qsTrId("matkakortti-details-ticket-valid_from")
                    value: Utils.dateTimeString(eTicket.validityStartTime)
                }

                ValueLabel {
                    width: parent.width
                    //: Label
                    //% "Valid until:"
                    title: qsTrId("matkakortti-details-ticket-valid_until")
                    value: Utils.dateTimeString(eTicket.validityEndTime)
                    //: Suffix after the time ending the period
                    //% " "
                    suffix: qsTrId("matkakortti-details-ticket-valid_until-suffix").trim()
                }

                ValueLabel {
                    width: parent.width
                    visible: HslData.isValidDate(eTicket.boardingTime) &&
                        eTicket.boardingTime.getTime() !== eTicket.validityStartTime.getTime()
                    //: Label
                    //% "Boarding time:"
                    title: qsTrId("matkakortti-details-ticket-boarding_time")
                    value: Utils.dateTimeString(eTicket.boardingTime)
                }

                ValueLabel {
                    width: parent.width
                    //: Label
                    //% "Boarding zone:"
                    title: qsTrId("matkakortti-details-boarding_zone")
                    value: eTicket.boardingAreaName
                    visible: value !== ""
                }
            }

            VerticalSpace { height: Theme.paddingLarge }
        }
    }

    VerticalScrollDecorator { }
}

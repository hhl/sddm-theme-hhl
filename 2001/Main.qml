/***************************************************************************
 * Copyright: 2015-2019 Hendrik Lehmbruch <hendrikL@siduction.org>
 *            2013 Reza Fatahilah Shah <rshah0385@kireihana.com>
 *            2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 *
 ***************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import SddmComponents 2.0
import "./components" as Components

Rectangle {
    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants { id: textConstants }

    /* Resets the "Login Failed" message after 2,5 seconds */
    Timer {
        id: errorMessageResetTimer
        interval: 2500
        onTriggered: errorMessage.text = ""
    }

    Connections {
        target: sddm

        /* on fail login, clean user and password entry */
        onLoginFailed: {
            pw_entry.text = ""
            user_entry.text = ""
            user_entry.focus = true
            
            /*reset showPw_button*/
            pw_entry.echoMode = TextInput.Password
            showPw_button.source = "images/visibility.svg"
            tooltip8.text = "show password" //textConstants.showPassword
            
            /* and Reset the message*/
            errorMessageResetTimer.restart()
            errorMessage.text = textConstants.loginFailed
        }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x
            y: geometry.y
            width: geometry.width
            height:geometry.height
            source: config.background
            fillMode:Image.PreserveAspectCrop /*Image.PreserveAspectFit*/

            KeyNavigation.backtab: user_entry; KeyNavigation.tab: user_entry

            onStatusChanged: {
                if (status == Image.Error && source != config.defaultBackground) {
                    source = config.defaultBackground
                }
            }
        }
    }

    /* topBar */    
    Rectangle {
        id: topBar
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 490
        height: 34
        color: "#333335"
        opacity: 0.35
        radius: 6
    }   
    /* end topBar */
    
    /* footerPic if a label/branding wanted */    
    /*Image {
        id: footerPic
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        source: "images/footer.svg"
        fillMode: Image.PreserveAspectFit
    }*/
    /* end footerPic */ 
    
    /* Main block */
    Rectangle {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 316
        width: 490
        height: 150
        color: "transparent" /*must be transparent*/
        radius: 12
        
        Rectangle {
            width: 490
            height: 150
            color: "#333335"
            opacity: 0.55 /* background opacity main block */
            radius: 12
        }

        /* Messages and warnings */             
        Components.CapsLock {
            id: txtCaps
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 27
            color:"white"
            font.pixelSize: 14
        }

        /* Login faild message */
        Text {
            id: errorMessage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color:"white"
            font.pixelSize: 14
        }
        /* End Messages and warnings */

        /* Login block */
        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 55
            
            Column {
                height: 71
                spacing: 7

                Row {
                    id:labelRow
                    spacing: 10

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: 210; height: 17
                        color: "transparent" 

                        Text {
                            id:userName
                            color:"white"
                            text:textConstants.userName
                            font.pixelSize: 12
                        }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: 210; height: 17
                        color: "transparent"

                        Text {
                            id: userPassword
                            color: "white"
                            text: textConstants.password
                            font.pixelSize: 12
                        }
                    }    
                }                    

                Row {
                    id: userRow
                    anchors.right: parent.right
                    spacing: 12

                    Components.UserBox {
                        id: user_entry
                        width: 210
                        height: 25

                        /***********************************************************************
                         * If you want the last successfully logged in user to be displayed,
                         * uncomment the "text: userModel.lastUser" row below
                         * for more informations why it isn't possible to configure it via
                         * /etc/sddm.conf see https://bugzilla.redhat.com/show_bug.cgi?id=1238889
                         * so i wait, till this is fixed in debian sid.
                         * Dont forget to disable it in the /etc/sddm.conf
                         * "RememberLastUser=true".
                         ************************************************************************/

                        // text: userModel.lastUser

                        font.pixelSize: 14
                        radius: 3
                        focus: true

                        KeyNavigation.backtab: user_entry; KeyNavigation.tab: pw_entry
                    }

                    Components.PwBox {
                        id: pw_entry
                        width: 210
                        height: 25
                        font.pixelSize: 14
                        radius: 3
                        focus: true

                        KeyNavigation.backtab: user_entry; KeyNavigation.tab: login_button

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(user_entry.text, pw_entry.text, menu_session.index)
                                event.accepted = true
                            }
                            
                        }                        
                    }
                    
                /************************************************* 
                 * show or hide password
                 * if you dont want that feature, comment it out
                 *************************************************/   
                ImageButton {
                    id:  showPw_button
                    source: "images/visibility.svg"
                    height: 24
                    
                    onClicked: if (pw_entry.echoMode === TextInput.Password) {
                            pw_entry.echoMode = TextInput.Normal
                            showPw_button.source = "images/hint.svg"
                            tooltip8.text = "hide password" //textConstants.hidePassword
                            pw_entry.focus = true; 
                        } else { 
                            pw_entry.echoMode = TextInput.Password
                            showPw_button.source = "images/visibility.svg"
                            tooltip8.text = "show password" //textConstants.showPassword
                            pw_entry.focus = true
                        }
                    }
                    /* end showPw_button*/
                }
                /* end input fields */

                /* button Row */
                Row {                    
                    id: buttonRow                    
                    spacing: 8

                    ImageButton {
                        id: session_button
                        height: 27
                        source: "images/session_normal.svg"
                        onClicked: if (menu_session.state === "visible") menu_session.state = ""; else 
                        menu_session.state = "visible"

                        KeyNavigation.backtab: login_button; KeyNavigation.tab: system_button
                    }

                    ImageButton {
                        id: system_button
                        height: 27
                        source: "images/system_shutdown.svg"
                        onClicked: sddm.powerOff()

                        KeyNavigation.backtab: session_button; KeyNavigation.tab: reboot_button
                    }

                    ImageButton {
                        id: reboot_button
                        height: 27
                        source: "images/system_reboot.svg"
                        onClicked: sddm.reboot()

                        KeyNavigation.backtab: system_button; KeyNavigation.tab: suspend_button
                    }

                    ImageButton {
                         id: suspend_button
                         height: 27
                         source: "images/system_suspend.svg"
                         visible: sddm.canSuspend
                         onClicked: sddm.suspend()
 
                         KeyNavigation.backtab: reboot_button; KeyNavigation.tab: hibernate_button
                     }
 
                     ImageButton {
                         id: hibernate_button
                         height: 27
                         source: "images/system_hibernate.svg"
                         visible: sddm.canHibernate
                         onClicked: sddm.hibernate()
 
                         KeyNavigation.backtab: suspend_button; KeyNavigation.tab: user_entry
                     }

                     ImageButton {
                         id: login_button
                         height: 27
                         source: "images/login_normal.svg"                                                    

                         onClicked: sddm.login(user_entry.text, pw_entry.text, menu_session.index)

                         KeyNavigation.backtab: pw_entry; KeyNavigation.tab: session_button
                     }
                 }
                /* end buttonRow */

                /* drop down menu session button */
                Components.SessionMenu {                    
                    id: menu_session
                    width: 145
                    height: 0
                    model: sessionModel
                    index: sessionModel.lastIndex                    
                }
            }
        }
    }
    /* end Main block */
    
    /* tooltips user and pw row */
    Components.ToolTip {
    	id: tooltip0
        target: user_entry
        text: textConstants.promptUser
     }

    Components.ToolTip {
    	id: toolTip1
        target: pw_entry
        text: textConstants.promptPassword
    }
    
    Components.ToolTip {
        id: tooltip8
        target: showPw_button
        text: "show password" //textConstants.showPassword
    }

    /* tooltips buttonRow */
    Components.ToolTip {
        id: tooltip3
        target: session_button
        text: textConstants.session
    }

    Components.ToolTip {
        id: tooltip4
        target: system_button
        text: textConstants.shutdown
    }

    Components.ToolTip {
        id: tooltip5
        target: reboot_button
        text: textConstants.reboot
    }

     Components.ToolTip {
        id: tooltip6
        target: suspend_button
        text: textConstants.suspend
    }
        
     Components.ToolTip {
        id: tooltip7
        target: hibernate_button 
        text: textConstants.hibernate
    }

    Components.ToolTip {
        id: tooltip2
        target: login_button
        text: textConstants.login
    }
    /* end tooltips */

    /* InfoRowTop */
    Row {
        id: infoRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        
        spacing: 8
        
        /* time and date */
        Timer {
            id: time
            interval: 100
            running: true
            repeat: true
            
            /***************************************************************************
             * The DateTime format is displayed like the system setup, 
             * to change the DateTime format e.g. for the US,
             * change it to:
             *      dateTime.text = new Date(),"MM-dd-yyyy, hh:mm ap"             
             * or you can try LongFormat, ShortFormat or NarrowFormat, it is your choise.
             * eg.:             * 
             *      dateTime.text = Qt.formatDateTime(new Date(), ShortFormat)
             *      dateTime.text = Qt.formatDateTime(new Date(), Locale.LongFormat)             
             * Or if you want a really long formated DateTime try this:
             *      dateTime.text = new Date().toLocaleString(Qt.locale())
             ****************************************************************************/
            onTriggered: {
                dateTime.text = new Date().toLocaleString(Qt.locale())
            }
        }
        
        Text { 
            id:dateTime
            color: "white"
            font.pixelSize: 12
        }
        /* end time and date */
        
        Text {
            id: dummy
            color: "white"
            font.pixelSize: 12
            text: "@"
        }
        
        /* welcome to hostname */
        Text {
            id:hostName
            color:"white"
            
            text:(sddm.hostName)
            font.pixelSize: 12
        }
        /* end hostname */
    }

} /* fine */

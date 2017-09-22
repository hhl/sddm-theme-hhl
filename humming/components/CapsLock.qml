/***************************************************************************
+ Copyright: 2015 Hendrik Lehmbruch <hendrikL@siduction.org>
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
import SddmComponents 2.0

 Item {
     
    id: txtCapsContainer
    width: txtCapsContent.width
    height: txtCapsContent.height

    property alias color: txtCaps.color
    property alias font: txtCaps.font
    property alias textColor: txtCaps.color
    property alias text: txtCaps.text

    TextConstants {
        id: textConstants        
    }
    
    Rectangle {
        id: txtCapsContent
        anchors.centerIn: parent
        width: txtCaps.contentWidth + 10
        height: txtCaps.contentHeight + 10
        opacity: 0
        color: "transparent" // "#053343"
        //border.color: "white"
        //border.width: 1
        radius: 3    
    
        Text {
            id: txtCaps
            anchors {fill: parent; margins: 5}
            wrapMode: Text.WrapAnywhere
            state: keyboard.capsLock ? "activated" : ""
            text: textConstants.capslockWarning
                                            
            states: [
                State {
                name: "activated"
                PropertyChanges { target:txtCapsContent; opacity: 1; }
                }
                                                ,
                State {
                name: ""
                PropertyChanges { target:txtCapsContent; opacity: 0; }
                }
            ]
        }
    }
 }
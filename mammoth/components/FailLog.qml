/***************************************************************************
+ Copyright (c) 2015 Hendrik Lehmbruch <hendrikL@siduction.org>
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
     
    id: container
    width: content.width
    height: content.height

    property alias color: errorMessage.color
    property alias font: errorMessage.font
    property alias textColor: errorMessage.color
    property alias text: errorMessage.text

    TextConstants { 
        id: textConstants
    }
    
    Rectangle {
        id: content
        anchors.centerIn: parent
        width: errorMessage.contentWidth + 10
        height: errorMessage.contentHeight + 10
        // opacity: 0
        color: "transparent" // "#053343"
      	border.color: "white"
        border.width: 1
       	radius: 3
            
        Connections {
            id: errorMessage
            target: sddm
                    
            onLoginSucceeded: {
                color: "white"
                text: textConstants.loginSucceeded
            }

            onLoginFailed: {
                color: "white"
                text: textConstants.loginFailed
            }
        }
    }
 }

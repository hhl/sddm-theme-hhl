/***************************************************************************
* Copyright: 2015-2017 Hendrik Lehmbruch <hendrikL@siduction.org>
*            2013 Nikita Mikhaylov <nslqqq@gmail.com>
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

import QtQuick 2.9
import SddmComponents 2.0
// import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Universal 2.12
// import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.12

FocusScope {
    id: container
    width: 100; height: 30

    property alias color: txtMainPw.color
    property alias borderColor: txtMainPw.borderColor
    property alias focusColor: txtMainPw.focusColor
    property alias radius: txtMainPw.radius
    property alias font: txtMainPw.font
    property alias textColor: txtMainPw.color
    property alias echoMode: txtMainPw.echoMode
    property alias text: txtMainPw.text
    
    Shortcut {
       context: Qt.ApplicationShortcut
       sequences: [StandardKey.Back, "Alt+Left, Ctrl+Z,  F14, Ctrl+Shift+Z"]

        onActivated: {
            container.clicked()
            //console.log("JS: Shortcut activated.")
        }
    }
       
    TextConstants {
        id: textConstants
    }
    
    TextBox {
        
        id: txtMainPw
        width: parent.width; height: parent.height
        color: "transparent"
        
        text: ""
        font.pixelSize: 14
        textColor: "white"
        borderColor: "lightgrey"
        focusColor: "white" 
        hoverColor: "white"

        echoMode: TextInput.Password

        focus: true
    }
}


/***************************************************************************
+ Copyright: 2015-2017 Hendrik Lehmbruch <hendrikL@siduction.org>
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
import QtQuick.Controls 1.1
import QtGraphicalEffects 1.0
 
Item {
 id: toolTipRoot
 width: toolTip.contentWidth
 height: toolTipContainer.height
 visible: false
 clip: false
 z: 999999999
 
 property alias text: toolTip.text
 property alias radius: content.radius
 property alias backgroundColor: content.color
 property alias textColor: toolTip.color
 property alias font: toolTip.font
 property var target: null

function onMouseHover(x, y)
 {
 var obj = toolTipRoot.target.mapToItem(toolTipRoot.parent, x, y);
 toolTipRoot.x = obj.x + 5;
 toolTipRoot.y = obj.y - 30;
 }
 
function onVisibleStatus(flag)
 {
 toolTipRoot.visible = flag;
 }
 
Component.onCompleted: {
 var itemParent = toolTipRoot.target;
 
var newObject = Qt.createQmlObject('import QtQuick 2.0; MouseArea {signal mouserHover(int x, int y); signal 
showChanged(bool flag); anchors.fill:parent; hoverEnabled: true; acceptedButtons: Qt.NoButton; onPositionChanged: 
{mouserHover(mouseX, mouseY)} onEntered: {showChanged(true)} onExited:{showChanged(false)}}',
 itemParent, "mouseItem");
 newObject.mouserHover.connect(onMouseHover);
 newObject.showChanged.connect(onVisibleStatus); 
 }
 
    Item {
        
    id: toolTipContainer
    z: toolTipRoot.z + 1
    width: content.width
    height: content.height
    
        Rectangle {
        id: content
        anchors.centerIn: parent
        width: toolTip.contentWidth + 10
        height: toolTip.contentHeight + 10
        color: "#333335" //"black"
        border.color: "white" //"steelblue"
        border.width: 1
        opacity: 0.9 
        radius: 3
        
            Text {
            id: toolTip
            anchors {fill: parent; margins: 5}
            //wrapMode: Text.WrapAnywhere 
            color: "white"
            }
        }
    }

    SequentialAnimation {
        id: fadein
        
        NumberAnimation {
            target: toolTipContainer
            property: "opacity"
            easing.type: Easing.InOutQuad
            duration: 750
            from: 0
            to: 1
        }       

        PauseAnimation {
            duration: 750           
        }
        
        NumberAnimation {
            target: toolTipContainer
            property: "opacity"
            easing.type: Easing.InOutQuad
            duration: 750
            from: 1
            to: 0
        }
     }
    onVisibleChanged: if(visible)fadein.start();
}

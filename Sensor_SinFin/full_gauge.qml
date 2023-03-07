import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

Rectangle {
	id: root
	visible: true
	width: 1100
	height: 520
	color: "#494d53"

	

	// ############## GAUGES ################
	

	function actScale1(text) {
		gauge1.value = text;
	}
 
	Rectangle {
		id:rect1
		x: 100
		y: 40
		width: 350
		height: 350
		color: "#494d53"
		//color: "#969696"
		CircularGauge {
			id: gauge1
			width: 400
			height: 400
			maximumValue: 5500
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style
				labelStepSize: 500

				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						ctx.beginPath();
						ctx.strokeStyle = "#ff8000";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(2500) - 90), degreesToRadians(valueToAngle(5500) - 90));
						ctx.stroke();
					}
				}

				tickmark: Rectangle {
					visible: styleData.value < 1 || styleData.value % 25 == 0
					implicitWidth: outerRadius * 0.01
					antialiasing: true
					implicitHeight: outerRadius * 0.05
					color: styleData.value >= 2500 ? "#ff8000" : "#e5e5e5"
				}

				minorTickmark: Rectangle {
					visible: styleData.value < 1 || styleData.value % 5 == 0
					implicitWidth: outerRadius * 0.02
					antialiasing: true
					implicitHeight: outerRadius * 0.07 
					color: "#e5e5e5"
				}
				

				tickmarkLabel:  Text {
					font.pixelSize: Math.max(20, outerRadius * 0.09)
					text: styleData.value
					color: styleData.value >= 2500 ? "#ff8000" : "#e5e5e5"
					antialiasing: true
				}

				needle: Rectangle {
					y: outerRadius * 0.15
					implicitWidth: outerRadius * 0.03
					implicitHeight: outerRadius * 0.9
					antialiasing: true
					color: "#00ff00"
				}

			}
			Rectangle {
				id:rectsg1
				anchors.horizontalCenter: parent.horizontalCenter
				y: 280
				width: 80
				height: 40
				color: "#494d53"
				Text {
					id:textgauge1
					anchors.horizontalCenter: parent.horizontalCenter
					text: Math.floor(gauge1.value)
					font.family: "Helvetica"
					font.pointSize: 24
					color: "#00ff00"
				}
			}
		}
	}

	Rectangle {
		id: error_id
		x : 150
		y : 380
		visible: true
		width: 250
		height: 30
		color: "#494d53"
		Text {
    		id: error_text
    		text: "ERROR: " + ((8 - gauge1.value) / 8 * 100).toFixed(2) + "%"
    		font.family: "Helvetica"
    		anchors.centerIn: parent
    		font.pointSize: 24
    		color: "#FFFFFF"
		}

	}

	
	Rectangle {
		id: recpwm
		x : 220
		y : 480
		visible: true
		width: 90
		height: 30
		color: "#969696"
		Text {
			id: textpwm
			text: "RPM"
			font.family: "Helvetica"
			anchors.centerIn: parent
			font.pointSize: 24
			color: "#FFFFFF"
		}
	}

}
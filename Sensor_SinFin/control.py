import sys
import os
import serial

from PyQt5 import QtGui, QtCore, Qt
from PyQt5.QtCore    import pyqtSlot, pyqtSignal, QUrl, QObject,QStringListModel, Qt
from PyQt5.QtQuick   import QQuickView
from PyQt5.QtWidgets import QApplication, QCheckBox, QGridLayout, QGroupBox
from PyQt5.QtWidgets import QMenu, QPushButton, QRadioButton, QVBoxLayout, QWidget, QSlider
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtGui import QGuiApplication


class Tablero(QQuickView):  

	####### REGISTROS a transferir de PYTHON a QML
	valGauge1 = pyqtSignal(str)
	valGauge2 = pyqtSignal(str)
	valGauge3 = pyqtSignal(str) 
	valGauge4 = pyqtSignal(str)
	
	valPin6 = pyqtSignal(str)
	valPin7 = pyqtSignal(str)
	valPin8 = pyqtSignal(str)
	valPin9 = pyqtSignal(str)
	
	def __init__(self):
		super().__init__()
		self.setSource(QUrl('full_gauge.qml'))
		self.rootContext().setContextProperty("Tablero", self)
		self.setGeometry(100, 100, 520, 520)
		self.show()
		vista = self.rootObject()
		self.initUART('COM4')  # En windows de COM4 a COM 30
		self.iniTemporizador()
		
		####### DATOS a transferir de PYTHON a QML
		self.valGauge1.connect(vista.actScale1)
		#vista.actScale1(120)

	
	def initUART(self,port):
		baudrate = 115200
		try: 	
			self.ser = serial.Serial(
				port,
				baudrate,
				timeout=1,
				parity=serial.PARITY_NONE,
				stopbits=serial.STOPBITS_ONE,
				bytesize=serial.EIGHTBITS
			)
		except serial.SerialException as e:
			print("PUERTO SERIAL NO RESPONDE" % port)
			#self.ser.close()
			sys.exit(-1)
		#self.ser.write("13L".encode())
    

	####### DATOS a transferir de QML a (PYTHON ARDUINO)


	@pyqtSlot('QString','QString')

	def iniTemporizador(self):
		self.temporizador = QtCore.QTimer()
		self.temporizador.timeout.connect(self.metMuestreo)
		self.temporizador.start(500)
		
	def metMuestreo(self):
		data = self.ser.read(1)
		n = self.ser.inWaiting()
		while n:
			
			data = data + self.ser.read(n)
			data1 = data.decode("utf-8").strip()  # leer una línea completa del puerto serial
			print(data1)
	
			n = self.ser.inWaiting()
			######## Envio datos a funciones de transferencia
			
			self.valGauge1.emit(str(data1))
			
			
			self.temporizador.start(50)

	

    
if __name__ == '__main__':
	app = QApplication(sys.argv)
	w = Tablero()
	sys.exit(app.exec_())
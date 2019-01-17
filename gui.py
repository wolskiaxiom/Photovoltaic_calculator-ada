#!/usr/bin/python3
# -*- coding: utf-8 -*-

from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QGridLayout, QLineEdit, QPushButton, QPlainTextEdit, QMessageBox
from PyQt5.QtCore import QProcess
import subprocess
import os


class GUI(QWidget):

    def __init__(self, parent=None):
        super().__init__(parent)
        self.interface()
        

    def interface(self):
        self.resize(800, 750)
        self.setWindowTitle("PV Calculator")
        text1 = QLabel("Liczba użytkowników", self)
        text2 = QLabel("Współczynnik nachylenia", self)
        text3 = QLabel("Sprawność modułu", self)
        text4 = QLabel("Moc jednego modułu", self)

        tbox1 = QLineEdit()
        tbox1.setText("2.0")
        tbox2 = QLineEdit()
        tbox2.setText("1.13")
        tbox3 = QLineEdit()
        tbox3.setText("0.20")
        tbox4 = QLineEdit()
        tbox4.setText("0.28")

        outputbox = QPlainTextEdit()

        calculate = QPushButton("Oblicz")
        calculate.clicked.connect(
            lambda: outputbox.setPlainText(
                subprocess.check_output([os.getcwd() + "/main", str(tbox1.text()), str(tbox2.text()), str(tbox3.text()), str(tbox4.text())]).decode("utf-8")
            )
        )

        chart = QPushButton("Stworz wykres")
        chart.clicked.connect(self.makeChart)

        grid = QGridLayout()
        grid.addWidget(text1, 0, 0)
        grid.addWidget(text2, 1, 0)
        grid.addWidget(text3, 2, 0)
        grid.addWidget(text4, 3, 0)

        grid.addWidget(tbox1, 0, 1)
        grid.addWidget(tbox2, 1, 1)
        grid.addWidget(tbox3, 2, 1)
        grid.addWidget(tbox4, 3, 1)

        grid.addWidget(calculate, 4, 1)
        grid.addWidget(chart, 5, 1)
        grid.addWidget(outputbox, 6, 0, 2, 0)

        self.setLayout(grid)

        self.show()

    def makeChart(self):
        command = "python"
        args =  ["chary.py"]
        process = QProcess(self)
        process.startDetached(command, args)


if __name__ == "__main__":
    import sys

    app = QApplication(sys.argv)
    window = GUI()
    sys.exit(app.exec_())

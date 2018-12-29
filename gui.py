#!/usr/bin/python3
# -*- coding: utf-8 -*-

from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QGridLayout, QLineEdit, QPushButton, QPlainTextEdit
import subprocess
import os


class GUI(QWidget):

    def __init__(self, parent=None):
        super().__init__(parent)
        self.interface()
        

    def interface(self):
        self.resize(500, 500)
        self.setWindowTitle("PV Calculator")
        text1 = QLabel("Number of users", self)
        text2 = QLabel("Directory ratio", self)
        text3 = QLabel("Panel effiency", self)
        text4 = QLabel("Power of module", self)

        tbox1 = QLineEdit()
        tbox1.setText("4.0")
        tbox2 = QLineEdit()
        tbox2.setText("1.13")
        tbox3 = QLineEdit()
        tbox3.setText("0.80")
        tbox4 = QLineEdit()
        tbox4.setText("0.28")

        outputbox = QPlainTextEdit()

        calculate = QPushButton("Oblicz")
        calculate.clicked.connect(
            lambda: outputbox.insertPlainText(
                subprocess.check_output([os.getcwd() + "/main", str(tbox1.text()), str(tbox2.text()), str(tbox3.text()), str(tbox4.text())]).decode("utf-8")
            )
        )

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
        grid.addWidget(outputbox, 5, 0, 2, 0)

        self.setLayout(grid)

        self.show()

if __name__ == "__main__":
    import sys

    app = QApplication(sys.argv)
    window = GUI()
    sys.exit(app.exec_())

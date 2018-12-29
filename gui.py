#!/usr/bin/python3
# -*- coding: utf-8 -*-

from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QGridLayout, QLineEdit, QPushButton


class GUI(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.interface()

    def interface(self):
        self.resize(300, 150)
        self.setWindowTitle("PV Calculator")
        text1 = QLabel("Number of users", self)
        text2 = QLabel("Directory ratio", self)
        text3 = QLabel("Panel effiency", self)
        text4 = QLabel("Power of module", self)

        tbox1 = QLineEdit()
        tbox2 = QLineEdit()
        tbox3 = QLineEdit()
        tbox4 = QLineEdit()

        calculate = QPushButton("Oblicz")
        calculate.clicked.connect(lambda: print("works"))

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

        self.setLayout(grid)

        self.show()

    def makeCalculations(self):
        pass


if __name__ == "__main__":
    import sys

    app = QApplication(sys.argv)
    window = GUI()
    sys.exit(app.exec_())

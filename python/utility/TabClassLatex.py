import sys
from PyQt6.QtWidgets import QApplication, QWidget,  QFormLayout, QGridLayout, QTabWidget, QLineEdit, QDateEdit, QPushButton
from PyQt6.QtCore import Qt
from TabFormLatex import *
from TabFormGenData import *
## Add all tabs
class TabObjLatex(QTabWidget):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
    

    ## Add all tabs to this tab form (parent)
    def Create(self,FPIBGBase):
        self.bobj = FPIBGBase
        ## Create the tabs
        self.tabFormGenData = TabGenData()        
        self.tabFormLatex = TabFormLatex()
        self.addTab(self.tabFormGenData, 'Data Generation')
        self.addTab(self.tabFormLatex, 'Plotting and Analysis')
        self.tabFormLatex.Create(self.bobj)
        self.tabFormGenData.Create(self.bobj)
import pandas as pd
from LatexDataBaseClass import *
import os
import csv
class LatexDataCSV(LatexDataBaseClass):

    def __init__(self, FPIBGBase, itemcfg,ObjName):
        super().__init__(FPIBGBase, itemcfg, ObjName)
        pass
    
    def getData(self):
        return self.data

    def Create(self, data_type,data_dir,data_file= None):
        self.data = pd.read_csv(data_file,header=0)  

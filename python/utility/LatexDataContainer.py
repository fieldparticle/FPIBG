
from LatexDataCSV import *
from LatexDataParticle import *
class LatexDataContainer():


    def __init__(self, FPIBGBase, itemcfg, ObjName, *args, **kwargs):
        self.ObjName = ObjName
        self.bobj = FPIBGBase
        self.cfg = self.bobj.cfg.config
        self.log = self.bobj.log
        self.log.log(self,"LatexDataContainer finished init.")
        self.data_base = None
        self.itemcfg = itemcfg

    def Create(self,plot_num,data_type):

        
        #matches = ["pqb","pcd","cfb","pqbrandom"]
        if "csv" in data_type:
            self.data_base = LatexDataCSV(self.bobj,self.itemcfg,"CSV Data")
            #self.data_base.Create(data_type,data_dir,data_file=self.itemcfg.config.data_file) 
        elif "particle" in data_type:
            self.data_base = LatexDataParticle(self.bobj,self.itemcfg,"Particle Data")
            self.data_base.Create(plot_num) 
        else:
            print("Invaid data type at line 26 in Create in LatexDataContainer()")  

    def getData(self):
        return self.data_base.getData()

        

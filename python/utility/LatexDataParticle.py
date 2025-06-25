import pandas as pd
from LatexDataBaseClass import *
import os
import csv
class LatexDataParticle(LatexDataBaseClass):

    sumFile = ""
    average_list = []
    mode = 0
    lines_return = pd.DataFrame()
    def __init__(self, FPIBGBase, itemcfg, ObjName):
        super().__init__(FPIBGBase, itemcfg, ObjName)
        


    def getData(self):
        return self.lines_return

    def Create(self, plot_num):
        
        
        if('validation' in self.itemcfg.config.mode.lower()):
            self.mode = 1
        else:
            self.mode = 0
        getFieldStr = f"DataFields{plot_num}"
        data_fields = self.itemcfg.config[getFieldStr]
        for jj in range(len(data_fields)):
            file_list = data_fields[jj].split('.')
            field_name = file_list[1].split(':')
            try :
                self.topdir = self.itemcfg.config.data_dir + "/perfdata" + field_name[0]
                self.sumFile = self.topdir + "/perfdata" + field_name[0] + ".csv"
            except BaseException as e:
                self.log.log(self,e)
            try :
                self.create_summary()
                self.check_data_files()
                self.get_averages()
            except BaseException as e:
                self.log.log(self,e)
                self.hasData = False
                raise ValueError
        
            self.data = pd.read_csv(self.sumFile,header=0) 
            field_name_txt = f"{field_name[0]}_{field_name[1]}"
            try :
                self.lines_return[field_name_txt]=self.data[field_name[1]] 
            except BaseException as e:
                print(e)


        print(self.lines_return)
        return

    # Returns true if number of .tst files equal to number of R or D files
    def check_data_files(self) -> bool:
        if(os.path.exists(self.sumFile) == False):
            print ("Data Direcoptries not available" )
            self.hasData = False
            return False
        tst_files = [i for i in os.listdir(self.topdir) if i.endswith(".tst")]
        if self.mode == 0:
            self.data_files = [i[:-5] for i in os.listdir(self.topdir) if i.endswith("R.csv")]
        else:
            self.data_files = [i[:-5] for i in os.listdir(self.topdir) if i.endswith("D.csv")]
        self.hasData = len(tst_files) == len(self.data_files)
        if(self.hasData == False):
            raise ValueError
            print("Raw data file count error")
        return self.hasData
    
    def create_summary(self):
        data = ['Name', 'fps', 'cpums', 'cms', 'gms', 'expectedp', 'loadedp',
                'shaderp_comp', 'shaderp_grph', 'expectedc', 'shaderc', 'sidelen']
        try :
            with open(self.sumFile, mode= 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(data)
        except BaseException as e:
            print(e)

    def get_averages(self):
        if(self.hasData == False):
            return
        for i in self.data_files:
            file_path_debug = self.topdir + "/" + i + "D.csv"
            file_path_release = self.topdir + "/" + i + "R.csv"
            fps = cpums = cms = gms = expectedp = loadedp = shaderp_comp = shaderp_grph = expectedc = shaderc = sidelen = count = 0
            """
            with open(file_path_debug, 'r') as filename:
                file = csv.DictReader(filename)
                for col in file:
                    
                    expectedp += float(col['expectedp'])
                    loadedp += float(col['loadedp'])
                    shaderp_comp += float(col['shaderp_comp'])
                    shaderp_grph += float(col['shaderp_grph'])
                    expectedc += float(col[' expectedc'])
                    shaderc += float(col['shaderc'])
                    sidelen += float(col[' sidelen'])
            """
            try:
                with open(file_path_release, 'r') as filename:
                    file = csv.DictReader(filename)
                    for col in file:
                        
                        count += 1
                        fps += float(col['fps'])
                        cpums += float(col['cpums'])
                        cms += float(col['cms'])
                        gms += float(col['gms'])
                        if count == 1:
                            loadedp = float(col['loadedp'])
                            if ' expectedc' in col:
                                expectedc = int(col[' expectedc'])
                            else:
                                expectedc = int(col['expectedc'])
            except BaseException as e:
                print(e)

            fps = fps / count
            cpums = cpums / count
            cms = cms / count
            gms = gms / count
            #expectedp = expectedp / count
            #loadedp = loadedp / count
            shaderp_comp = shaderp_comp / count
            shaderp_grph = shaderp_grph / count
            #expectedc = expectedc / count
            shaderc = shaderc / count
            sidelen = sidelen / count
            avg_list = [i, fps, cpums, cms, gms, expectedp, loadedp, shaderp_comp,
                        shaderp_grph, expectedc, shaderc, sidelen]
            with open(self.sumFile, 'a', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(avg_list)
            self.average_list.append(avg_list)
        file.close()
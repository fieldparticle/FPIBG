import pandas as pd
from LatexDataBaseClass import *
import os
import csv
import re
class LatexDataParticle(LatexDataBaseClass):

    sumFile = ""
    average_list = []
    mode = 0
    mmrr_fps = 0.0
    mmrr_cpums = 0.0
    mmrr_gms = 0.0
    
    lines_return = pd.DataFrame()
    def __init__(self, FPIBGBase, itemcfg, ObjName):
        super().__init__(FPIBGBase, itemcfg, ObjName)
        
    def isNumber(self,value):
        try:
            float(value)
        except ValueError:
            return False
        try:
            int(value)
        except ValueError:
            return False
        return True

    def getData(self):
        return self.lines_return
    
    def split(self,string):
        char_remove = ["(",")"]
        for char in char_remove:
            string = string.replace(char, "")                
        char_remove = ["+","-","/","*"]
        for char in char_remove:
            string = string.replace(char, ",")       
        return string

    def Create(self, plot_num):
        if len(self.lines_return) != 0:
            self.lines_return = pd.DataFrame()
        if('verification' in self.itemcfg.config.mode.lower()):
            self.mode = 1
        else:
            self.mode = 0
        self.do_mmrr()
        getFieldStr = f"DataFields{plot_num}"
        data_fields = self.itemcfg.config[getFieldStr]
        for jj in range(len(data_fields)):
            if any(map(lambda char: char in data_fields[jj], "+-/*")):
                alt_lst = self.split(data_fields[jj])
                alt_sary = alt_lst.split(',')   
                alt_const = None
                # Is there a constant
                for dd in alt_sary:
                    if self.isNumber(dd) == True:
                        alt_sary.remove(dd)
                        alt_const = alt_sary[0]
                        alt_sary = [alt_const]
                        break
                    
                
                for ss in range(len(alt_sary)):
                    file_list = alt_sary[ss].split(".")    
                    field_name = file_list[1].split(':')
                    field_name_txt = f"{field_name[0]}_{field_name[1]}"
                    if field_name_txt not in self.lines_return.keys():
                        self.build_field(field_name,field_name_txt)    
            else:
                file_list = data_fields[jj].split(".")
                field_name = file_list[1].split(':')
                field_name_txt = f"{field_name[0]}_{field_name[1]}"
                if field_name_txt not in self.lines_return.keys():
                    self.build_field(field_name,field_name_txt)    
        
    
        fps_ary = []
        cpums_ary = []
        gms_ary = []
        cnt = len(self.lines_return)
        for ii in range(len(self.lines_return)):
            fps_ary.append(self.mmrr_fps)
            cpums_ary.append(self.mmrr_cpums)
            gms_ary.append(self.mmrr_gms )
            
        self.lines_return["MMR_fps"] = fps_ary
        self.lines_return["MMR_cpums"] = cpums_ary
        self.lines_return["MMR_gms"] = gms_ary
        return
                        

    def build_field(self,field_name,key_name):

        if 'MMR' in key_name:
            return
       
        field_name[0] = field_name[0].strip()
        field_name[1] = field_name[1].strip()
        key_name = key_name.strip()
        try :
            
            self.topdir = self.itemcfg.config.data_dir + "/perfdata" + field_name[0]
            if self.mode == 1:
                self.sumFile = self.topdir + "/perfdata" + field_name[0] + "VERF.csv"
            else:
                self.sumFile = self.topdir + "/perfdata" + field_name[0] + ".csv"
        except BaseException as e:
            self.log.log(self,e)
        try :
            if self.mode == 0:
                self.create_summary()
            self.check_data_files()
            if self.mode == 0:
                self.get_averages()
            else:
                self.get_verify()
        except BaseException as e:
            self.log.log(self,e)
            print(e)
            self.hasData = False
            raise ValueError
    
        self.data = pd.read_csv(self.sumFile,header=0) 

        
        try :
            self.lines_return[key_name]=self.data[field_name[1]] 
        except BaseException as e:
            print(e)


        #print(self.lines_return)
        #try :
            #print(f"Type of {key_name} is {type(self.lines_return[key_name][0])}")
            
        #except BaseException as e:
        #    print(e)
        return
    
    def do_mmrr(self):
        fps = cpums = cms = gms = expectedp = loadedp = shaderp_comp = shaderp_grph = expectedc = shaderc = sidelen = count = 0
        mmr_path = f"{self.itemcfg.config.data_dir}/mmrr.csv"
        if(os.path.exists(mmr_path) == False):
            print ("MMRR Directories not available" )
            return False
        try:
            with open(mmr_path, 'r') as filename:
                file = csv.DictReader(filename)
                count = 0
                for col in file:
                    count += 1
                    fps += float(col['fps'])
                    cpums += float(col['cpums'])
                    gms += float(col['gms'])
        except BaseException as e:
            print(e)
            return
        
        self.mmrr_fps = fps / count
        self.mmrr_cpums = cpums / count
        self.mmrr_gms = gms / count    
       

    # Returns true if number of .tst files equal to number of R or D files
    def check_data_files(self) -> bool:
        if(os.path.exists(self.sumFile) == False):
            print ("LatexDataParticle.check_data_files() Data directories not available" )
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

   
    def get_verify(self):
        data = ['file','line', 'expectedp', 'loadedp', 'shaderp_comp',
                            'shaderp_grph', 'expectedc', 'shaderc', 'loaded_err', 'compp_err','grphp_err','coll_err']
        try :
            with open(self.sumFile, mode= 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(data)
        except BaseException as e:
            print(e)

        if(self.hasData == False):
            return
        file_count = 0
        average_list = []
        for i in self.data_files:
            file_path = self.topdir + "/" + i + "D.csv"
            
            try:
                with open(file_path, 'r') as filename:
                    file = csv.DictReader(filename)
                    loaded_err = grphp_err = compp_err = coll_err = expectedp = loadedp = shaderp_comp = shaderp_grph = shaderc = 0
                    line_count = 0
                    for col in file:
                        expectedp = int(col['expectedp'])
                        loadedp = int(col['loadedp'])
                        shaderp_comp = int(col['shaderp_comp'])
                        shaderp_grph= int(col['shaderp_grph'])
                        if loadedp != expectedp:
                            loaded_err = 1
                        if shaderp_comp != expectedp:
                            compp_err = 1
                        if shaderp_grph != expectedp:
                            grphp_err = 1
                        
                        expectedc = int(col[' expectedc'])
                        shaderc = int(col['shaderc'])
                        
                        if expectedc != shaderc:
                            coll_err = 1

                if loaded_err or grphp_err or compp_err or coll_err:
                    avg_list = [file_count, line_count, expectedp, loadedp, shaderp_comp,
                        shaderp_grph, expectedc, shaderc, loaded_err, compp_err, grphp_err, coll_err]
                    average_list.append(avg_list)            
                line_count += 1
            except BaseException as e:
                print(e)
            file_count += 1
        with open(self.sumFile, 'a', newline='\n') as file:
            writer = csv.writer(file)
            for ii in range(len(average_list)):
                writer.writerow(average_list[ii])
                
        

    def get_averages(self):
        if(self.hasData == False):
            return
        for i in self.data_files:
            if self.mode == 0:
                file_path_release = self.topdir + "/" + i + "R.csv"
            else:
                file_path_debug = self.topdir + "/" + i + "D.csv"
            fps = cpums = cms = gms = expectedp = loadedp = shaderp_comp = shaderp_grph = expectedc = shaderc = sidelen = count = 0
        
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
                            sidelen = int(col['sidelen'])
                            
            except BaseException as e:
                print(e)

            fps = fps / count
            cpums = cpums / count
            cms = cms / count
            gms = gms / count
            shaderp_comp = shaderp_comp / count
            shaderp_grph = shaderp_grph / count
            shaderc = shaderc / count
            avg_list = [i, fps, cpums, cms, gms, expectedp, loadedp, shaderp_comp,
                        shaderp_grph, expectedc, shaderc, sidelen]
            with open(self.sumFile, 'a', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(avg_list)
            self.average_list.append(avg_list)
        file.close()
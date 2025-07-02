import numpy as np
import os
import csv
import math
class ParticleUtilities():

    col_count = 0
    def __init__(self,sidelen,col_ary_size):
        self.side_len = sidelen
        self.max_location = (sidelen)*(sidelen)*(sidelen)
        self.width = self.side_len
        self.height = self.side_len
        self.col_ary_size = col_ary_size
        self.cell_array = np.array([[0]*col_ary_size]*(self.width**3))
        self.lock_array = np.array([0]*(self.width**3))
        print(f"Cell arry rows:{self.width**3} by cols:{col_ary_size}")
        
    def IndexToArray(self,index):

        c1 = c2 = c3 = 0
        w = self.width
        h = self.height
        c1 = index / (w * h)
        c2 = (index - c1 * w * h) / w
        c3 = index - w * (c2 + w * c1)
        ary = []
        ary.append(c3)
        ary.append(c2)
        ary.append(c1)
        return ary
    

    def gen_cell_ary(self,plist,file_name):
        
        for pp in plist:
            self.return_zlink(pp)
            z = pp.zlink
            print(f"P:{pp.pnum} [{z[0]} {z[1]} {z[2]} {z[3]} {z[4]} {z[5]} {z[6]} {z[7]}]")
            self.add_corners(z,pp)

        file_prefix = os.path.splitext(file_name)[0]
        try :
            with open(file_name,'w',newline='') as csv_file:
                outfl = csv.writer(csv_file)
                outfl.writerows(self.cell_array)
        except BaseException as e:
            print(e)
        self.detect_collions(plist)

    def detect_collions(self,plist):
        Tindex = 0
        break_point = 0
        col_count = 0
        
        for Findex in range(len(plist)):
            duplist = [0]*self.max_location
            try:
                F = plist[Findex]
                if(int(F.pnum) == 5):
                    break_point = 0
                for ii in range(0,8):
                    loc = int(F.zlink[ii])
                    if loc != 0:
                        for jj in range(0,self.max_location):
                            Tindex = int(self.cell_array[loc][jj])-1
                            
                            if Tindex == 6:
                                break_point = 0
                            if(Findex != Tindex):
                                if (Tindex+1) != 0:
                                    #print(f"P:{Findex+1} with {Tindex} at cell_ary_loc={loc}")
                                    T = plist[Tindex]
                                    ret = self.particle_contact(F,T,duplist)    

            except BaseException as e:
                print(e)

    def norm(self,p1,p2):
        dsq = ( (p1[0]-p2[0])*(p1[0]-p2[0]) ) + ( (p1[1]-p2[1])*(p1[1]-p2[1]) ) + ( (p1[2]-p2[2])*(p1[2]-p2[2]) )
        dist = math.sqrt(dsq)
        return dist

    def particle_contact(self,F,T,duplist):
        break_point = 0
        #print(f"Comparing:{int(F.pnum)} -> {int(T.pnum)}")
        if int(F.pnum) == 5 and int(T.pnum) == 6:
            F.pnum = 5
        p0 = np.array([F.rx,F.ry,F.rz])
        p1 = np.array([T.rx,T.ry,T.rz])
        dist = np.linalg.norm(p0 - p1)
        dist2 = self.norm(p0,p1)
        flg_dup = False
        if int(F.pnum) == 63:
            break_point = 0
        if dist < (T.radius + F.radius):
            if dist < (T.radius + F.radius):
                for dd in duplist:
                    if dd == 0:
                        flg_dup = False
                        duplist[dd] = int(T.pnum)
                        break
                    if int(T.pnum) == dd:
                        flg_dup = True
                        return
            self.col_count+=1
            print(f"P:{F.pnum} and {T.pnum} collison {self.col_count}")
            return 1
        return 0

    def add_corners(self,z,p):
        sltidx = 0
        slot = 0
        for ii in range(len(z)):
            sltidx = int(z[ii])
            if sltidx != 0:
                if(sltidx > self.col_ary_size):
                    print(f"particle corner at {sltidx} exceeds cell columns at {self.col_ary_size}")
                    print(f"P:{int(p.pnum)} at ({sltidx})<{round(p.rx)},{round(p.ry)},{round(p.rz)}>")
                    print(f"[",end=' ')
                    for jj in range(len(z)):
                        print(f"{z[jj]}",end=' ')
                    print("]")
                    return

                slot = self.lock_array[sltidx]    
                self.lock_array[sltidx] = (self.lock_array[sltidx] + 1)
                

                if slot > self.max_location:
                    print(f"slot at {slot} exceeds maxlocation at {self.max_location}")
                    return
                self.cell_array[sltidx][slot] = int(p.pnum)
        return



    def ArrayToIndex(self,loc,p=None):
        w = self.width
        h = self.height
        indxLoc =  loc[0][0] + w * (loc[0][1] + h * loc[0][2])
        
        #if p != None:
         #   print(f"P:{indxLoc} at <{loc[0][0]},{loc[0][1]},{loc[0][2]}for pnum {p.pnum}")
        if(indxLoc > self.max_location-1):
            return -1
        else:
            return indxLoc
    

    def return_zlink(self,p):
        self.p = p
        cx 		= p.rx
        cy 		= p.ry
        cz 		= p.rz
        R 		= p.radius
        npos = -1
        dupcntr = 0
        
        if(p.pnum == 7):
            p.pnum = 7
        for ii in range(8):
            p.zlink[ii] = 0
        ary = [(int(round(cx+R)),int(round(cy+R)),int(round(cz-R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        p.zlink[dupcntr] = cnr_idx

        ary = [(int(round(cx+R)),int(round(cy+R)),int(round(cz+R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (cnr_idx != p.zlink[0]):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
            
        ary = [(int(round(cx-R)),int(round(cy+R)),int(round(cz+R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (p.zlink[0] != cnr_idx and 
            p.zlink[1] != cnr_idx):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
        
        ary = [(int(round(cx-R)),int(round(cy+R)),int(round(cz-R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (p.zlink[0] != cnr_idx and 
            p.zlink[1] != cnr_idx and
            p.zlink[2] != cnr_idx):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
            
        ary = [(int(round(cx+R)),int(round(cy-R)),int(round(cz+R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (p.zlink[0] != cnr_idx and
            p.zlink[1] != cnr_idx and
            p.zlink[2] != cnr_idx and
            p.zlink[3] != cnr_idx):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
        
        
        ary = [(int(round(cx+R)),int(round(cy-R)),int(round(cz-R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (p.zlink[0] != cnr_idx and 
            p.zlink[1] != cnr_idx and
            p.zlink[2] != cnr_idx and
            p.zlink[3] != cnr_idx and
            p.zlink[4] != cnr_idx):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
        
        
        
        ary = [(int(round(cx-R)),int(round(cy-R)),int(round(cz+R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (p.zlink[0] != cnr_idx and
            p.zlink[1] != cnr_idx and
            p.zlink[2] != cnr_idx and
            p.zlink[3] != cnr_idx and
            p.zlink[4] != cnr_idx and
            p.zlink[5] != cnr_idx):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
        
        ary = [(int(round(cx-R)),int(round(cy-R)),int(round(cz-R)))]
        cnr_idx = self.ArrayToIndex(ary,p)
        if (p.zlink[0] != cnr_idx and
            p.zlink[1] != cnr_idx and
            p.zlink[2] != cnr_idx and
            p.zlink[3] != cnr_idx and
            p.zlink[4] != cnr_idx and
            p.zlink[5] != cnr_idx and 
            p.zlink[6] != cnr_idx):
            dupcntr+=1
            p.zlink[dupcntr] = cnr_idx
        
        
        

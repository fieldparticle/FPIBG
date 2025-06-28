
from BaseGenData import *

class GenDUPData(BaseGenData):

    def __init__(self):
        super().__init__()

    def gen_data(self):
        self.gen_data_base()
        
    def plot_particle_cell(self,file_name):
        self.plot_particle_cell_base(file_name)
    
    
    def place_particles(self,xx,yy,zz,colliding,w_list):
        
        particle_struct = pdata()
        #print(f"particle: {self.particle_count}, xx={xx}, yy= {yy}, zz={zz}, layer= {layer}, row= {row} col= {col}")
        #                         |offset so no particle is in a cell with a zero in it|
       
        
        particle_struct.ptype = colliding
        ry = yy
        rx = xx
        rz = zz
    
        particle_struct.pnum = self.particle_count     
        particle_struct.rx = rx
        particle_struct.ry = ry
        particle_struct.rz = rz
        particle_struct.radius = self.radius
        w_list.append(particle_struct)
        self.particle_count+=1
        self.particles_in_cell_count +=1
        return 0

    def write_test_file(self,index,sel_dict):
        
        with open(self.test_file_name,'w') as f:
            fstr = f"index = {index};\n"     
            f.write(fstr)
            fstr = f"CellAryW = {self.cell_x_len+1};\n"     
            f.write(fstr)
            fstr = f"CellAryH = {self.cell_y_len+1};\n"     
            f.write(fstr)
            fstr = f"CellAryL = {self.cell_z_len+1};\n"     
            f.write(fstr)
            fstr = f"radius = {self.radius};\n"
            f.write(fstr)
            fstr = f"PartPerCell = {self.particles_in_space};\n"
            f.write(fstr)
            fstr = f"pcount = {self.number_particles};\n"
            f.write(fstr)
            fstr = f"colcount = {self.tot_num_collsions};\n"
            f.write(fstr)
            fstr = f"dataFile = \"{self.test_bin_name.replace('/','\\')}\";\n"
            f.write(fstr)
            fstr = f"aprFile = \"{ self.report_file.replace('/','\\')}\";\n"
            f.write(fstr)
            fstr = f"density = {float(sel_dict['cdens'])};\n"
            f.write(fstr)
            fstr = f"pdensity = 0;\n"
            f.write(fstr)
            fstr = f"dispatchx = {sel_dict['dx']};\n"
            f.write(fstr)
            fstr = f"dispatchy = {sel_dict['dy']};\n"
            f.write(fstr)
            fstr = f"dispatchz = {sel_dict['dz']};\n"
            f.write(fstr)
            fstr = f"workGroupsx = {sel_dict['wx']};\n"
            f.write(fstr)
            fstr = f"workGroupsy = {sel_dict['wy']};\n"
            f.write(fstr)
            fstr = f"workGroupsz = {sel_dict['wz']};\n"
            f.write(fstr)
            fstr = f"ColArySize = {64};\n"
            f.write(fstr)
        f.close()


    def do_cells(self,progress_callback):
       
        if self.cfg.particle_enumeration_text == 'random':
            self.rand_data = self.gen_random_numbers_in_range(0, self.number_particles, self.number_particles)    
        
        ret = 0
        self.w_list = []
        self.particle_count = 0

        for zz in range(self.cell_z_len-1):
            progress_callback.emit(zz)
            for yy in range(self.cell_y_len-1):
                for xx in range(self.cell_x_len-1):
                    # Top 4
                    self.place_particles(xx+1.5,yy+1.5,zz+1.45,1,self.w_list)  
                    self.place_particles(xx+1.5,yy+1.5,zz+1.55,0,self.w_list)  
                    # Side 2 colide X plane
                    
                    self.place_particles(xx+1.42,yy+1.0,zz+1.0,1,self.w_list)  
                    self.place_particles(xx+1.57,yy+1.0,zz+1.0,0,self.w_list)  

                    self.place_particles(xx+1.0,yy+1.42,zz+1.0,1,self.w_list)  
                    self.place_particles(xx+1.0,yy+1.57,zz+1.0,0,self.w_list)  

                    self.place_particles(xx+1.0,yy+1.0,zz+1.42,1,self.w_list)  
                    self.place_particles(xx+1.0,yy+1.0, zz+1.57,0,self.w_list)  
                    
        self.write_bin_file(self.w_list)
        return 0
        
        
                                    
        
    

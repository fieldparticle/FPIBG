
from BaseGenData import *

class GenPQBData(BaseGenData):

    last_max_scale = 0
    last_min_scale = 0
    old_rx = 0.0
    old_ry = 0.0
    old_rz = 0.0
    do_max_scale = True
    def __init__(self):
        super().__init__()



    def gen_data(self):
        self.gen_data_base()
        
    def plot_particle_cell(self,file_name):
        self.plot_particle_cell_base(file_name)
    
    
    def place_particles(self,xx,yy,zz,row,col,layer,w_list):

        
        # If particle cont is greater than the required numbe of particles return 3 to end the
        if (self.particle_count >= self.number_particles):
            return 3

        # IF number collsions met return 2
        if(self.particles_in_cell_count > self.particles_in_cell ):
            return 2
        
        # Switch for the range function
        if(self.do_max_scale == True):
            self.do_max_scale = False
        else:
            self.do_max_scale = True


        particle_struct = pdata()
        #print(f"particle: {self.particle_count}, xx={xx}, yy= {yy}, zz={zz}, layer= {layer}, row= {row} col= {col}")
        #                         |offset so no particle is in a cell with a zero in it|
       
        subcell = 1.0/self.particles_in_row
        dist =(subcell-2.0*self.radius) 
        sep = dist/2.0

        self.center_line_length     = 2.0*sep+2.0*self.radius
        # If more colsions are needed
        if(self.collsions_in_cell_count < self.num_collisions_per_cell):
            ry = 0.5 + sep + 2.0*self.radius + 2.0*sep*row+yy
            self.collsions_in_cell_count+=1
            self.collision_count+=1
            particle_struct.ptype = 1
        # Separate partle
        else:
            particle_struct.ptype = 0
            ry = 0.5 + sep + self.radius + self.center_line_length*row+yy

        rx = 0.5 + sep + self.radius + self.center_line_length*col+xx
        rz = 0.5 + sep + self.radius + self.center_line_length*layer+zz
    
        #print(f"row{row}:col{col} <{rx},{ry},{rz}> Cell:<{round(rx)},{round(ry)},{round(rz)}>")
        if self.cfg.particle_enumeration_text == 'random':
            particle_struct.pnum = self.rand_data[self.particle_count]

        elif self.cfg.particle_enumeration_text == 'range':
            if self.do_max_scale == True:
                self.last_max_scale-=1
                particle_struct.pnum = self.last_max_scale
            else:
                self.last_min_scale+=1
                particle_struct.pnum = self.last_min_scale
            
        elif self.cfg.particle_enumeration_text == 'sequential':    
            particle_struct.pnum = self.particle_count + 1    
        particle_struct.rx = rx
        particle_struct.ry = ry
        particle_struct.rz = rz
        particle_struct.radius = self.radius
        w_list.append(particle_struct)
        self.particle_count+=1
        self.particles_in_cell_count +=1

        if self.old_rx < rx:
            self.old_rx = rx
        if self.old_ry < ry:
            self.old_ry = ry
        if self.old_rz < rz:
            self.old_rz = rz
        self.max_cell_location = [round(self.old_rx),round(self.old_ry),round(self.old_rz)]
        return 0
        
    
    def do_cells(self,progress_callback):
        self.old_rx = 0.0
        self.old_ry = 0.0
        self.old_rz = 0.0
        if self.cfg.particle_enumeration_text == 'random':
            self.rand_data = self.gen_random_numbers_in_range(0, self.number_particles, self.number_particles)    
        if self.cfg.particle_enumeration_text == 'scale':
            last_max_scale = self.number_particles

        ret = 0
        self.w_list = []
        self.particle_count = 0
        self.add_null_particle(self.w_list)
        ########################################################
        # This only happens here. The side_length is n
        # but since cells start at zero they go from 0 to n-1
        z_range = self.cell_z_len-1
        y_range = self.cell_y_len-1
        z_range = self.cell_x_len-1
        ########################################################
        for zz in range(z_range):
            progress_callback.emit(zz)
            for yy in range(y_range):
                for xx in range(z_range):
                    self.collsions_in_cell_count = 0
                    self.particles_in_cell_count = 0
                    # Inside a single cell. Process single cell
                    for layer in range(self.particles_in_layers):
                        for row in range(self.particles_in_row): 
                            for col in range(self.particles_in_col):        
                                if self.flg_stop == True:
                                    return 1
                                ret = self.place_particles(xx,yy,zz,row,col,layer,self.w_list)
                                if ret == 3:
                                    if len(self.w_list) > 0:
                                        self.write_bin_file(self.w_list)
                                    return 0
                                if len(self.w_list) >= int(self.cfg.write_block_len_text):
                                    self.write_bin_file(self.w_list)
                                    self.w_list.clear()
        self.write_bin_file(self.w_list)
        return 0
        
        
                                    
        
    

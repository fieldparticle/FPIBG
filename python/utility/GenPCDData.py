
from BaseGenData import *
import math
class GenPCDData(BaseGenData):

    sel_file = None

    def __init__(self):
        super().__init__()


    def calc_side_len(self,part_per_cell,num_parts):
        ii = 0
        while True:
            ii = ii+1
            if(ii*ii*ii*part_per_cell>=num_parts):
                return ii

    
    def add_item(self,p_in_cell,side_len,radius,num_part):
        self.sel_file.write(f"1,8,1,{num_part+1},1,1,{num_part},s,{p_in_cell},{side_len},0.5,{radius:0.4f},0.0,0.0,0.0,0.0,0.0,0.0\n")

    def open_selections_file(self):
        self.sel_file = open(self.itemcfg.selections_file_text,'w')
        self.sel_file.write("wx,wy,wz,dx,dy,dz,tot,sel,cols,sidelen,cdens,radius,vx,vy,vz,px,py,pz\n")

        start = 0.2
        num_part = 117649
        last_side_len = 0
        for ii in range(450):
            rr =  start-ii*0.0005
            center_len = rr*0.15+2.0*rr    
            try :
                particles_in_row = math.floor(1.0/center_len)
            except BaseException as e:
                break
            particles_in_col    = particles_in_row
            particles_in_layer  = particles_in_row

            particles_in_cell   = particles_in_row*particles_in_col*particles_in_layer
            side_len = self.calc_side_len(particles_in_cell,num_part)
            if last_side_len != side_len:
                self.add_item(particles_in_cell,side_len,rr,num_part)
                last_side_len = side_len
            #if side_len < int(self.itemcfg.last_sidlen_text):
            #    break
        
        self.sel_file.flush()
        self.sel_file.close()


        try:
            with open(self.itemcfg.selections_file_text,"r",newline='') as csvfl:
                reader = csv.DictReader(csvfl, delimiter=',',dialect='excel')
                for row in reader:
                    if row["sel"] == 's':
                        self.select_list.append(row)
        except BaseException as e:
            self.log.log(self,f"Error opening:{self.itemcfg.selections_file_text}, err:", e)
        return self.select_list        
        
    
    def calulate_cell_properties(self,index,sel_dict):
        
        try :
            self.collision_density           = float(sel_dict['cdens'])
            self.number_particles       =  int(sel_dict['tot'])
            self.radius                 = float(sel_dict['radius'])
            self.sepdist                =  float(self.cfg.particle_separation_text)
        except BaseException as e:
            self.log.log(self,f"Key error in record:",e)
        self.center_line_length          = 2*self.radius  + self.radius*self.sepdist
        self.particles_in_row       = int(math.floor(1.00 /self.center_line_length))
        self.particles_in_col       = int(math.floor(1.00 /self.center_line_length))
        self.particles_in_layers    = int(math.floor(1.00 /self.center_line_length))
        self.particles_in_cell      = self.particles_in_row*self.particles_in_col*self.particles_in_layers
        self.particles_in_space	    = int(self.particles_in_row*self.particles_in_col*self.particles_in_layers)
        # Somtimes we do very small number of particles to check the pattern
        if (self.particles_in_space > self.number_particles):
            self.particles_in_space = self.number_particles
        self.cell_array_size      = self.particles_in_space+10
        self.num_collisions_per_cell = math.ceil(self.particles_in_space * self.collision_density/2.0)
        # Calulate side length based on particles per cell
        side_len = 0
        side_len = self.calc_side_len(self.particles_in_cell,self.number_particles)
       #while True:
        #    side_len += 1
        #    if (side_len * side_len * side_len * self.particles_in_space >= self.number_particles):
        #        break
        self.side_length = side_len
        print(f"SideLength from create:{sel_dict['sidelen']}, and calulated:{side_len}")
        self.cell_x_len = self.side_length+1
        self.cell_y_len = self.side_length+1
        self.cell_z_len = self.side_length+1
        self.tot_num_cells = self.number_particles / self.particles_in_space
        self.tot_num_collsions = math.ceil(int(self.tot_num_cells *self.num_collisions_per_cell*2.0 ))
        self.set_file_name = "{:03d}CollisionDataSet{:d}X{:d}X{:d}".format(index,self.number_particles,self.tot_num_collsions,side_len)
        self.test_file_name = self.cfg.data_dir + '/' + self.set_file_name + '.tst'
        self.test_bin_name = self.cfg.data_dir + '/' + self.set_file_name + '.bin'
        self.report_file = self.cfg.data_dir + '/' + self.set_file_name 

        self.log.log(self,f"Collsion Density: { self.collision_density},Number particles:{self.number_particles},Radius: {self.radius}, Separation Dist: {self.sepdist }, Center line length: {self.center_line_length:.2f}")
        self.log.log(self,f"Particles in row: {self.particles_in_row}, Particles in Column: {self.particles_in_col}, Particles per cell: {self.particles_in_cell}")
        self.log.log(self,f"Particles in space: {self.particles_in_space}, Cell array size: {self.cell_array_size }")
    
    def gen_data(self):
        self.gen_data_base()
        self.open_bin_file()
        
    def plot_particle_cell(self,file_name):
        self.plot_particle_cell_base(file_name)
    
    
    def place_particles(self,xx,yy,zz,row,col,layer,w_list):
        
        if(self.particles_in_cell_count > self.particles_in_cell ):
            return 2
        
        if (self.particle_count >= self.number_particles):
            return 3
        
        #print(f"particle: {self.particle_count}, xx={xx}, yy= {yy}, zz={zz}, layer= {layer}, row= {row} col= {col}")
        #                         |offset so no particle is in a cell with a zero in it|
        particle_struct = pdata()
        
        
        if(self.collsions_in_cell_count <= self.num_collisions_per_cell ):
            ry = 0.5 + 2.0*self.radius + self.center_line_length*col+yy
            self.collsions_in_cell_count+=2
            particle_struct.ptype = 1
        else:
            particle_struct.ptype = 0
            ry = 0.5 + self.radius + 0.15 * self.radius + self.center_line_length*col+yy

        rx = 0.5 + self.radius + 0.15 * self.radius + self.center_line_length*row+xx
        rz = 0.5 + self.radius + 0.15 * self.radius + self.center_line_length*layer+zz
        
        particle_struct.pnum = self.particle_count
        particle_struct.rx = rx
        particle_struct.ry = ry
        particle_struct.rz = rz
        particle_struct.radius = self.radius
        
        #packed_struct = bytearray(particle_struct)
        w_list.append(particle_struct)
        self.particle_count+=1
        self.particles_in_cell_count +=1
        return 0
        
    
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
                    self.collsions_in_cell_count = 0
                    self.particles_in_cell_count = 0
                    # Inside a single cell. Process single cell
                    for layer in range(self.particles_in_layers):
                        for col in range(self.particles_in_col):        
                            for row in range(self.particles_in_row):                            
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
    
    

%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date:  $
% $HeadURL:  $
% $Id:  $
%*******************************************************************
%***                         DESCRIPTION                         ***
%*******************************************************************
%@doc
%@module
%			@author: Jackie Michael Bell
%			COPYRIGHT <cp> Jackie Michael Bell
%			Property of Jackie Michael Bell<rtm>. All Rights Reserved.
%			This source code file contains proprietary
%			and confidential information.
%
%
%@head3 		Description. | 
%               
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision:  $
%*
%*
%******************************************************************/
classdef (ConstructOnLoad=true) mps  < handle
        properties
            % Run time parameters
            p               = struct;   % Particle structure
            m_C              = [];
            SubDivTable     = table;
            collisionCount  = 0;
            colary          = [];
			num_particles	= 0;        % number of particles
			num_collisions	= 0;
            ptot            = 1;        % Total particles
			dt              = 0;        % Time step [s]
            t 	            = 0;        % Currrent time
            m_iter          = 0;        % iteration/frame
            numVox          = 0;        % number of voxels
			wary            = [];       % Wall array   
            XMAX            = 1;        % Wall position flag
            XMIN            = 2;        % "
            YMAX            = 3;        % "
            YMIN            = 4;        % "
            ZMAX            = 5;        % "
            ZMIN            = 6;        % "
            VPLType         = 0;        % PlotType Flag
            VPLTXY          = 1;        % Plot with xy view
            VPLTYZ          = 2;        % Plot with yz view
            VPLT3D1         = 3;        % plot 3D view
            VPLTCUSTOM      = 4;        % Custom plot
            VPLTXZ          = 5;
            NE              = 1;        % Quadrant for link list.
            NW              = 2;        % "
            SW              = 3;        % "
            SE              = 4;        % "
            endFrame        = 0;        % Simulation end frame
            startFrame      = 0;        % Simulation start frame
            VViewAngle      = [0.0,0.0];% Custom viewing angle
            LayersNum       = 0;        % Number of layers in z-direction
            LayersSize      = 0;        % Size of layer 2D square
            gpu_num         = 0;        % GPU number
            gpu_name        = 0;        % GPU name
            height          = 0;        % screen height
            width           = 0;        % Screen width
            monitor_num     = 0;        % monitor number
			movie_dir		= '';       % movie directory
			movie_name		= '';       % movie name    
			movie_flg		= 0;        % movie flag, true=make moive
			writerObj;                  % Matlab movie writer obj
            testName        = '';       % test file to run
            voxCnt          = 0;        % number of voxels to plot
            data_name       = '';
            data_dir        = '';
            data_handle;
            MAX_CORNERS     = 8;
            MAX_OCCUPANCY   = 8;
            MAX_ARY         = 24;
            CameraPos       = [];
            CameraTarget    = [];
            CameraViewAngle = 0;

            TK              = 0; %System temp
            base_ts         = 0;        % Base temerature low
            base_te         = 0;        % Base temerature high
            base_tr         = 0;        % Base temerature range
			base_acc_s		= 0.0;
			base_vel_s		= 0.0;
			base_acc_a		= 0.0;
			base_vel_a		= 0.0;
            avgdr           = 6.022E23; % Avagrado 1/mol
            k_B             = 1.380649E-23; %Boltzman Constant J/K 
            tot_subst       = 0;
            sl       		= struct();	% Substance list
            slv				= StructSubstanceVel();	% Substance velcoity accel data
            rs				= 0;			% Index of size range divisor
			ra				= 0;			% Index of aceleration range divisor
            pincellcount	= 0;
			ptotcount		= 0;
			cincellcount	= 0;
			cincell 		=0;
			pinlayer		= 0;
			pincell			= 0;
			pinrow			= 0;
			centerlen		= 0;
			totparts		= 0;
			SideLen			= 0;
			cdensity		= 0;

			
        end 
        methods
            function SetVoxelNum(obj,Num)
                obj.voxCnt = Num;
            end
            function obj = mps()
                obj.p          = StructParticle();
               
			end
            function SetLayers(obj,LayersNum,LayersSize)
                obj.LayersNum        = LayersNum;
                obj.LayersSize       = LayersSize;
            end
            function SetTimeRange(obj,Start,End)
                obj.startFrame      = Start;
                obj.endFrame        = End;
            end
            function SetSystemTemp(obj,TK)
                obj.TK = TK;
            end
            function SetTempRangeLow(obj,TK)
                obj.base_ts = TK;
            end
            function SetTempRangeHigh(obj,TK)
                obj.base_te = TK;
            end
            function pstruct = GetNewPStruct(obj)
                pstruct = obj.p;
            end
            function obj = SetTimeStep(obj,Dt)    
                obj.dt = Dt;
            end
            function SetGPUName(obj,Name)
                obj.gpu_name = Name;
            end
            function SetTestFile(obj,test)
                obj.testName    = test;
                
            end
            function SetMovieFlag(obj,flg)
                obj.movie_flg = flg;
            end
            function SetMovieDir(obj,Dir)
                obj.movie_dir = Dir;
            end
            function SetMovieName(obj,Name)
                obj.movie_name = Name;
            end
          


    end
end
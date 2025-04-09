%******************************************************************
%***      m PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2022-02-10 13:08:17 -0800 (Thu, 10 Feb 2022) $
% $HeadURL: https://jbworkstation/svn/svnroot/svnmatlab/common/@Scene/PlotMultiEval.m $
% $Id: PlotMultiEval.m 54 2022-02-10 21:08:17Z jb $
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
%@normal
%********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision: 54 $
%*
%*
%******************************************************************/
function hdl = PlotParticles(obj,RowNum,Iter)
    fprintf('Creating Particle Plot.\r\n');
    

    % ---------------------
    % Sub plot particle image.
    % ---------------------
    axis('square');
    hold on
    colorr = [1.0,0.0,0.0];
	for ii = 1:obj.ptot-1
        % Plot circle fields
		%plot(obj.p(ii).xpos,obj.p(ii).ypos,'*k');
		[xcrc,ycrc] = obj.CircleFields(ii);
		plot(xcrc,ycrc,'LineWidth',2,'Color',colorr);
       % text(obj.p(ii).xpos+.05,obj.p(ii).ypos+.05,sprintf("%d",ii));

if 0
        if obj.flag_accel(ii) ~= 0
            % Plot acceleration Vectors.
            vectarrow(obj.p(ii).uvec_accx,[0.0 1.0 0.0]);
            vectarrow(obj.p(ii).uvec_accy,[0.0 1.0 0.0]);
            vectarrow(obj.p(ii).uvec_acc,[0.0 1.0 0.0]);
        end

        if obj.flag_intersect == 1
            % Plot Intersection Vectors
            if obj.flag_isect(ii) == 1
                vectarrow(obj.p(ii).vec_isec1,[0.0 0.5 1.0]);
                vectarrow(obj.p(ii).vec_isec2,[0.5 0.0 1.0]);
            end
    
            % Plot Orientation Vector
            if obj.flag_orient(ii) == 1
                vectarrow(obj.p(ii).vec_orient,[1.0 ii*0.3 0.0]);
            end
            
            % Plot Proximity Vector
            if obj.flag_prox(ii) == 1
                vectarrow(obj.p(ii).vec_prox_a,[1.0 ii*0.3 0.1]);
                vectarrow(obj.p(ii).vec_prox_c,[1.0 0.1 ii*0.3]);
            end
        end
    end
end    
    
	ylabel('y (m)');
    xlabel('x (m)');

   
	hold off
    
    box on
	
	grid on

end

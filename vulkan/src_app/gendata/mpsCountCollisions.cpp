/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-05-03 15:30:42 -0400 (Wed, 03 May 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src/vulkan/DescriptorSSBO.cpp $
% $Id: DescriptorSSBO.cpp 28 2023-05-03 19:30:42Z jb $
%*******************************************************************
%***                         DESCRIPTION                         ***
%*******************************************************************
@doc
@module
			@author: Jackie Michael Bell<nl>
			COPYRIGHT <cp> Jackie Michael Bell<nl>
			Property of Jackie Michael Bell<rtm>. All Rights Reserved.<nl>
			This source code file contains proprietary<nl>
			and confidential information.<nl>


@head3 		Description. |
@normal


********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision: 28 $
%*
%*
%******************************************************************/

#include "VulkanObj/VulkanApp.hpp"
#include "VulkanObj/pdata.hpp"
#include "gendata/GenResourceVertexParticle.hpp"
uint32_t m_SideLength = 0;
uint32_t GenResourceVertexParticle::CountCollisions()
{
	std::vector< pdata> m_Particle;
	uint32_t coLocCount = 0;
	
	uint32_t missed_link_count = 0;
	// Reading from it
	std::ifstream input_file(m_FullBinFile, std::ios::binary);
	if (!input_file.is_open())
		{
			std::string err = "Cannot create collsion verification data file::" + m_FullBinFile;
			throw std::runtime_error(err.c_str());
		}
	pdata part_pos;
	uint32_t m_NumParticles = 0;
	uint32_t count = 0;
	float radius=0;
	while (input_file.peek() != EOF)
	{
		input_file.read((char*)&part_pos, sizeof(part_pos));
		if (!input_file.is_open())
		{
			std::string err = "Unable to open particle data file:" + m_FullBinFile;
			throw std::runtime_error(err.c_str());
		}

		m_Particle.push_back(part_pos);
#if 0
		mout << "Particle #" << (float)part_pos.pnum << ende;
		mout << "rx: " << (float)part_pos.rx << ende;
		mout << "ry: " << (float)part_pos.ry << ende;
		mout << "rz: " << (float)part_pos.rz << ende;
		mout << ende;
#endif
		radius = (float)part_pos.radius;

	}
	uint32_t colCount = 0;
	double xT = 0;
	double yT = 0;
	double zT = 0;
	double xP = 0;
	double yP = 0;
	double zP = 0;
	double dsq = 0;
	double rsq  = pow((2*radius),2);
	const auto start{ std::chrono::steady_clock::now() };
	
	
	for (pdata Pin : m_Particle)
	{
		xT = Pin.rx;
		yT = Pin.ry;
		zT = Pin.rz;
		count++;
		for (pdata Pout : m_Particle)
		{
			
			
			xP = Pout.rx;
			yP = Pout.ry;
			zP = Pout.rz;

			dsq = pow((xP - xT), 2) + pow((yP - yT), 2) + pow((zP - zT), 2);
			if (abs((dsq - rsq)) < 0.00001)
				coLocCount++;
			if (xP != xT || yT != yP || zT != zP)
			{
				
				if (dsq < rsq)
					colCount++;
				
			}
		
		}
		if (count % 1000 == 0)
			std::cout << "At:" << count << " ColCount:" << colCount << std::endl;
	}	
	const auto end{ std::chrono::steady_clock::now() };
	const std::chrono::duration<double> elapsed_seconds{ end - start };
	std::cout << "Collison Verification:" 
		<< colCount << " Of :" << count 
		<< " Particles," 
		<< " Colocated:" << coLocCount 
		<< " SideLen:" << m_SideLength
		<< " Radius:" << radius  
		<< " Duration:" << elapsed_seconds.count() << " s" << std::endl;

	mout << "Collisons Verification:"
		<< colCount << " Of :" << count
		<< " Particles,"
		<< " Colocated:" << coLocCount
		<< " SideLen:" << m_SideLength
		<< " Radius:" << radius
		<< " Duration:" << elapsed_seconds.count() << " s" << ende;

	return colCount;
}
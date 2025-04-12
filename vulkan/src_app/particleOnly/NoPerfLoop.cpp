/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-06-12 16:17:58 -0400 (Mon, 12 Jun 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src_app/mps/main.cpp $
% $Id: main.cpp 31 2023-06-12 20:17:58Z jb $
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
%*$Revision: 31 $
%*
%*
%******************************************************************/
#include "VulkanObj/VulkanApp.hpp"
#include <filesystem>

namespace fs = std::filesystem;

int NoPerfLoop(PerfObj* perfObj, TCPObj* tcp, TCPObj* tcpsapp,DrawObj* DrawInstance, VulkanObj* VulkanWin, ResourceGraphicsContainer* rgc, ResourceComputeContainer* rcc)
{
	TimerObj* timerstep;
	uint32_t			endFrame		= CfgApp->GetUInt("application.end_frame", true);
	bool				stopondata		= CfgApp->GetBool("application.stopondata", true);
	uint32_t			frameDelay		= CfgApp->GetInt("application.frame_delay", true);
	float				deltaTime		= 0.0f;
	float				lastFrame		= 0.0f;
	uint32_t			quit_event		= 0;
	uint32_t			AutoWait		=  CfgApp->GetInt("application.seriesLength", true);;
	size_t				aprCount		= 0;
	double				lastTime		= glfwGetTime();
	double				lastCapTime     = 0;
	int					nbFrames		= 0;
	bool				doAuto			= CfgApp->GetBool("application.doAuto", true);
	bool				captureFrame	= MpsApp->GetBool("captureFrame", true);
	bool				copyFrame		= MpsApp->GetBool("copyFrame", true);
	double				capFrameDelay	= MpsApp->GetFloat("cap_frame_delay", true);	
	bool				doCap			= MpsApp->GetBool("do_cap", true);
	uint32_t			imgNum			= 0;		
	double				currentTime		=0.0;

	timerstep = new TimerObj;
	
	if (perfObj->m_SeriesLength != 0)
		AutoWait = perfObj->m_SeriesLength;
	else
		AutoWait = 61;

	perfObj->m_ReportBuffer.resize(AutoWait);

	SetCallBacks(VulkanWin);

	try
	{
		// While window is open.
	
		
		while (!glfwWindowShouldClose(VulkanWin->GetGLFWWindow())
			&& glfwGetKey(VulkanWin->GetGLFWWindow(), GLFW_KEY_ESCAPE) != GLFW_PRESS)
		{
			
			timerstep->reset();
			float currentBuffer = static_cast<float>(glfwGetTime());
			deltaTime = currentBuffer - lastFrame;
			lastFrame = currentBuffer;
			
			// Get the current time
			double currentTime = glfwGetTime();

			//Esc normal termination
			if (QuitEvent)
			{
				VulkanWin->m_quit_event = 1;
				return 0;
			};

			if (VulkanWin->m_quit_event > 1)
			{
				std::ostringstream  objtxt;
				objtxt << "Quit Loop Error number:" << VulkanWin->m_quit_event <<  std::ends;
				throw std::runtime_error(objtxt.str());
			};

			
			// Poll window events.
			glfwPollEvents();

			// Increment frame counter
			nbFrames++;
			
			// Check to see if caputre delay has been met then capture this frame
			

			// Test for frame number end.
			if (endFrame != 0)
			{
				if (VulkanWin->m_FrameNumber >= endFrame)
					break;

			};
	
			// Sent the cap counter first time.
			if(nbFrames == 0)
				lastCapTime = currentTime;

			DrawInstance->DrawFrame();
			
			// Get the current time
			currentTime = glfwGetTime();
			

			double ddt = currentTime - lastCapTime;
			if (ddt >= capFrameDelay && doCap == true && tcpsapp != nullptr)
			{
				mout << "ddt:" << ddt << " capFrameDelay:" << capFrameDelay << ende;;
				std::ostringstream  objtxt;
				objtxt	<< "perfline,"								// 0-Identifier 
						<< "," << VulkanWin->m_FrameNumber			// 1-Total frames
						<< "," << ddt / double(nbFrames)			// 2-FPS
						<< "," << double(nbFrames) /ddt				// 3-SPF
						<< "," << CfgTst->GetUInt("pcount",true)	// 4-Number of particles
						<< std::endl;
				tcpsapp->WritePort(objtxt.str().c_str());
				tcpsapp->ReadPort();
				lastCapTime = currentTime;
			}

			if(Extflg == true)
				throw std::runtime_error("External Flag Exit.");

			VulkanWin->m_FrameNumber++;
			
			nbFrames++;
			if (currentTime - lastTime >= 1.0)
			{
			
				aprCount++;
				std::cout << "Seconds:" << aprCount << " FrameNumber:" << VulkanWin->m_FrameNumber << " FRate:" << 1000.0 / double(nbFrames) << " ms/F, " << " FPS:" << nbFrames << " F/s." << std::endl;
				nbFrames = 0;
				lastTime += 1.0;
			}

			Sleep(frameDelay);
			vkDeviceWaitIdle(VulkanWin->GetLogicalDevice());
		}

		vkDeviceWaitIdle(VulkanWin->GetLogicalDevice());
		
	}
	catch (const std::exception& e)
	{
		mout << "STANDARD ERROR:" << e.what() << ende;
		mout << "End at frame:" << VulkanWin->m_FrameNumber << ende;
		return EXIT_FAILURE;
	}

	mout << "End at frame:" << VulkanWin->m_FrameNumber << ende;
	
	return 0;
};

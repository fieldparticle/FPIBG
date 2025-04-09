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

int NoPerfLoop(PerfObj* perfObj, TCPObj* tcp, DrawObj* DrawInstance, VulkanObj* VulkanWin, ResourceGraphicsContainer* rgc, ResourceComputeContainer* rcc)
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
	int					nbFrames		= 0;
	bool				doAuto			= CfgApp->GetBool("application.doAuto", true);
	bool				captureFrame	= MpsApp->GetBool("captureFrame", true);
	bool				copyFrame		= MpsApp->GetBool("copyFrame", true);
		
	uint32_t imgNum=0;

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
			float currentBuffer = static_cast<float>(glfwGetTime());
			deltaTime = currentBuffer - lastFrame;
			lastFrame = currentBuffer;

			
			// Test for frame number end.
			if (endFrame != 0)
			{
				if (VulkanWin->m_FrameNumber >= endFrame)
					break;

			};

			// Poll window events.
			glfwPollEvents();
			// Draw frame.
			double currentTime = glfwGetTime();
			DrawInstance->DrawFrame();

		if(copyFrame	== true)
		{
			if (currentTime - lastTime >= 0.5)
			{
				imgNum++;
				DrawInstance->SaveImage(imgNum);
			}
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

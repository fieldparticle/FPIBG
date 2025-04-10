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

int Loop(PerfObj* perfObj, TCPObj* tcp,TCPObj* tcpsapp, DrawObj* DrawInstance, VulkanObj* VulkanWin, ResourceGraphicsContainer* rgc, ResourceComputeContainer* rcc)
{
	TimerObj* timerstep;
	uint32_t			endFrame		= CfgApp->GetUInt("application.end_frame", true);
	bool				stopondata		= CfgApp->GetBool("application.stopondata", true);
	uint32_t			frameDelay		= CfgApp->GetInt("application.frame_delay", true);
	float				deltaTime		= 0.0f;
	float				lastFrame		= 0.0f;
	uint32_t			quit_event		= 0;
	uint32_t			seriesLength	=  CfgApp->GetInt("application.seriesLength", true);;
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

	timerstep = new TimerObj;
	
	if (perfObj->m_SeriesLength != 0)
		seriesLength = perfObj->m_SeriesLength;
	else
		seriesLength = 61;

	perfObj->m_ReportBuffer.resize(seriesLength);

	SetCallBacks(VulkanWin);

	try
	{
		// While window is open.
	
		
		while (!glfwWindowShouldClose(VulkanWin->GetGLFWWindow())
			&& glfwGetKey(VulkanWin->GetGLFWWindow(), GLFW_KEY_ESCAPE) != GLFW_PRESS)
		{
			
			perfObj->m_ReportBuffer[aprCount].SecondPerFrame = timerstep->elapsed();
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

			// Poll window events.
			glfwPollEvents();

			// Get the current time
			double currentTime = glfwGetTime();

			// Draw the frame.
			DrawInstance->DrawFrame();

			// If the global exit flag has been set exit.
			if(Extflg == true)
				throw std::runtime_error("External Flag Exit.");

			// Increment frame number to be sent as push element.
			VulkanWin->m_FrameNumber++;

			// Sewt the cap counter first time.
			if(nbFrames == 0)
				lastCapTime = currentTime;

			// Increment frame counter
			nbFrames++;
			double ddt = currentTime - lastCapTime;

			// Check to see if caputre delay has been met then capture this frame
			if (ddt >= capFrameDelay && doCap == true)
			{
				mout << "ddt:" << ddt << " capFrameDelay:" << capFrameDelay << ende;;
				tcpsapp->WritePort("next");
				lastCapTime = currentTime;
			}

			// Load the perf data if less than series length
			if (currentTime - lastTime >= 1.0)
			{
				perfObj->m_ReportBuffer[aprCount].FrameRate = static_cast<float>(nbFrames);

				if (aprCount < seriesLength )
				{
					perfObj->m_ReportBuffer[aprCount].Second = aprCount;
					perfObj->m_ReportBuffer[aprCount].FrameRate = static_cast<float>(nbFrames);
					perfObj->m_ReportBuffer[aprCount].SecondPerFrame = static_cast<float>(aprCount);
					perfObj->m_ReportBuffer[aprCount].ComputeExecutionTime =
						DrawInstance->m_ComputeCommandObj->m_ExecutionTime;
					perfObj->m_ReportBuffer[aprCount].GraphicsExecutionTime =
						DrawInstance->m_GraphicsCommandObj->m_ExecutionTime;

					for (int ii = 0; ii < rgc->m_DRList.size(); ii++)
						rgc->m_DRList[ii]->AskObject(aprCount);

					for (int ii = 0; ii < rcc->m_DRList.size(); ii++)
						rcc->m_DRList[ii]->AskObject(aprCount);
					aprCount++;
				}

				// If it has been 60 second or the amoint set in series length write the perf data
				// and return.
				if (aprCount == seriesLength && seriesLength != 0)
				{
					aprCount++;
					perfObj->Doperf(DrawInstance, VulkanWin, tcp, aprCount);
					vkDeviceWaitIdle(VulkanWin->GetLogicalDevice());
					return 0;
				}
			
				std::cout << "Seconds:" << aprCount << " FrameNumber:" << VulkanWin->m_FrameNumber << " FRate:" << 1000.0 / double(nbFrames) << " ms/F, " << " FPS:" << nbFrames << " F/s." << std::endl;
				nbFrames = 0;
				lastTime += 1.0;
			}
			// Sleep if frame_delay is set
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

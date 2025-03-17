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

int Loop(PerfObj* perfObj, TCPObj* tcp, DrawObj* DrawInstance, VulkanObj* VulkanWin, ResourceGraphicsContainer* rgc, ResourceComputeContainer* rcc)
{
	TimerObj* timerstep;
	uint32_t			endFrame    = CfgApp->GetUInt("application.end_frame", true);
	bool				stopondata  = CfgApp->GetBool("application.stopondata", true);
	uint32_t			frameDelay  = CfgApp->GetInt("application.frame_delay", true);
	float				deltaTime	= 0.0f;
	float				lastFrame	= 0.0f;
	uint32_t			quit_event	= 0;
	uint32_t			AutoWait	=  CfgApp->GetInt("application.seriesLength", true);;
	size_t				aprCount	= 0;
	double				lastTime	= glfwGetTime();
	int					nbFrames	= 0;
	uint32_t imgNum=0;

	timerstep = new TimerObj;
	
	if (perfObj->m_SeriesLength != 0)
		AutoWait = perfObj->m_SeriesLength;
	else
		AutoWait = 61;

	perfObj->m_ReportBuffer.resize(AutoWait);
#ifdef DOCAP				
	SetupCapture();
#endif

	SetCallBacks(VulkanWin);
	

	try
	{
		// While window is open.
	
		
		while (!glfwWindowShouldClose(VulkanWin->GetGLFWWindow())
			&& glfwGetKey(VulkanWin->GetGLFWWindow(), GLFW_KEY_ESCAPE) != GLFW_PRESS)
		{
			
			//if(tcp != nullptr)
			//	if(tcp->ReadPortN() == 1)
			//		return 1;

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
#ifdef DOCAP			
			if (currentTime - lastTime >= 0.5)
			{
				imgNum++;
				Capture(imgNum);
			}
#endif

#define DOCOPY
#ifdef DOCOPY
			if (currentTime - lastTime >= 0.5)
			{
				imgNum++;
				DrawInstance->SaveImage();
			}
#endif
			if(Extflg == true)
				throw std::runtime_error("External Flag Exit.");

			VulkanWin->m_FrameNumber++;
			
			nbFrames++;
			if (currentTime - lastTime >= 1.0)
			{
				if (aprCount < AutoWait )
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

					

					if(tcp != nullptr)
					{
						std::ostringstream tcpbuf;
						std::string stripflnm =  fs::path(perfObj->m_AprFile).filename().string();
						#ifndef NDEBUG
							stripflnm = stripflnm + "D.csv";
						#else
							stripflnm = stripflnm + "R.csv";
						#endif

						if(aprCount < AutoWait-1)
							tcpbuf << "perfline,"	<< "File:" << stripflnm << "," 
													<< "Sec:" << perfObj->m_ReportBuffer[aprCount].Second << ","
									<< "FrameRate:" << perfObj->m_ReportBuffer[aprCount].FrameRate << ",continue";
						else
							tcpbuf << "perfline,"	<< "File:" << stripflnm << "," 
													<< "Sec:" << perfObj->m_ReportBuffer[aprCount].Second << ","
									<< "FrameRate:" << perfObj->m_ReportBuffer[aprCount].FrameRate << ",endline";
						tcp->WritePort(tcpbuf.str());
					}
					aprCount++;
				}
				
				
#if 0
				if (AutoWait == 0 && cfg->m_DoAuto )
				{
					aprCount++;
					Doperf(DrawInstance, VulkanWin, rgc,rcc,aprCount);
					if (VulkanWin->m_FrameNumber >= AutoWait)
					{
						break;
					}
				}
#endif
				if (aprCount == AutoWait && AutoWait != 0)
				{
					aprCount++;
				
					perfObj->Doperf(DrawInstance, VulkanWin, tcp, aprCount);
					if (stopondata)
					{
						break;
					}
					
				}
				

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


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
#define WIN32_LEAN_AND_MEAN
#include <iostream>
#include <thread>

#include "VulkanObj/VulkanApp.hpp"
#include "windows.h"
#include "TCPSObj.hpp"
#include "TCPCObj.hpp"
MsgStream			mout;
ConfigObj*			CfgTst;
ConfigObj*			MpsApp;
ConfigObj*			CfgApp;

int main() try
{
	// Open mout log and report working directory
	std::cout << "Starting" << std::endl;
	mout.Init("particle.log", "Particle");
	std::filesystem::path cwd = std::filesystem::current_path();
	std::cout << "Working Directory :" << cwd.string().c_str() << std::endl;
	mout << "Working Directory :" << cwd.string().c_str() << ende;
	
	// Read the configuration file from mps.cfg
	mout << "Create mps" << ende;
	MpsApp = new ConfigObj;
	MpsApp->Create("mps.cfg");
	mout << "Open mps" << ende;

	//Open the cfg. file for this applcation
	CfgApp = new ConfigObj;
	CfgApp->Create(MpsApp->GetString("studyFile", true));
	mout << "Study File Config" << ende;

	// Create the global test file object to hold particlars about these tests
	CfgTst = new ConfigObj;

	// Create and open the server port for the FPIBGUtility application.
	TCPObj* tcps = new TCPObj;
	tcps->SetServerPort(MpsApp->GetString("server_port",true));
	std::cout << "FPIBG Server Listening on port:" << tcps->GetServerPort() << std::endl;
	tcps->SetBufSize(MpsApp->GetInt("buffer_size",true));


	TCPObj* tcpsapp = nullptr;

	bool doCap = MpsApp->GetBool("do_cap", true);
	bool capture_image_local = MpsApp->GetBool("capture_image_local", true);
	

	// Create a perf object to perform performance and verification.
	PerfObj* pf = new PerfObj();
	pf->Create();

	// Find out if we are doing a series or a single test
	bool autoFlag = CfgApp->GetBool("application.doAuto", true);

	// Set the server port to listen - will block here.
	tcps->Create();
	tcps->Connect();

    int ret = 0;
    while (ret == 0)
    {
		// read the command from the FPIBGUtility app.
        ret = tcps->ReadPort();
		if(ret == 1)
		{
			tcps->Create();
			tcps->Connect();
			ret = 0;
		}

        if(tcps->GetBuffer().compare("quit")==0)
        {
			ret = 1;
			break;
		}
		if(tcps->GetBuffer().compare("runsim")==0)
		{
			std::cout << "Recieved Run" << std::endl;
			// If capture image is true and capture to image locally is false 
			// then set up the tcpip server to send command to the capture app.
			if(doCap == true)
			{
		
				// Create a client to exchnage commands with the capture app.
				tcpsapp = new TCPObj;
				tcpsapp->SetServerPort(MpsApp->GetString("capture_cmd_port",true));
				tcpsapp->SetBufSize(MpsApp->GetInt("buffer_size",true));
		
				tcpsapp->Create();
				LaunchExecutable("CaptureApp.exe", "none") ;
					mout << "Connecting to capture thread." << ende;
				tcpsapp->Connect();
				std::string cmd = "start";
				tcpsapp->WritePort(cmd);
			}

			ret=ParticleOnly(pf,tcps,tcpsapp);
			tcps->WritePort("simdone");
        }

		// Run series 
		if(tcps->GetBuffer().compare("runseries")==0)
        {
			std::cout << "Recieved Run" << std::endl;
			tcps->m_SRecvBuf = "";
			// If capture is enabled launch the app
			ret = pf->DoStudy(tcps,nullptr);
			tcps->WritePort("perfdone,tcp");
        }

		if(tcps->GetBuffer().compare("runsim")==0)
        {
			tcps->m_SRecvBuf = "";
			CfgTst->Create(CfgApp->GetString("application.testfile", true));	
			ret=ParticleOnly(pf,tcps,nullptr);

        }
		if(tcps->GetBuffer().compare("sndcsv")==0)
		{
			tcps->m_SRecvBuf = "";
			tcps->SendPerfFile("Particle.cfg",1);
		}
		if(tcps->GetBuffer().compare("rcvcsv")==0)
		{
			tcps->m_SRecvBuf = "";
			tcps->SendPerfFile("Particle.cfg",1);
		}
		if(tcps->GetBuffer().compare("sendimg")==0)
		{
			tcps->m_SRecvBuf = "";
			tcps->SendImgFile("logo.png");
		}
		if(tcps->GetBuffer().compare("test")==0)
		{
			std::cout << "Recieved Test" << std::endl;
			std::string outbuf = "Recieved Test : OK";
			tcps->WritePort(outbuf);
			outbuf.clear();
		}
		

    }
	tcps->Close();
	return ret;
}

#if 1
catch (const std::exception& e)
{

	mout << "EXITING| TYPE:" << typeid(e).name() << " MSG:" << e.what() << ende;
	std::cout << "EXITING| TYPE:" << typeid(e).name() << " MSG:" << e.what() << std::endl;
	exit(1);
}
#endif

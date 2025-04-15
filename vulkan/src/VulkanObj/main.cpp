
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
#include "windows.h"
MsgStream			mout;
ConfigObj*			CfgTst;
ConfigObj*			MpsApp;
ConfigObj*			CfgApp;
#include "windows.h"
#include "tcpip/TCPSObj.hpp"
#include "tcpip/TCPCObj.hpp"
void LaunchExecutable(std::string path, std::string cmd) ;
int main() try
{
	
	mout.Init("particle.log", "Particle");
	mout << "Starting FPIBG\r\n" << ende;
	MpsApp = new ConfigObj;
	MpsApp->Create("mps.cfg");
	CfgApp = new ConfigObj;
	CfgApp->Create(MpsApp->GetString("studyFile", true));
	std::string app = CfgApp->GetString("application.app",true);

	CfgTst = new ConfigObj;
	
	PerfObj* pf = new PerfObj();
	pf->Create();
	
	std::filesystem::path cwd = std::filesystem::current_path();
	mout << "Working Directory :" << cwd.string().c_str() << ende;


	TCPObj* tcpsapp = nullptr;

	bool doCap = MpsApp->GetBool("do_cap", true);
	bool capture_image_local = MpsApp->GetBool("capture_image_local", true);
	
	// Get test type
	std::string testtype = CfgApp->GetString("application.testtype", true);
	TCPObj* tcps = nullptr;
	if(testtype.compare("bcd") == 0)
	{

		
		if (CfgApp->GetBool("application.doAuto", true) == true)
		{
			mout << "Do study :" << ende;
			if (pf->DoStudy(tcps,tcpsapp))
			{
				if(doCap == true)
				{
					tcpsapp->WritePort("quit");
					tcpsapp->Close();
				}
				return 1;
			}

		}
		else
		{
			std::string testfile = "application." + testtype + ".testfile";
			CfgTst->Create(CfgApp->GetString(testfile, true));	
			if (ParticleOnly(pf,tcps,tcpsapp))
			{
				if(doCap == true)
				{
					tcpsapp->WritePort("quit");
					tcpsapp->Close();
				}
				return 1;
			}
		}
		return 0;
	}
	if(testtype.compare("cdn") == 0)
	{

		mout << "Performing CD Nozzle Simulation :" << ende;
		std::string testfile = "application." + testtype + ".testfile";
		CfgTst->Create(CfgApp->GetString(testfile, true));	
		if (ParticleOnly(pf,tcps,tcpsapp))
		{
			if(doCap == true)
				{
					tcpsapp->WritePort("quit");
					tcpsapp->Close();
				}
			return 1;
		}

		if(doCap == true)
		{
			tcpsapp->WritePort("quit");
			tcpsapp->Close();
		}
		return 0;
	}
}
#if 1
catch (const std::exception& e)
{

	mout << "EXITING| TYPE:" << typeid(e).name() << " MSG:" << e.what() << ende;
	
	exit(1);
}
#endif

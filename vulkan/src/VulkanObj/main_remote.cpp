
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
MsgStream			mout;
ConfigObj*			CfgTst;
ConfigObj*			MpsApp;
ConfigObj*			CfgApp;

int main() try
{
	mout.Init("particle.log", "Particle");
	std::filesystem::path cwd = std::filesystem::current_path();
	std::cout << "Working Directory :" << cwd.string().c_str() << std::endl;
	mout << "Working Directory :" << cwd.string().c_str() << ende;
	
	
	MpsApp = new ConfigObj;
	MpsApp->Create("mps.cfg");
	CfgApp = new ConfigObj;
	CfgApp->Create(MpsApp->GetString("studyFile", true));
	CfgTst = new ConfigObj;

	TCPObj* tcps = new TCPObj;
	tcps->SetServerPort(MpsApp->GetString("ipport",true));
	std::cout << "FPIBG Server Listening on port:" << tcps->GetServerPort() << std::endl;

	PerfObj* pf = new PerfObj();
	pf->Create();

	bool autoFlag = CfgApp->GetBool("application.doAuto", true);
	
	
	tcps->Create();

	
    int ret = 0;
    while (ret == 0)
    {
        tcps->ReadPort();
        if(tcps->GetMessage().compare("quit")==0)
        {
            tcps->Close();
            return 0;
        }

		if(tcps->GetMessage().compare("runseries")==0)
        {
			if (pf->DoStudy())
				return 1;
			return 0;
        }

		if(tcps->GetMessage().compare("runsingle")==0)
        {
			CfgTst->Create(CfgApp->GetString("application.testfile", true));	
			if (ParticleOnly(pf))
				return 1;

			return 0;
        }
        if(tcps->iResult > 0)
            tcps->WritePort();
        tcps->Reset();
        std::cout << "Sleep" << std::endl;
    }

    tcps->Close();

}

#if 1
catch (const std::exception& e)
{

	mout << "EXITING| TYPE:" << typeid(e).name() << " MSG:" << e.what() << ende;
	
	exit(1);
}
#endif

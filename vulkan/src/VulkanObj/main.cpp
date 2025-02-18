
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
ConfigObj*			CfgApp;
ConfigObj*			CfgTst;
ConfigObj*			MpsApp;
ConfigObj*			CfgTemp;

int main() try
{
	
	mout.Init("particle.log", "Particle");
	MpsApp = new ConfigObj;
	MpsApp->Create("mps.cfg");
	CfgTemp = new ConfigObj;
	CfgTemp->Create(MpsApp->GetString("studyFile", true));
	CfgTemp->GetSettings();
	CfgApp = new ConfigObj;
	CfgApp->Create(MpsApp->GetString("studyFile", true));
	CfgApp->GetSettings();
	CfgTst = new ConfigObj;
	CfgTst->GetParticleSettingsV2(CfgApp->m_TestName);

	std::filesystem::path cwd = std::filesystem::current_path();
	mout << "Working Directory :" << cwd.string().c_str() << ende;
	PerfObj* pf = new PerfObj();
	
	if (CfgApp->m_DoAuto == true)
	{
		
		if (pf->DoStudy(CfgApp))
			return 1;
	}
	else
	{
		CfgApp->GetParticleSettingsV2(CfgApp->m_TestName);
		if (ParticleOnly(pf))
			return 1;
	}
	return 0;
}
#if 1
catch (const std::exception& e)
{

	mout << "EXITING| TYPE:" << typeid(e).name() << " MSG:" << e.what() << ende;
	
	exit(1);
}
#endif


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
#include "cppsock.hpp"
#include <iostream>
#include <thread>

#include "VulkanObj/VulkanApp.hpp"
#include "windows.h"
MsgStream			mout;
ConfigObj*			CfgTst;
ConfigObj*			MpsApp;
ConfigObj*			CfgApp;
void init_buf(char *buf, size_t len)
{
    for(size_t i=0; i<len; i++)
    {
        buf[i] = i & 0xFF;
    }
}

void print_error(const char* msg)
{
    printf("error message: %s", msg);
    perror(msg);
    //printf("%s: %s\n", msg, strerror(errno));
    fflush(stderr);
    errno = 0;
}
void abort(const char *a_msg, const char *add_msg = nullptr)
{
    if(a_msg != nullptr) printf("Aborting: %s\n", a_msg);
    if(add_msg != nullptr) printf("Additional message: %s\n", add_msg);
    std::cout << "Aborting..." << std::endl;
    std::cout << "=====================================================" << std::endl;
    std::cout << "cppsock test failed" << std::endl << std::endl;
    exit(EXIT_FAILURE);
}

void check_errno(const char *s_msg, const char *add_msg = nullptr)
{
    if(errno != 0)
    {
        print_error(s_msg);
        if(add_msg != nullptr) printf("Additional message: %s\n", add_msg);
        abort("Errno check failed");
    }
}

int main() try
{
	mout.Init("particle.log", "Particle");
	MpsApp = new ConfigObj;
	MpsApp->Create("mps.cfg");
	CfgApp = new ConfigObj;
	CfgApp->Create(MpsApp->GetString("studyFile", true));
	//CfgApp = new ConfigObj;
	//CfgApp->Create(MpsApp->GetString("studyFile", true));
	CfgTst = new ConfigObj;
	
	PerfObj* pf = new PerfObj();
	pf->Create();
	std::filesystem::path cwd = std::filesystem::current_path();
	mout << "Working Directory :" << cwd.string().c_str() << ende;
	
	
	if (CfgApp->GetBool("application.doAuto", true) == true)
	{
		
		if (pf->DoStudy())
			return 1;
	}
	else
	{
		CfgTst->Create(CfgApp->GetString("application.testfile", true));	
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

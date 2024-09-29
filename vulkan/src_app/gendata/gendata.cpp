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
#include "csv/csv.hpp"

MsgStream			mout;
#include "gendata/GenResourceVertexParticle.hpp"



void GenData(ConfigObj* configObj)
{
	
	configObj->GetSettings();
	VulkanObj* vulkanObj = new VulkanObj;
	GenResourceVertexParticle* resourceVertexParticle
		= new GenResourceVertexParticle;

	resourceVertexParticle->m_App = vulkanObj;
	vulkanObj->m_CFG = configObj;
	resourceVertexParticle->Create(0);
	
	configObj->m_TestName = configObj->m_PQBTestName;
	std::cout << "Processing PQB Benchfile:" << configObj->m_TestName << std::endl;
	configObj->m_TestDir = configObj->m_PQBTestDir;
	resourceVertexParticle->GenBenchSet();
	resourceVertexParticle->ProcessPQB();
	
	configObj->m_TestName = configObj->m_PCDTestName;
	configObj->m_TestDir = configObj->m_PCDTestDir;
	std::cout << "Processing PCD Benchfile:" << configObj->m_TestName << std::endl;
	resourceVertexParticle->GenBenchSet();
	resourceVertexParticle->ProcessPCD();

	configObj->m_TestName = configObj->m_CFBTestName;
	configObj->m_TestDir = configObj->m_CFBTestDir;
	std::cout << "Processing CFB Benchfile:" << configObj->m_TestName << std::endl;
	resourceVertexParticle->ProcessCFB();

	
	
}
int main() try
{
	std::string filename = "GenDataSets.log";
	std::string modname = "GenDataSets";
	mout.Init(filename.c_str(), modname.c_str());
	ConfigObj* configVCUBE = new ConfigObj;
	std::filesystem::path cwd = std::filesystem::current_path();
	mout << "Working Directory :" << cwd.string().c_str() << ende;
	configVCUBE->Create("GenDataSets.cfg");
	GenData(configVCUBE);
	
	
}

catch (const std::exception& e)
{

	mout << "EXITING| TYPE:" << typeid(e).name() << " MSG:" << e.what() << ende;

	exit(1);
}
/*
int VulkanObj::createSemaphores()
{
	VkSemaphoreCreateInfo semaphoreInfo = {};
	semaphoreInfo.sType = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;
	semaphoreInfo.pNext = nullptr;
	semaphoreInfo.flags = 0;

	vk_res = vkCreateSemaphore(GetLogicalDevice(), &semaphoreInfo, nullptr,
		&s_imageAvailableSemaphore);
	ASSERT_VK(vk_res);

	vk_res = vkCreateSemaphore(GetLogicalDevice(), &semaphoreInfo, nullptr,
		&s_renderFinishedSemaphore);
	ASSERT_VK(vk_res);

	return EXIT_SUCCESS;
}*/

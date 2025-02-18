/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-06-12 16:17:58 -0400 (Mon, 12 Jun 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src/vulkan/VulkanObject.cpp $
% $Id: VulkanObject.cpp 31 2023-06-12 20:17:58Z jb $
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

// This is done once in a cpp file cause it generates functions and data.
#define STB_IMAGE_IMPLEMENTATION
#define VMA_IMPLEMENTATION
#include "VulkanObj/VulkanApp.hpp"

void VulkanObj::Create(ConfigObj* CFG)
{
	m_CFG = CFG;
	m_FramesBuffered = CfgTemp->GetUInt("application.framesBuffered", true);
	m_EnableValidationLayers = CfgTemp->GetBool("application.enableValidationLayers", true);
	m_InstanceExtensions = CfgTemp->GetArray("application.instance_extensions");
	m_ValidationLayers = CfgTemp->GetArray("application.validation_layers");
	m_DeviceExtensions = CfgTemp->GetArray("application.device_extensions");
	m_SaveDevLimits = CfgTemp->GetBool("application.printDevLimtits", true);
	m_AppName = CfgTemp->GetString("name", true);
}
//
//
//
//
void VulkanObj::CleanAll()
{
	BaseObj* baseObj;
	while (!m_CleanupList.empty())
	{

		baseObj = m_CleanupList.top();
		baseObj->Cleanup();
		m_CleanupList.pop();
	}
	//Cleanup();
}

void VulkanObj::Cleanup() 
{
#if 0
	if (!m_vmaAllocator->)
	{

		std::ostringstream  objtxt;
		objtxt << "Error in:" << "VulkanObj::Cleanup:vmaMemoryPolls Not empty -> memory leak" <<
			 std::ends;
		throw std::runtime_error(objtxt.str());
	}
#endif
	vmaDestroyAllocator(m_vmaAllocator);
	
	
	if (m_EnableValidationLayers)
	{
		DestroyReportUtilsMessengerEXT();
		DestroyDebugUtilsMessengerEXT(m_Instance, m_DebugMessenger, nullptr);
	}
	vkDestroyDevice(m_LogicalDevice, nullptr);
	vkDestroySurfaceKHR(m_Instance, m_Surface, nullptr);
	vkDestroyInstance(m_Instance, nullptr);
	glfwDestroyWindow(m_Window);
	glfwTerminate();
}

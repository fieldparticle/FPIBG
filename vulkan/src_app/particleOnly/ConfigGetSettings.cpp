#include "libconfig.h"
#include "VulkanObj/VulkanApp.hpp"

void ConfigObj::Create(std::string CfgName)
	{
		
		// Intialize libconfig
		config_init(&m_cfg);
		ReadConfigFile(CfgName);
		
	}



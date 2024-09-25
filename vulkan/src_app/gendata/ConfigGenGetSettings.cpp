#include "libconfig.h"
#include "VulkanObj/VulkanApp.hpp"
void ConfigObj::GetSettings()
{
	// Boundary kernels

	m_AppName = GetString("name", true);
	m_Version = GetString("version", true);

	//m_TestType = GetUInt("application.testType", true);
	m_TestName = GetString("application.testfile", true);
	m_TestDir = GetString("application.testdir", true);
	m_dt		= GetFloat("application.dt", true);
	

	//GetParticleSettings();

}
void ConfigObj::GetParticleSettings()
{
	m_startSideLength = GetUInt("application.startSideLength", true);
	m_TempHigh = GetFloat("application.tempHigh", true);
	m_TempLow  = GetFloat("application.tempLow", true);
	m_Substance = GetString("application.substance", true);
	m_PDensity = GetFloat("application.pDensity", true);
	m_CDensity = GetFloat("application.cDensity", true);
	m_PopPerCell = GetInt("application.popPerCell", true);
	m_Radius = GetFloat("application.startRadius", true);
	m_MaxPopPerCell = GetInt("application.maxPopPerCell", true);
	m_TestType = GetInt("application.testType", true);

#if 0
	m_AprFile = GetString("aprFile", true);
	m_DataFile = GetString("dataFile", true);
	m_wkx = GetInt("workGroupsx", true);
	m_wky = GetInt("workGroupsy", true);
	m_wkz = GetInt("workGroupsz", true);
	m_dkx = GetInt("dispatchx", true);
	m_dky = GetInt("dispatchy", true);
	m_dkz = GetInt("dispatchz", true);
	m_colcount = GetInt("colcount", true);
	m_density = GetFloat("density", true);
	m_partcount = GetInt("pcount", true);
	m_MaxCollArray = GetInt("ColArySize", true);
#endif
};


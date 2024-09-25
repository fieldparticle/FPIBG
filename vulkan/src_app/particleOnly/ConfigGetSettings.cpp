#include "libconfig.h"
#include "VulkanObj/VulkanApp.hpp"
void ConfigObj::GetSettings()
{
	//char  buf1[1024], buf2[1024]; 
	//const char* variable = TEXT("RCCDDRIVE");
	//DWORD rc = GetEnvironmentVariableA(variable, buf1, sizeof(buf1));
	//DWORD errrc = GetLastError() ;
	const char* rccdrv = getenv("RCCDDRIVE");
	if(rccdrv == nullptr)
	{
		std::string err = "RCCDRV not set or not found.";
		throw std::runtime_error(err.c_str());

	}
	m_rccdrv = rccdrv;

	const char* rccdver = std::getenv("RCCDVER\0");
	if(rccdver == nullptr)
	{
		std::string err = "RCCDIR not set or not found.";
		throw std::runtime_error(err.c_str());

	}

	m_rccdver = rccdver;
	

	m_StudyName = GetString("studyFile", true);
	config_init(&m_cfg);
	ReadConfigFile(m_StudyName);

	m_AppName = GetString("name", true);
	m_InstanceExtensions = GetArray("application.instance_extensions");
	m_EnableValidationLayers = GetBool("application.enableValidationLayers", true);
	m_ValidationLayers = GetArray("application.validation_layers");
	m_SaveExtensions = GetBool("application.printExtension", true);
	m_SaveDevLimits = GetBool("application.printDevLimtits", true);
	m_DeviceExtensions = GetArray("application.device_extensions");
	m_InstanceExtensions = GetArray("application.instance_extensions");
	m_RequestedWidth = GetInt("application.window.size.w", true);
	m_RequestedHeight = GetInt("application.window.size.h", true);
	m_PhysDevice = GetString("application.phys_device", true);
	m_Boundary = GetString("application.boundary01", true);
	m_SphereFile = GetString("application.sphere", true);
	m_WireFlag = GetBool("application.wireframeS", true);
	m_dt = GetFloat("application.dt", true);
	// Boundary kernels
	//m_fragShaderSphere = GetString("application.frag_kernSphere", true);
	//m_vertShaderSphere = GetString("application.vert_kernSphere", true);

	m_fragShaderBoundary = GetString("application.frag_kernBoundary", true);
	m_vertShaderBoundary = GetString("application.vert_kernBoundary", true);
	m_fragSPVBoundary = GetString("application.frag_kernBoundaryspv", true);
	m_vertSPVBoundary = GetString("application.vert_kernBoundaryspv", true);
	m_glslc_path =  GetString("application.glslc_path", true); 

	m_fragShaderParticle = GetString("application.frag_kernParticle", true);
	m_vertShaderParticle = GetString("application.vert_kernParticle", true);
	m_compShaderParticle = GetString("application.comp_kernParticle", true);
	m_fragSPVParticle = GetString("application.frag_kernParticlespv", true);
	m_vertSPVParticle = GetString("application.vert_kernParticlespv", true);
	m_compSPVParticle = GetString("application.comp_kernParticlespv", true);
	m_View = GetUInt("application.view", true);
	m_FramesBuffered = GetUInt("application.framesBuffered", true);
	m_AppName = GetString("name", true);
	m_Version = GetString("version", true);
	m_CapFlName = GetString("application.cap_name", true);
	m_FrameDelay = GetInt("application.frame_delay", true);
	m_CapFrmNum = GetInt("application.cap_num", true);
	m_CapFrms = GetInt("application.cap_frames", true);
	m_EndFrame = GetUInt("application.end_frame", true);
	m_BoundaryFlag = GetBool("application.boundaryOnly", true);
	m_DebugVerbose = GetBool("application.verbose_rpt", true);
	m_Width = GetInt("application.window.size.w", true);
	m_Height = GetInt("application.window.size.h", true);
	m_BoundarySideLength = GetInt("application.boundarySideLength", true);
	m_Stopondata = GetBool("application.stopondata", true);
	m_DoAuto = GetBool("application.doAuto", true);
	m_AutoTimeOut = GetUInt("application.doAutoWait", true);
	m_StudyType = GetUInt("application.study_type", true);
	//m_TestNumber = GetInt("application.testNum", true)-1;
	m_Compiler = GetString("application.compiler", true);
	m_TestName = m_rccdrv+"/" + GetString("application.testfile", true);
	m_TestDir = m_rccdrv+"/" + GetString("application.testdir", true);
	m_NSight = GetBool("application.nsight", true);
	m_NoCompute = GetBool("application.noCompute", true);
	m_DoMotion = GetUInt("application.doMotion", true);
	m_FramesBuffered = GetUInt("application.framesInFlight", true);
	m_CompileShaders = GetBool("application.compileShaders", true);
	m_reportCompFramesLessThan = GetInt("application.reportCompFramesLessThan", true);
	m_reportGraphFramesLessThan = GetInt("application.reportGraphFramesLessThan", true);
	if (m_NSight == true)
	{
		m_CompileShaders = false;
		m_AutoTimeOut = 0;
		m_DoAuto = false;
		m_Stopondata = false;
		m_EnableValidationLayers = false;

	}
#ifdef NDEBUG
	m_CompileShaders = true;
	m_EnableValidationLayers = false;
	
#endif


	

}
void ConfigObj::GetParticleSettings()
{
	config_init(&m_cfg);
	ReadConfigFile(m_TestName);
	// The genrating file uses the whole directoy eith drive.
	m_AprFile =  GetString("aprFile", true);
	m_DataFile = GetString("dataFile", true);
	m_CfgSidelen = GetUInt("Sidelen", true);
	m_PartPerCell = GetUInt("PartPerCell", true);
	m_wky = GetInt("workGroupsy", true);
	m_wkx = GetInt("workGroupsx", true);
	m_wkz = GetInt("workGroupsz", true);
	m_dkx = GetInt("dispatchx", true);
	m_dky = GetInt("dispatchy", true);
	m_dkz = GetInt("dispatchz", true);
	m_colcount = GetInt("colcount", true);
	m_radius = GetFloat("radius", true);
	m_density = GetFloat("density", true);
	m_partcount = GetInt("pcount", true);
	m_MaxCollArray = GetInt("ColArySize", true);
	m_MaxSingleCollisions = GetInt("MaxSingleCollisions", false);
};

void ConfigObj::GetParticleSettingsV2()
{
	config_init(&m_cfg);
	ReadConfigFile(m_TestName);
	m_AprFile =  GetString("aprFile", true);
	m_DataFile = GetString("dataFile", true);
	if (m_TstFileMinorVersion == 3)
	{
		m_CfgSidelen = GetUInt("CellAryW", true);
	}

	if (m_TstFileMinorVersion == 2 || m_TstFileMinorVersion == 1)
	{
		m_PipeCenter = GetFloat("PipeCenter", true);
		m_PipeRadius = GetFloat("PipeRadius", true);
	}	
	m_CellAryW = GetUInt("CellAryW", true);
	m_CellAryH = GetUInt("CellAryH", true);
	m_CellAryL = GetUInt("CellAryL", true);
	m_PartPerCell = GetUInt("PartPerCell", true);
	m_wky = GetInt("workGroupsy", true);
	m_wkx = GetInt("workGroupsx", true);
	m_wkz = GetInt("workGroupsz", true);
	m_dkx = GetInt("dispatchx", true);
	m_dky = GetInt("dispatchy", true);
	m_dkz = GetInt("dispatchz", true);
	m_colcount = GetInt("colcount", true);
	m_radius = GetFloat("radius", true);
	m_density = GetFloat("density", true);
	m_partcount = GetInt("pcount", true);
	m_MaxCollArray = GetInt("ColArySize", true);
	m_MaxSingleCollisions = GetInt("MaxSingleCollisions", false);
};


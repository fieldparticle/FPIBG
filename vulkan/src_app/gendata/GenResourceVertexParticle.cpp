/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-05-03 15:30:42 -0400 (Wed, 03 May 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src/vulkan/ResourceVertex.cpp $
% $Id: ResourceVertex.cpp 28 2023-05-03 19:30:42Z jb $
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
%*$Revision: 28 $
%*
%*
%******************************************************************/
#define VMA_IMPLEMENTATION
#include "VulkanObj/VulkanApp.hpp"

#include "gendata/GenResourceVertexParticle.hpp"

void GenResourceVertexParticle::DoMotionStudy()
{
#if 0
	bool wflg=true;
	ConfigObj* cfg = (ConfigObj*)m_App->m_CFG;
	uint32_t num = 1;
	std::string direction = {};
	std::string dirval = m_App->m_CFG->m_TestDir;

	//Boundary only
	if (cfg->m_TestName.find("BX") != std::string::npos)
		direction = "BX";
	if (cfg->m_TestName.find("BY") != std::string::npos)
		direction = "BY";
	if (cfg->m_TestName.find("BZ") != std::string::npos)
		direction = "BZ";
	// X direction
	if (cfg->m_TestName.find("PX") != std::string::npos)
		direction = "PX";
	// Y direction
	if (cfg->m_TestName.find("PY") != std::string::npos)
		direction = "PY";
	// Z direction
	if (cfg->m_TestName.find("PZ") != std::string::npos)
		direction = "PZ";
	// 3D direction
	if (cfg->m_TestName.find("XYZ") != std::string::npos)
		direction = "XYZ";

	sprintf(FileText, "%sCollisionDataSet\0", direction.c_str());
	m_fileName = FileText;
	m_FullBinFile = dirval + "/" + m_fileName + ".bin";
	m_SideLength = CalcSideLength();
	pdata part;
	m_DataFile.open(m_FullBinFile, std::ios::binary);
	if (!m_DataFile.is_open())
	{
		std::string err = "Cannot open benchmarking data file::" + m_FullBinFile;
		throw std::runtime_error(err.c_str());
	}
	for (uint32_t ii = 0; ii < m_BenchSet.size(); ii++)
	{
		part.rx = m_BenchSet[ii].px;
		part.ry = m_BenchSet[ii].py;
		part.rz = m_BenchSet[ii].pz;
		part.vx = m_BenchSet[ii].vx;
		part.vy = m_BenchSet[ii].vy;
		part.vz = m_BenchSet[ii].vz;
		part.radius = m_BenchSet[ii].radius;
		m_Radius = m_BenchSet[ii].radius;
		part.pnum = ii;
		wflg = !wflg;
		WriteParticle(part,wflg);
	}
	SaveParticles();
	CloseParticleData();

	WriteTstFile(0, &m_BenchSet[0]);
#endif
}
void GenResourceVertexParticle::ProcessSet()
{
	
	//m_BenchSet.size()
	for (uint32_t ii = 0; ii < m_BenchSet.size(); ii++)
	{
		OpenParticleDataA002(ii, &m_BenchSet[ii]);
		ProcessTestA002(&m_BenchSet[ii]);
		mout << "For File:" << FileText << " Done!" << ende;
		mout << "Counted Particles:" << m_CountedParticles << ende;
		mout << "Counted Collisions:" << m_CountedCollisions << ende;
		mout << "Counted Sidelength:" << m_CountedSidelength << ende;
		CloseParticleData();
		WriteTstFile(ii, &m_BenchSet[ii]);
	}

}
void GenResourceVertexParticle::CloseParticleData()
{
	if (m_DataFile.is_open())
	{
		m_DataFile.flush();
		m_DataFile.close();
	}
}
void GenResourceVertexParticle::WriteTstFile(uint32_t index, benchSetItem* bsi)
{
	std::string dirval	= m_App->m_CFG->m_TestDir;
	std::string fulFile = dirval + "/" + m_fileName + ".tst";
	std::string txtFile = "\"" + dirval + "/" + m_fileName + "\"";
	std::string binFile = "\"" + m_FullBinFile + "\"";
	ConfigObj* cfg		= (ConfigObj*)m_App->m_CFG;
	
	std::ofstream ostrm(fulFile);
	if (!ostrm.is_open())
	{
		std::string err = "Cannot open benchmarking test file::" + fulFile;
		throw std::runtime_error(err.c_str());
	}

	std::cout << "Processing File:" << fulFile.c_str() << std::endl;
	char densit[6] = { 0 };
	sprintf(densit,"%0.2f\0", m_Cdensity);
	ostrm << "index = " << index << ";" << std::endl;
	ostrm << "CellAryW = " << m_SideLength << ";" << std::endl;
	ostrm << "CellAryH = " << m_SideLength << ";" << std::endl;
	ostrm << "CellAryL = " << m_SideLength << ";" << std::endl;
	ostrm << "radius = " << m_Radius << ";" << std::endl;
	ostrm << "PartPerCell = " << m_PInCell << ";" << std::endl;
	ostrm << "pcount = " << m_CountedParticles + m_CountedBoundaryParticles<< ";" << std::endl;
	ostrm << "colcount =" << m_CountedCollisions << ";" << std::endl;
	ostrm << "dataFile = " << binFile << ";" << std::endl;
	ostrm <<"aprFile = " << txtFile << ";" << std::endl;
	ostrm <<"density = " << densit  << ";" << std::endl;
	ostrm <<"pdensity = " << m_Pdensity << ";" << std::endl;
	ostrm <<"dispatchx = " << bsi->dx + m_CountedBoundaryParticles << ";" << std::endl;
	ostrm <<"dispatchy = " << bsi->dy << ";" << std::endl;
	ostrm <<"dispatchz = " << bsi->dz << ";" << std::endl;
	ostrm <<"workGroupsx =" << bsi->wx << "; " << std::endl;
	ostrm <<"workGroupsy =" << bsi->wy << "; " << std::endl;
	ostrm <<"workGroupsz =" << bsi->wz << "; " << std::endl;
	ostrm <<"ColArySize =" << m_PInCell+10 << "; " << std::endl;
	ostrm.flush();
	ostrm.close();


	if (m_CountedCollisions != m_TotCollsions)
	{
		std::ostringstream  objtxt;
		objtxt << "Counted Collsions:" << m_CountedCollisions << " Expected:" << m_TotCollsions << std::ends;
		throw std::runtime_error(objtxt.str().c_str());

	}
}
uint32_t GenResourceVertexParticle::CalcSideLength()
{
	uint32_t ii = 0;
	while (1)
	{
		ii++;
		if (ii > 1000)
			return 0;
		if (ii * ii * ii * m_PInCell >= m_NumParticles)
		{
			return ii+1;
		}
	}
}





void GenResourceVertexParticle::OpenParticleDataA003()
{
	m_SideLengths.clear();	
	ConfigObj* cfg = (ConfigObj*)m_App->m_CFG;
	m_Cdensity = cfg->m_CDensity;
	m_Radius = cfg->m_Radius;
	float sepdist = 0.15f;
	m_Centerlen = cfg->m_Radius * sepdist + 2 * cfg->m_Radius;
	m_PinRow = static_cast<uint32_t>(floor(1.00 / m_Centerlen));
	m_PInCell = (uint32_t)pow(m_PinRow, 3);
	m_SideLength = cfg->m_startSideLength;
	m_NumParticles = m_SideLength * m_SideLength * m_SideLength * m_PInCell;
	m_CInCell = std::ceil(static_cast<float>(m_PInCell) * m_Cdensity / 2.0f);
	m_SideLength = CalcSideLength();
	m_SideLengths.push_back(m_SideLength);
	benchSetItem bsi;
	bsi.wx = 1;
	bsi.wy = 8;
	bsi.wz = 1;
	bsi.dx = m_NumParticles + 1;
	bsi.dy = 1;
	bsi.dz = 1;
	bsi.vx = 0.0;
	bsi.vy = 0.0;
	bsi.vz = 0.0;
	bsi.px = 0.0;
	bsi.py = 0.0;
	bsi.pz = 0.0;
	bsi.tot = m_NumParticles;
	bsi.sel = "s";
	bsi.cols = m_PInCell;
	bsi.collision = 0;
	bsi.cdens = 0.5;
	bsi.radius = m_Radius;
	m_BenchSet.push_back(bsi);
	while((m_SideLength=GetNextSideLength())!=0)
	{

		benchSetItem bsi;
		bsi.wx = 1;
		bsi.wy = 8;
		bsi.wz = 1;
		bsi.dx = m_NumParticles+1;
		bsi.dy = 1;
		bsi.dz = 1;
		bsi.vx = 0.0;
		bsi.vy = 0.0;
		bsi.vz = 0.0;
		bsi.px = 0.0;
		bsi.py = 0.0;
		bsi.pz = 0.0;
		bsi.tot = m_NumParticles;
		bsi.sel = "s";
		bsi.cols = m_PInCell;
		bsi.collision = 0;
		bsi.cdens = 0.5;
		bsi.radius = m_Radius;
		m_BenchSet.push_back(bsi);
		
	}

	ProcessSet();

}

uint32_t GenResourceVertexParticle::GetNextSideLength()
{
	float radius = m_Radius;
	uint32_t sideLen = m_SideLength;
	float sepdist = 0.15f;
	for (uint32_t ii = 0; ii < 100; ii++)
	{
		radius = radius - 0.01;
		
		m_Centerlen = radius * sepdist + 2 * radius;
		m_PinRow = static_cast<uint32_t>(floor(1.00 / m_Centerlen));
		m_PInCell = (uint32_t)pow(m_PinRow, 3);
		sideLen = CalcSideLength();
		if (sideLen != m_SideLength)
		{
			m_SideLength = sideLen;
			m_Radius = radius;
			return m_SideLength;

		}

	}

	return 0;

}

void GenResourceVertexParticle::SaveParticles()
{
	for(uint32_t ii = 0;ii<m_NumParticles;ii++)
	{
		pdata pd = m_PartHold[ii];
		m_DataFile.write((char*)&pd, sizeof(pdata));
		if (m_DataFile.bad())
		{
			std::string err = "Particle bin File write Error::";
			throw std::runtime_error(err.c_str());
		}
	}
	m_DataFile.flush();
	m_PartHold.clear();
	m_PartHold.shrink_to_fit();
	m_Front = 0;
	m_Back = 0 ;


}
void GenResourceVertexParticle::WriteParticle(pdata pd,bool m_PlcFlg)
{
	if (pd.rx+ m_Radius > m_CountedSidelength)
		m_CountedSidelength = static_cast<uint32_t>(pd.rx);
	if (pd.ry + m_Radius > m_CountedSidelength)
		m_CountedSidelength = static_cast<uint32_t>(pd.ry);
	if (pd.rz + m_Radius > m_CountedSidelength)
		m_CountedSidelength = static_cast<uint32_t>(pd.rz);
	
	int lb = 4999, ub = 5200;
	float velx = (rand() % (ub - lb + 1) + lb) / 1000000.00f;
	float vely = (rand() % (ub - lb + 1) + lb) / 1000000.00f;
	float velz = (rand() % (ub - lb + 1) + lb) / 1000000.00f;
	pd.vx = velx;
	pd.vy = vely;
	pd.vz = velz;
	if (m_NumParticles % 2 == 0)
	{
		pd.vx = -pd.vx;
		pd.vz = -pd.vz;
	}
	if (m_NumParticles % 3 == 0)
	{
		pd.vx = -pd.vx;
		pd.vy = -pd.vy; 
	}
	if (m_NumParticles % 5 == 0)
	{
		pd.vy = -pd.vy;
		pd.vz = -pd.vz;
	}
	if (m_NumParticles % 7 == 0)
	{
		pd.vx = -pd.vx;
		pd.vz = -pd.vz;
	}
	if (m_NumParticles % 9 == 0)
	{
		pd.vy = -pd.vy;
		pd.vz = -pd.vz;
	}
	if (m_NumParticles % 11 == 0)
	{
		pd.vx = -pd.vx;
		pd.vy = -pd.vy;
		pd.vz = -pd.vz;
	}
	if(m_PlcFlg == true)
	{
			
		m_PartHold[m_Back] = pd;
		m_Back--;
	}
	else
	{
		if(m_Front > m_NumParticles)
		{
			std::string err = "m_Front exceeds number particles.";
			throw std::runtime_error(err.c_str());
		}
		m_PartHold[m_Front] = pd;
		m_Front++;	
	}
	
	
}

void GenResourceVertexParticle::Create(uint32_t BindPoint)
{


	
	m_Particles={};
	m_SideLength = 0;
	ConfigObj* cfg = (ConfigObj*)m_App->m_CFG;
	cfg->GetParticleSettings();
	m_Pdensity = cfg->m_PDensity;
	m_PInCell = static_cast<uint32_t>(std::floor(uint32_t(cfg->m_MaxPopPerCell * cfg->m_PDensity)));
	//m_TotCell = std::ceil(uint32_t(cfg->m_MaxPopPerCell * cfg->m_PDensity));
	
};


#include "csv/csv.hpp"
int GenResourceVertexParticle::GenBenchSet()
{
	int ret = 0;
	io::CSVReader<18> in(m_App->m_CFG->m_TestName);
	in.read_header(io::ignore_extra_column, "wx", "wy", "wz", "dx", "dy", "dz", "tot", "sel", "cols","collision","cdens","radius","vx","vy","vz","px","py","pz");
	std::string sel;
	int wx, wy, wz, dx, dy, dz, tot, cols, collision;
	float cdens,radius,vx,vy,vz,px,py,pz;

	while (in.read_row(wx, wy, wz, dx, dy, dz, tot, sel, cols, collision, cdens,radius,vx,vy,vz,px,py,pz))
		// do stuff with the data
	{
		benchSetItem bsi;
		bsi.wx = wx;
		bsi.wy = wy;
		bsi.wz = wz;
		bsi.dx = dx;
		bsi.dy = dy;
		bsi.dz = dz;
		bsi.vx = vx;
		bsi.vy = vy;
		bsi.vz = vz;
		bsi.px = px;
		bsi.py = py;
		bsi.pz = pz;
		bsi.tot = tot;
		bsi.sel = sel;
		bsi.cols = cols;
		bsi.collision = collision;
		bsi.cdens = cdens;
		bsi.radius = radius;

		if (sel.compare("s") == 0)
		{
			m_BenchSet.push_back(bsi);
#if 0
			std::cout << xx << " "
				<< yy << " "
				<< zz << " "
				<< dx << " "
				<< dy << " "
				<< dz << " "
				<< tot << " "
				<< sel << " "
				<< cols << " "
				<< radius << std::endl;
#endif
		}
		if (sel.compare("c") == 0)
		{
			ret = 1;
			m_NumParticles++;
			m_BenchSet.push_back(bsi);

		}


	}
	return ret;
}

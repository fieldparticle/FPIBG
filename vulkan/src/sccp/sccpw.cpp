#include <stdio.h>
#include <string>
#include <ws2tcpip.h>
#include <windows.h>
#include <wininet.h>
#include <winuser.h>
#include <conio.h>
#include <time.h>
#include <fstream>
#include <strsafe.h>
#include <io.h>
#include <crtdefs.h>
#include <fstream>
#include <GdiPlus.h>
#include <lmcons.h>
#include <vector>
#include "tcpip/TCPSObj.hpp"
#include "mout2_0/mout.hpp"
#include "VulkanObj/ConfigObj.hpp"
#include <iostream>
#include <thread>
#include <filesystem>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include "tcpip/TCPCObj.hpp"
void CreateBMPFile(HWND hwnd, std::string pszFile, PBITMAPINFO pbi, 
                  HBITMAP hBMP, HDC hDC) ;
TCPCObj* tcpc;
namespace fs = std::filesystem;
MsgStream			mout;
ConfigObj*			CfgTst;
ConfigObj*			MpsApp;
ConfigObj*			CfgApp;
uint32_t			width;
uint32_t			height;
uint32_t			xpos;
uint32_t			ypos;
BYTE*				lpPixels;
BITMAPINFO			MyBMInfo = {0};
std::ostringstream TcpFileName;
std::string imageDir;
std::string imagePrefix;
HDC globalhDC = NULL;
std::vector< DISPLAY_DEVICE> dispVec;
using namespace Gdiplus;
using namespace std;

fstream err("errormul.txt",ios::app);
fstream log_error_file("log_error.txt",ios::app);

#pragma comment(lib, "user32.lib") 
#pragma comment(lib,"Wininet.lib")
#pragma comment (lib,"gdiplus.lib")
#pragma comment (lib,"Shlwapi.lib")
void screenshot(string file)
{
	ULONG_PTR gdiplustoken;
	RECT rc0kno;  // rectangle  Object
	GdiplusStartupInput gdistartupinput;
	GdiplusStartupOutput gdistartupoutput;

	gdistartupinput.SuppressBackgroundThread = true;
	GdiplusStartup(& gdiplustoken,& gdistartupinput,& gdistartupoutput); //start GDI+
	
	HDC dc	= GetDC(GetDesktopWindow());//get desktop content
	HDC dc2 = CreateCompatibleDC(dc);	 //copy context
	

	GetClientRect(GetDesktopWindow(),&rc0kno);// get desktop size;
	
	HBITMAP hbitmap = CreateCompatibleBitmap(dc,width,height);  //create bitmap
	HBITMAP holdbitmap = (HBITMAP) SelectObject(dc2,hbitmap);

	BitBlt(dc2, xpos, ypos, width, height, dc, 0, 0, SRCCOPY);  //copy pixel from pulpit to bitmap
	Bitmap* bm= new Bitmap(hbitmap,NULL);
	
	
    MyBMInfo.bmiHeader.biSize = sizeof(MyBMInfo.bmiHeader); 
	if(0 == GetDIBits(dc2, hbitmap, 0, 0, NULL, &MyBMInfo, DIB_RGB_COLORS)) 
	{
        cout << "error" << endl;
    }


	lpPixels = new BYTE[MyBMInfo.bmiHeader.biSizeImage];
	MyBMInfo.bmiHeader.biCompression = BI_RGB;  
	// get the actual bitmap buffer
    if(0 == GetDIBits(dc2, hbitmap, 0, MyBMInfo.bmiHeader.biHeight, (LPVOID)lpPixels, &MyBMInfo, DIB_RGB_COLORS)) 
	{
        cout << "error2" << endl;
    }
    std::ostringstream  fileName;
	wstring path_wstr( file.begin(), file.end() );
	CreateBMPFile(GetDesktopWindow(), file, &MyBMInfo, hbitmap, dc2) ;
	UINT num;
	UINT size;

	ImageCodecInfo *imagecodecinfo;
	GetImageEncodersSize(&num,&size); //get count of codec

	imagecodecinfo = (ImageCodecInfo*)(malloc(size));
	GetImageEncoders (num,size,imagecodecinfo);//get codec

	CLSID clsidEncoder;

	for(UINT i=0; i < num; i++)
	{
		if(wcscmp(imagecodecinfo[i].MimeType,L"image/jpeg")==0)
			clsidEncoder = imagecodecinfo[i].Clsid;   //get jpeg codec id

	}

	free(imagecodecinfo);

	wstring ws;
	//ws.assign(file.begin(),file.end());  //sring to wstring
	//bm->Save(ws.c_str(),& clsidEncoder);   //save in jpeg format
	SelectObject(dc2,holdbitmap);  //Release Objects
	DeleteObject(dc2);
	DeleteObject(hbitmap);

	ReleaseDC(GetDesktopWindow(),dc);
	//ReleaseDC(WindowFromDC(dc),dc);
	GdiplusShutdown(gdiplustoken);

}
int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int CmdShow)
{	
	BOOL bRet = FALSE;
	DWORD dwNum =0;
	DWORD device = 0;
	std::string imageDir;
	std::string imagePrefix;
	

	try {
		std::cout << "Starting" << std::endl;
		mout.Init("CaptureApp.log", "CaptureApp");
		std::filesystem::path cwd = std::filesystem::current_path();
		std::cout << "Working Directory :" << cwd.string().c_str() << std::endl;
		mout << "Working Directory :" << cwd.string().c_str() << ende;
	
		mout << "Create mps" << ende;
		MpsApp = new ConfigObj;
		MpsApp->Create("mps.cfg");
		mout << "Open mps" << ende;
		CfgApp = new ConfigObj;
		CfgApp->Create(MpsApp->GetString("studyFile", true));
		mout << "StudyFile:" << MpsApp->GetString("studyFile", true) << ende;
		imageDir = CfgApp->GetString("application.imageDir", true);
		imagePrefix = CfgApp->GetString("application.imagePrefix", true);
		mout << "imageDir:" << imageDir << " imagePrefix:" << imagePrefix << ende;
		width = CfgApp->GetInt("application.window.size.w", true);
		height = CfgApp->GetInt("application.window.size.h", true);
		xpos = CfgApp->GetInt("application.window.size.x", true);
		ypos = CfgApp->GetInt("application.window.size.y", true);
		tcpc = new TCPCObj;
		tcpc->SetServerIP(CfgApp->GetString("application.image_server_ip",true));
		tcpc->SetServerPort(CfgApp->GetString("application.image_server_port",true));
		tcpc->Create();
	}
	catch(const exception err)
	{
		mout << "Error :" << err.what() << ende;
		return 1;

	}
	do 
	{
		DISPLAY_DEVICE disp;
		disp.cb = sizeof( DISPLAY_DEVICE );
		bRet = EnumDisplayDevices(NULL,dwNum,&disp,0);
		if( bRet)
			dispVec.push_back(disp);
		dwNum++;
	} while(bRet);
	
	TCPObj* tcps = new TCPObj;
	tcps->SetServerPort(MpsApp->GetString("server_port",true));
	std::cout << "FPIBG Server Listening on port:" << tcps->GetServerPort() << std::endl;
	tcps->SetBufSize(MpsApp->GetInt("buffer_size",true));


	uint32_t imgNum = 0;
	std::ostringstream  delName;
	std::vector<std::string> filename;
	std::string path = imageDir ;
	for (auto& entry : fs::directory_iterator(path))
	{
		filename.push_back(entry.path().string());
	}
	for(size_t ii = 0; ii< filename.size();ii++)
	{
		if(filename[ii].find("jpg") != std::string::npos)
		{
			std::remove(filename[ii].c_str());
			mout << filename[ii] << ende; 
		}
		if(filename[ii].find("raw") != std::string::npos)
		{
			std::remove(filename[ii].c_str());
			mout << filename[ii] << ende; 
		}
	}

  

	while(true)
	{
		imgNum++;
        TcpFileName << imagePrefix <<  std::setfill('0') << std::setw(5) << imgNum << ".bmp";
		std::ostringstream  fileName;
		fileName << imageDir << "/" << imagePrefix <<  std::setfill('0') << std::setw(5) << imgNum << ".bmp";
		screenshot(fileName.str());   // send string to screenshot function
		std::ostringstream  rawFileName;
		rawFileName << imageDir << "/" << imagePrefix <<  std::setfill('0') << std::setw(5) << imgNum << ".raw";
		std::ofstream file(rawFileName.str(), std::ios::out | std::ios::binary);
	
		//Sleep(1000);  // delay execution of function 60 Seconds
        return 0;

	}
}
//Returns the last Win32 error, in string format. Returns an empty string if there is no error.
std::string GetLastErrorAsString()
{
    //Get the error message ID, if any.
    DWORD errorMessageID = ::GetLastError();
    if(errorMessageID == 0) {
        return std::string(); //No error message has been recorded
    }
    
    LPSTR messageBuffer = nullptr;

    //Ask Win32 to give us the string version of that message ID.
    //The parameters we pass in, tell Win32 to create the buffer that holds the message for us (because we don't yet know how long the message string will be).
    size_t size = FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
                                 NULL, errorMessageID, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPSTR)&messageBuffer, 0, NULL);
    
    //Copy the error message into a std::string.
    std::string message(messageBuffer, size);
    
    //Free the Win32's string's buffer.
    LocalFree(messageBuffer);
            
    return message;
}
PBITMAPINFO CreateBitmapInfoStruct(HWND hwnd, HBITMAP hBmp)
{ 
    BITMAP bmp; 
    PBITMAPINFO pbmi; 
    WORD    cClrBits; 

    // Retrieve the bitmap color format, width, and height.  
    if (!GetObject(hBmp, sizeof(BITMAP), (LPSTR)&bmp)) 
        mout << "GetObject failes"; 

    // Convert the color format to a count of bits.  
    cClrBits = (WORD)(bmp.bmPlanes * bmp.bmBitsPixel); 
    if (cClrBits == 1) 
        cClrBits = 1; 
    else if (cClrBits <= 4) 
        cClrBits = 4; 
    else if (cClrBits <= 8) 
        cClrBits = 8; 
    else if (cClrBits <= 16) 
        cClrBits = 16; 
    else if (cClrBits <= 24) 
        cClrBits = 24; 
    else cClrBits = 32; 

    // Allocate memory for the BITMAPINFO structure. (This structure  
    // contains a BITMAPINFOHEADER structure and an array of RGBQUAD  
    // data structures.)  

     if (cClrBits < 24) 
         pbmi = (PBITMAPINFO) LocalAlloc(LPTR, 
                    sizeof(BITMAPINFOHEADER) + 
                    sizeof(RGBQUAD) * (1<< cClrBits)); 

     // There is no RGBQUAD array for these formats: 24-bit-per-pixel or 32-bit-per-pixel 

     else 
         pbmi = (PBITMAPINFO) LocalAlloc(LPTR, 
                    sizeof(BITMAPINFOHEADER)); 

    // Initialize the fields in the BITMAPINFO structure.  

    pbmi->bmiHeader.biSize = sizeof(BITMAPINFOHEADER); 
    pbmi->bmiHeader.biWidth = bmp.bmWidth; 
    pbmi->bmiHeader.biHeight = bmp.bmHeight; 
    pbmi->bmiHeader.biPlanes = bmp.bmPlanes; 
    pbmi->bmiHeader.biBitCount = bmp.bmBitsPixel; 
    if (cClrBits < 24) 
        pbmi->bmiHeader.biClrUsed = (1<<cClrBits); 

    // If the bitmap is not compressed, set the BI_RGB flag.  
    pbmi->bmiHeader.biCompression = BI_RGB; 

    // Compute the number of bytes in the array of color  
    // indices and store the result in biSizeImage.  
    // The width must be DWORD aligned unless the bitmap is RLE 
    // compressed. 
    pbmi->bmiHeader.biSizeImage = ((pbmi->bmiHeader.biWidth * cClrBits +31) & ~31) /8
                                  * pbmi->bmiHeader.biHeight; 
    // Set biClrImportant to 0, indicating that all of the  
    // device colors are important.  
     pbmi->bmiHeader.biClrImportant = 0; 
     return pbmi; 
 } 

void CreateBMPFile(HWND hwnd, std::string FileName , PBITMAPINFO pbi, 
                  HBITMAP hBMP, HDC hDC) 
 { 
     HANDLE hf;                 // file handle  
    BITMAPFILEHEADER hdr;       // bitmap file-header  
    PBITMAPINFOHEADER pbih;     // bitmap info-header  
    LPBYTE lpBits;              // memory pointer  
    DWORD dwTotal;              // total count of bytes  
    DWORD cb;                   // incremental count of bytes  
    BYTE *hp;                   // byte pointer  
    DWORD dwTmp; 
    uint32_t                    fileSize = 0;

    
    


    pbih = (PBITMAPINFOHEADER) pbi; 
    lpBits = (LPBYTE) GlobalAlloc(GMEM_FIXED, pbih->biSizeImage);
    fileSize = pbih->biSizeImage;

    if (!lpBits) 
         mout << "GlobalAlloc" << ende;

    // Retrieve the color table (RGBQUAD array) and the bits  
    // (array of palette indices) from the DIB.  
    if (!GetDIBits(hDC, hBMP, 0, (WORD) pbih->biHeight, lpBits, pbi, 
        DIB_RGB_COLORS)) 
    {
        mout << "GetDIBits" << ende;
    }
    

    // Create the .BMP file.  
 //   hf = CreateFile(path_wstr.c_str(), 
  //                 GENERIC_READ | GENERIC_WRITE, 
 //                  (DWORD) 0, 
 //                   NULL, 
 //                  CREATE_ALWAYS, 
 //                  FILE_ATTRIBUTE_NORMAL, 
 //                  (HANDLE) NULL); 
 //   if (hf == INVALID_HANDLE_VALUE) 
 //         mout << "CreateFile" << ende;


    hdr.bfType = 0x4d42;        // 0x42 = "B" 0x4d = "M"  
    // Compute the size of the entire file.  
    hdr.bfSize = (DWORD) (sizeof(BITMAPFILEHEADER) + 
                 pbih->biSize + pbih->biClrUsed 
                 * sizeof(RGBQUAD) + pbih->biSizeImage); 
    hdr.bfReserved1 = 0; 
    hdr.bfReserved2 = 0; 

    // Compute the offset to the array of color indices.  
    hdr.bfOffBits = (DWORD) sizeof(BITMAPFILEHEADER) + 
                    pbih->biSize + pbih->biClrUsed 
                    * sizeof (RGBQUAD); 

    // Copy the BITMAPFILEHEADER into the .BMP file.  
//    if (!WriteFile(hf, (LPVOID) &hdr, sizeof(BITMAPFILEHEADER), 
//        (LPDWORD) &dwTmp,  NULL)) 
//    {
//       mout << "WriteFile" << ende;
//    }
    fileSize += sizeof(BITMAPFILEHEADER);

    // Copy the BITMAPINFOHEADER and RGBQUAD array into the file.  
//    if (!WriteFile(hf, (LPVOID) pbih, sizeof(BITMAPINFOHEADER) 
 //                 + pbih->biClrUsed * sizeof (RGBQUAD), 
  //                (LPDWORD) &dwTmp, ( NULL)))
  //      mout << "WriteFile" << ende;
//
    fileSize += sizeof(BITMAPINFOHEADER) + pbih->biClrUsed * sizeof (RGBQUAD);

    // Copy the array of color indices into the .BMP file.  
    dwTotal = cb = pbih->biSizeImage; 
    hp = lpBits; 
 //   if (!WriteFile(hf, (LPSTR) hp, (int) cb, (LPDWORD) &dwTmp,NULL)) 
 //          mout << "WriteFile" << ende;

    //fileSize += cb;

    // Close the .BMP file.  
 //    if (!CloseHandle(hf)) 
  //         mout << "CloseHandle" << ende;

    
    std::ofstream outFile(FileName, std::ios::binary);

//    char* bmpmem = new char[fileSize];
    std::ostringstream  header;
    header << TcpFileName.str() << "," 
                                << sizeof(BITMAPFILEHEADER) 
                                << ","
                                << sizeof(BITMAPINFOHEADER)+ pbih->biClrUsed * sizeof (RGBQUAD) 
                                << ","
                                << cb;

    tcpc->WritePort(header.str());
    tcpc->WritePort((char*)&hdr,sizeof(BITMAPFILEHEADER));
    tcpc->WritePort((char*)pbih,sizeof(BITMAPINFOHEADER)+ pbih->biClrUsed * sizeof (RGBQUAD));
    tcpc->WritePort((char*)hp,cb);
   
    outFile.write(reinterpret_cast<char*>(&hdr),sizeof(BITMAPFILEHEADER));
    outFile.write(reinterpret_cast<char*>(pbih),sizeof(BITMAPINFOHEADER)+ pbih->biClrUsed * sizeof (RGBQUAD));
    outFile.write(reinterpret_cast<char*>(hp),cb);
    outFile.close();
    
    // Free memory.  
    GlobalFree((HGLOBAL)lpBits);
}
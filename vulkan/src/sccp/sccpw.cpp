#include <stdio.h>
#include <string>
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


HDC globalhDC = NULL;
std::vector< DISPLAY_DEVICE> dispVec;
using namespace Gdiplus;
using namespace std;

fstream err("errormul.txt",ios::app);
fstream log_error_file("log_error.txt",ios::app);

#pragma comment(lib, "user32.lib") 
#pragma comment(lib,"Wininet.lib")
#pragma comment (lib,"gdiplus.lib")
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
//MONITORENUMPROC Monitorenumproc;
struct monstruct
{
	HMONITOR mon;
	HDC hdc;
	LPRECT rect;
	LPARAM parms;
};
vector<monstruct> monvect;
BOOL Monitorenumproc(
  HMONITOR mon,
  HDC hdc,
  LPRECT rect,
  LPARAM parms
)
{
	monstruct ms;
	ms.mon = mon;
	ms.hdc = hdc;
	ms.parms = parms;
	ms.rect = rect;

	monvect.push_back(ms);
	return TRUE;
}
HDC MonitorFromIndex(int index /* (zero-indexed) */)
{
    DISPLAY_DEVICE dd;
	HDC hDC = NULL;
    dd.cb = sizeof(dd);
    if (EnumDisplayDevices(NULL, index, &dd, EDD_GET_DEVICE_INTERFACE_NAME ) != FALSE)
    {
       // We found a match; make sure that it's part of the desktop.
       if ((dd.StateFlags & DISPLAY_DEVICE_ATTACHED_TO_DESKTOP) == DISPLAY_DEVICE_ATTACHED_TO_DESKTOP)
       {
          // Yup. Now we've got the name of the device:
          //std::cout << dd.DeviceName << std::endl;

          // But how do I obtain an HMONITOR for this device?
          // ...
		    hDC = CreateDC(NULL, dd.DeviceName, NULL, NULL);
			return hDC;  // indicate failure
       }
    }
	hDC = CreateDC( dd.DeviceName, dd.DeviceName, NULL, NULL);
	
	return NULL;  // indicate failure
}

void screenshot(string file){
	ULONG_PTR gdiplustoken;
	RECT rc0kno;  // rectangle  Object
	GdiplusStartupInput gdistartupinput;
	GdiplusStartupOutput gdistartupoutput;

	gdistartupinput.SuppressBackgroundThread = true;
	GdiplusStartup(& gdiplustoken,& gdistartupinput,& gdistartupoutput); //start GDI+

	EnumDisplayMonitors(NULL,NULL,Monitorenumproc,NULL);

	HDC dc	= GetDC(GetDesktopWindow());//get desktop content
	HDC dc2 = CreateCompatibleDC(dc);	 //copy context

	

	GetClientRect(GetDesktopWindow(),&rc0kno);// get desktop size;
	// GetClientRect(WindowFromDC(dc),&rc0kno);
	//int w = rc0kno.right-rc0kno.left;//width
	//int h = rc0kno.bottom-rc0kno.top;//height

	int w = 1000;
	int h = 1000;

	HBITMAP hbitmap = CreateCompatibleBitmap(dc,w,h);  //create bitmap
	HBITMAP holdbitmap = (HBITMAP) SelectObject(dc2,hbitmap);

	BitBlt(dc2, 0, 0, w, h, dc, 0, 0, SRCCOPY);  //copy pixel from pulpit to bitmap
	Bitmap* bm= new Bitmap(hbitmap,NULL);

	UINT num;
	UINT size;

	ImageCodecInfo *imagecodecinfo;
	GetImageEncodersSize(&num,&size); //get count of codec

	imagecodecinfo = (ImageCodecInfo*)(malloc(size));
	GetImageEncoders (num,size,imagecodecinfo);//get codec

	CLSID clsidEncoder;

	for(int i=0; i < num; i++)
	{
		if(wcscmp(imagecodecinfo[i].MimeType,L"image/jpeg")==0)
			clsidEncoder = imagecodecinfo[i].Clsid;   //get jpeg codec id

	}

	free(imagecodecinfo);

	wstring ws;
	ws.assign(file.begin(),file.end());  //sring to wstring
	bm->Save(ws.c_str(),& clsidEncoder);   //save in jpeg format
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
	DISPLAY_DEVICE dd;
	DISPLAY_DEVICE ddMon;
	DWORD device = 0;
	

	do 
	{
		DISPLAY_DEVICE disp;
		disp.cb = sizeof( DISPLAY_DEVICE );
		bRet = EnumDisplayDevices(NULL,dwNum,&disp,0);
		if( bRet)
			dispVec.push_back(disp);
		dwNum++;
	} while(bRet);
	
	
	
	uint32_t imgNum = 0;
	

	while(true)
	{
	SYSTEMTIME st;  // create object of system time 
	GetLocalTime(&st);
	int year = st.wYear;  // extract year from system time
	int month = st.wMonth; // extract month from system time
	int day = st.wDay; // extract year day system time
	int hour = st.wHour; // extract year hours system time
	int mintue = st.wMinute; // extract mintue from system time

	string yearS =  to_string(year);
	yearS += "_";
	string monthS =  to_string(month);
	monthS += "-";
	string dayS =  to_string(day);
	dayS += "-";
	string hourS =  to_string(hour);
	hourS += "H-";
	string mintueS =  to_string(mintue);
	mintueS += "M.jpg";

	string startDate;
	startDate = to_string(imgNum) + dayS + monthS + yearS + hourS + mintueS;  // create complete string of date and time
	imgNum++;
	
	screenshot(startDate);   // send string to screenshot function
	Sleep(1000);  // delay execution of function 60 Seconds
	}
}

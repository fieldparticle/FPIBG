/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-06-12 16:17:58 -0400 (Mon, 12 Jun 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src/vulkan/CommandObj.hpp $
% $Id: CommandObj.hpp 31 2023-06-12 20:17:58Z jb $
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

#pragma once

#undef UNICODE
// Need to link with Ws2_32.lib
#pragma comment (lib, "Ws2_32.lib")
// #pragma comment (lib, "Mswsock.lib")

class TCPObj
{

	public:

	WSADATA wsaData;
    int iResult;

    SOCKET ListenSocket = INVALID_SOCKET;
    SOCKET ClientSocket = INVALID_SOCKET;

    struct addrinfo *result = NULL;
    struct addrinfo hints;

    int iSendResult;
    char* m_Recvbuf;
    int m_Recvbuflen;

    std::string m_SRecvBuf;
    std::string m_PortAddress;

    TCPObj(){};
    int Create();
    int ReadPort();
    int CompareCommand();
    int Close();
    std::vector<std::string> ReadFileByBlocks(const char* filename);
    int Connect();
    int WritePort();
    int WritePort(std::string Message);
    int WritePort(const char* Block);
    void Reset()
    {
        iResult = 0;
        memset(m_Recvbuf,0,m_Recvbuflen);
        iSendResult = 0;
        m_SRecvBuf = "";
    };

	void SetServerPort(std::string PortAddress)
	{
		m_PortAddress = PortAddress;
	};

    std::string GetServerPort()
	{
		return m_PortAddress;
	};
	void SetBufSize(uint32_t BufSize)
	{
        m_Recvbuflen = BufSize;
        m_Recvbuf = new char[m_Recvbuflen];
        memset(m_Recvbuf,0,m_Recvbuflen);


	}
    std::string GetBuffer()
    {
        return m_SRecvBuf;

    }
};
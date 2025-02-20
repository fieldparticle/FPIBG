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

#include <iostream>

#include <winsock2.h>
#include <windows.h>
#include <ws2tcpip.h>
#include <stdlib.h>
#include <stdio.h>

// Need to link with Ws2_32.lib
#pragma comment (lib, "Ws2_32.lib")
// #pragma comment (lib, "Mswsock.lib")

#define DEFAULT_BUFLEN 512
#define DEFAULT_PORT "50004"

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
    char recvbuf[DEFAULT_BUFLEN];
    int recvbuflen = DEFAULT_BUFLEN;
    std::string m_RecvBuf;
    std::string m_PortAddress;

    TCPObj(){};
    int Create();
    int ReadPort();
    int Close();
    int WritePort();
    void Reset()
    {
        iResult = 0;
        memset(recvbuf,0,DEFAULT_BUFLEN);
        iSendResult = 0;
        m_RecvBuf = "";
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



	}
    std::string GetMessage()
    {
        return m_RecvBuf;

    }
};
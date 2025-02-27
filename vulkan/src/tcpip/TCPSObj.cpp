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
#include "VulkanObj/VulkanApp.hpp"

int TCPObj::WritePort()
{
    iSendResult = send( ClientSocket, m_Recvbuf, iResult,0);
    if (iSendResult == SOCKET_ERROR) 
    {
        printf("send failed with error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
    printf("Bytes sent: %d\n", iSendResult);
    return 0;

}
int TCPObj::WritePort(std::string Message)
{
    iSendResult = send( ClientSocket, Message.c_str(), iResult,0);
    if (iSendResult == SOCKET_ERROR) 
    {
        printf("send failed with error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
    printf("Bytes sent: %d\n", iSendResult);
    return 0;

}
int TCPObj::WritePort(const char* Block)
{
    iSendResult = send( ClientSocket, Block, iResult,0);
    if (iSendResult == SOCKET_ERROR) 
    {
        printf("send failed with error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
    printf("Bytes sent: %d\n", iSendResult);
    return 0;

}

int TCPObj::CompareCommand()
{
    if(m_SRecvBuf.compare("quit") == 0)
        return 1;
    else if(m_SRecvBuf.compare("stop") == 0)
        return 2;
    return 0;
}

int TCPObj::ReadPort()
{
    fd_set ReadFDs;
    FD_ZERO(&ReadFDs);
    FD_SET(ClientSocket, &ReadFDs);
    // No longer need server socket
    closesocket(ListenSocket);
    timeval tm;
    tm.tv_sec = 2;
    tm.tv_usec = 0;
    // Receive until the peer shuts down the connection
    if (select(0, &ReadFDs, NULL, NULL, &tm) > 0)
    {
    
        memset(m_Recvbuf,0,m_Recvbuflen);
        if (FD_ISSET(ClientSocket, &ReadFDs))
        {
            iResult = recv(ClientSocket, m_Recvbuf, m_Recvbuflen, 0);
            if (iResult > 0) 
            {
                std::cout << "Bytes received:" << iResult << " Message:" << m_Recvbuf << std::endl;
                m_SRecvBuf = m_Recvbuf;
                return CompareCommand();
                // Echo the buffer back to the sender
            }
            else  
            {
                printf("recv failed with error: %d\n", WSAGetLastError());
                closesocket(ClientSocket);
                WSACleanup();
                return 1;
            }
        }
    }

    std::cout << "TimeOut" << std::endl;
    return 0;
}
int TCPObj::Connect()
{

    
    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR) {
        printf("listen failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }
    std::cout << "Client connected" << std::endl;
    // Accept a client socket
    ClientSocket = accept(ListenSocket, NULL, NULL);
    if (ClientSocket == INVALID_SOCKET) {
        printf("accept failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }
    std::cout << "Client Accepted" << std::endl;
    return 0;


}

int TCPObj::Create()
{
    	    
    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
    if (iResult != 0) {
        printf("WSAStartup failed with error: %d\n", iResult);
        return 1;
    }

    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags = AI_PASSIVE;

    // Resolve the server address and port
    iResult = getaddrinfo(NULL, m_PortAddress.c_str(), &hints, &result);
    if ( iResult != 0 ) {
        printf("getaddrinfo failed with error: %d\n", iResult);
        WSACleanup();
        return 1;
    }

    // Create a SOCKET for the server to listen for client connections.
    ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET) {
        printf("socket failed with error: %ld\n", WSAGetLastError());
        freeaddrinfo(result);
        WSACleanup();
        return 1;
    }

    // Setup the TCP listening socket
    iResult = bind( ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
        printf("bind failed with error: %d\n", WSAGetLastError());
        freeaddrinfo(result);
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    freeaddrinfo(result);

    return 0;
}
int TCPObj::Close()
{
     // shutdown the connection since we're done
    iResult = shutdown(ClientSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        printf("shutdown failed with error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
    // cleanup
    closesocket(ClientSocket);
    WSACleanup();
    return 0;
}

std::vector<std::string> TCPObj::ReadFileByBlocks(const char* filename)
{
    std::vector<std::string> vecstr;

    std::ifstream fin(filename, std::ios_base::in);
    if (fin.is_open())
    {
        uint32_t size = fin.tellg();
        fin.seekg( 0, std::ios::end );
        size = fin.tellg();
        double numblocks = size/m_Recvbuflen;
        numblocks = std::ceil(numblocks);


        char* buffer = new char[m_Recvbuflen];
        memset(buffer,0,m_Recvbuflen);
        snprintf(buffer, sizeof(buffer), "%d", static_cast<int>(numblocks));
        WritePort(buffer);

        //while (fin.read(buffer, recvbuflen))
        //{
            
         //   WritePort(buffer);
        //}/

       // if the bytes of the block are less than 1024,
       // use fin.gcount() calculate the number, put the va
       // into var s
       //std::string s(buffer, fin.gcount());
       //vecstr.push_back(s);

       //delete[] buffer;
       fin.close();
   }
   else
   {
        std::cerr << "Cannot open file:" << filename << std::endl;
   }

   return vecstr;
}
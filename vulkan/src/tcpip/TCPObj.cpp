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
#include "TCPObj.hpp"
int TCPObj::WritePort()
{
    iSendResult = send( ClientSocket, recvbuf, iResult,0);
    if (iSendResult == SOCKET_ERROR) 
    {
        printf("send failed with error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
    printf("Bytes sent: %d\n", iSendResult);
    m_RecvBuf = "";
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
    
        memset(recvbuf,0,recvbuflen);
        if (FD_ISSET(ClientSocket, &ReadFDs))
        {
            iResult = recv(ClientSocket, recvbuf, recvbuflen, 0);
            if (iResult > 0) 
            {
                //recv(ClientSocket, recvbuf, recvbuflen, 0);
                printf("Bytes received: %d\n", iResult);
                //printf("%s\n",recvbuf, iResult);
                std::cout << recvbuf << std::endl;
                m_RecvBuf = recvbuf;
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
    iResult = getaddrinfo(NULL, DEFAULT_PORT, &hints, &result);
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

    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR) {
        printf("listen failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // Accept a client socket
    ClientSocket = accept(ListenSocket, NULL, NULL);
    if (ClientSocket == INVALID_SOCKET) {
        printf("accept failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }
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
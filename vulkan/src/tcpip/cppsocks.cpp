/**
 *  @author: Clemens Pruggmayer (PrugClem)
 *  @date:   2020-12-22
 *  @desc:   test program to test features for the cppsock library
 */
#include "cppsock.hpp"
#include <iostream>
#include <thread>

void print_error(const char* msg)
{
    printf("error message: %s", msg);
    perror(msg);
    //printf("%s: %s\n", msg, strerror(errno));
    fflush(stderr);
    errno = 0;
}

void print_details(const cppsock::socket &s, const std::string& id)
{
    std::cout << "Details for socket \"" << id << "\"\n"
              << "sockname: " << s.getsockname() << "\n"
              << "peername: " << s.getpeername() << "\n";
}

void abort(const char *a_msg, const char *add_msg = nullptr)
{
    if(a_msg != nullptr) printf("Aborting: %s\n", a_msg);
    if(add_msg != nullptr) printf("Additional message: %s\n", add_msg);
    std::cout << "Aborting..." << std::endl;
    std::cout << "=====================================================" << std::endl;
    std::cout << "cppsock test failed" << std::endl << std::endl;
    exit(EXIT_FAILURE);
}

void check_errno(const char *s_msg, const char *add_msg = nullptr)
{
    if(errno != 0)
    {
        print_error(s_msg);
        if(add_msg != nullptr) printf("Additional message: %s\n", add_msg);
        abort("Errno check failed");
    }
}

void init_buf(char *buf, size_t len)
{
    for(size_t i=0; i<len; i++)
    {
        buf[i] = i & 0xFF;
    }
}

void test_collection(uint16_t port)
{
    std::mutex stdoutmtx;
    std::vector<cppsock::tcp::client> clients;
    cppsock::tcp::socket_collection collection (
            [&stdoutmtx](std::shared_ptr<cppsock::tcp::socket> sock, cppsock::socketaddr_pair addr, void** pers)
            {   std::lock_guard<std::mutex> lock(stdoutmtx);
                std::cout << "[callback] connected " << addr.remote << std::endl;
            },
            [&stdoutmtx](std::shared_ptr<cppsock::tcp::socket> sock, cppsock::socketaddr_pair addr, void** pers)
            {   std::lock_guard<std::mutex> lock(stdoutmtx);
                char buf[16];
                std::streamsize ret = sock->recv(buf, sizeof(buf), 0);
                if(ret > 0)
                    std::cout << "[callback] echoing to " << addr.remote << ": " << buf << std::endl;
                else
                {
                    std::cout << "[callback] connection closed in on_recv handler: " << addr.remote << std::endl;
                    return;
                }
                sock->send(buf, strlen(buf)+1, 0);
            },
            [&stdoutmtx](std::shared_ptr<cppsock::tcp::socket> sock, cppsock::socketaddr_pair addr, void** pers)
            {   std::lock_guard<std::mutex> lock(stdoutmtx);
                std::cout << "[callback] disconnected " << addr.remote << std::endl;
            } 
        );
    cppsock::tcp::server server(&collection);
    server.start(cppsock::make_any(port), 2);
    std::cout << "started server" << std::endl;
    clients.resize(10);
    for(cppsock::tcp::client &client : clients)
    {
        client.connect(cppsock::make_loopback(port));
    }
    for(cppsock::tcp::client& client : clients)
    {
        client.send("Hello", 6, 0);
    }
    for(size_t i=0; i<clients.size()/2; i++) // close half sockets from the client side
    {
        cppsock::tcp::client &client = clients.at(i);
        client.shutdown(cppsock::shutdown_both);
    }
    server.stop();
    stdoutmtx.lock();
        std::cout << "stopped server" << std::endl;
        std::cout << "collection content: " << collection.count() << " connections" << std::endl;
    stdoutmtx.unlock();
    collection.clear();
    std::cout << "cleared collection" << std::endl;
}

int main()
{
    cppsock::socket sock_listener, sock_server, sock_client;
    cppsock::tcp::listener tcp_listener;
    cppsock::tcp::socket tcp_socket;
    cppsock::tcp::client tcp_client;
    cppsock::udp::socket udp_sock1, udp_sock2;

    cppsock::error_t swap_err;

    const size_t buflen = 256;
    uint64_t byte_test = (uint64_t)0x4142434445464748;
    float float_test = 1.12345f;
    double double_test = 1.12345;
    char sendbuf[buflen], recvbuf[buflen];

    std::cout << "This machine's hostname: \"" << cppsock::hostname() << "\"" << std::endl;

   
    init_buf(sendbuf, sizeof(sendbuf));
    memset(recvbuf, 0, sizeof(recvbuf));
    
    cppsock::tcp_listener_setup(sock_listener, nullptr, 10004, 1);                              
        check_errno("Error setting up TCP server");
    
        //cppsock::tcp_client_connect(sock_client, nullptr, 10004);                                   check_errno("Error connecting to TCP server");
    
    sock_listener.accept(sock_server); 
        std::cout << "accept" << std::endl;
        check_errno("Error accepting TCP connection");
    
        //sock_client.send(sendbuf, buflen, 0);                                                       check_errno("Error sending data");
    
    std::cout << "bytes available: " << sock_server.available() << std::endl;                   
        std::cout << "available" << std::endl;
        check_errno("Error getting available bytes");
    
    for (int ii = 0;ii<10;ii++)
    {
        sock_server.recv(recvbuf, buflen, 0);     
        std::string r = recvbuf;
        std::cout << r << std::endl;
        check_errno("Error receiving data");
        if (!r.compare("quit"))
            break;
    }

    std::cout << recvbuf << std::endl;

    sock_listener.close();
    sock_server.close(); 
    std::cout << std::endl;    
    check_errno("Error closing sockets");

   // if(memcmp(sendbuf, recvbuf, buflen) != 0) {print_error("ERROR: Data was received incorrectly");
   //     exit(1);}

  

     // test completed successfully
    std::cout   << "=====================================================" << std::endl
                << "cppsock test completed successfully" << std::endl << std::endl;
}

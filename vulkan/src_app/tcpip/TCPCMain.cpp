

#include "mout2_0/mout.hpp"
extern MsgStream			mout;    

#include "TCPCObj.hpp"
#include <vector>
#include "libconfig.h"
#include "ConfigObj.hpp"
MsgStream			mout;    
int __cdecl main(int argc, char **argv) 
{
    
    ConfigObj*			MpsApp;   
    TCPCObj* tcpc = new TCPCObj;
    tcpc->Create();
    std::string cmd;
    mout.Init("particle.log", "Particle");
	MpsApp = new ConfigObj;
	MpsApp->Create("mpsclient.cfg");
    tcpc->SetServerIP(MpsApp->GetString("ipaddress",true));
    tcpc->SetServerPort(MpsApp->GetString("ipport",true));
    
    while(1) 
    {
        std::cout << "Enter Command:";
        std::cin >> cmd;
        if(cmd.compare("quit") == 0)
        {
            tcpc->WritePort(cmd);     
            tcpc->Close();
            break;
        }
       tcpc->WritePort(cmd);     
        tcpc->ReadPort();
    }
  

    return 0;
}
//
//  client.c
//  Chat
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#include "client.h"


#define FILENAME    "client.h"
#define MYPORT      "3490"  // the port users will be connecting to
#define HOST_IP     "192.168.123.12"

struct addrinfo     hints;
struct addrinfo     *res;
int                 sock = -1;


// socket 初始化
int cltSocketInit()
{
    memset(&hints, 0, sizeof(hints));
    hints.ai_family     =   PF_UNSPEC;//AF_UNSPEC;
    hints.ai_socktype   =   SOCK_STREAM;
    hints.ai_flags      =   AI_PASSIVE;
    getaddrinfo(HOST_IP, MYPORT, &hints, &res);
    
    sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock == -1) {
        CHAT_LOG(   FILENAME, 35, LogLevel[2], 1, "init socket error!");
        return -1;
    }
    
    return 0;
};

//连接socket
void connect_socket()
{
    int ret = connect(sock, res->ai_addr, sizeof(res->ai_addr));
    if (ret < 0) {
        CHAT_LOG(FILENAME, 40, LogLevel[2], 1, "socket connect fail!");
    }
};

int initSocket()
{
    int ret = cltSocketInit();
    if (ret == -1) {
        return -1;
    }
    connect_socket();
    
    return 0;
};

int sendMsg(char * msg)
{
    if (sock == -1) {
        CHAT_LOG(FILENAME, 62, LogLevel[4], 1, "socket not init");
        return -1;
    }
    send(sock, msg, strlen(msg), 0);
    
    return 0;
};



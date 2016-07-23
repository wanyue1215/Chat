//
//  Server.c
//  Chat
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#include "Server.h"

#define MYPORT "3490"  // the port users will be connecting to
#define BACKLOG 10     // how many pending connections queue will hold

#define MAXMSGBUFFER   2048

void *get_in_addr(struct sockaddr *sa);

int     sockfd;

int openServer()
{
    
    int ret = 0;
    printf("%s","----------- server starting-----------\n");
    struct addrinfo hints, *res;
    
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;
    getaddrinfo(NULL, MYPORT, &hints, &res);    //第一个参数设置 ip
    sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    bind(sockfd, res->ai_addr , res->ai_addrlen);
    listen(sockfd, BACKLOG);
    printf("server: waiting for connections...\n");
    
    struct sockaddr_storage their_addr; // connector's address information
    socklen_t sin_size;
    int new_fd;
    char s[INET6_ADDRSTRLEN];
    
    
    while (1) {
        sin_size = sizeof their_addr;
        new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);
        if (new_fd == -1) {
            perror("accept");
            continue;
        }
        
        
        inet_ntop(their_addr.ss_family, get_in_addr((struct sockaddr *)&their_addr), s, sizeof s);
        CHAT_LOG("Server.c", 50, LogLevel[1], 0, "客户端连接成功");
        printf("server: got connection from %s %d\n", s, new_fd);
        
        char msg[MAXMSGBUFFER];
        recv(new_fd, msg, sizeof(msg)-1, 0);
        printf("%s\n------recv",msg);
        
        
//        if (!fork()) { // this is the child process
//            close(sockfd); // child doesn't need the listener
//            if (send(new_fd, "Hello, world!", 13, 0) == -1)
//                perror("send");
//            close(new_fd);
//            exit(0);
//        }
    }
    return ret;
};

void closeSocketSever()
{
    if (sockfd > 0) {
        close(sockfd);
    }
};



// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa)
{
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }
    
    return &(((struct sockaddr_in6*)sa)->sin6_addr);
};


//int    connect_socket(char * server,int serverPort){
//    int    sockfd=0;
//    struct    sockaddr_in    addr;
//    struct    hostent        * phost;
//    //向系统注册，通知系统建立一个通信端口
//    //AF_INET表示使用IPv4协议
//    //SOCK_STREAM表示使用TCP协议
//    if((sockfd=socket(AF_INET,SOCK_STREAM,0))<0){
//        herror("Init socket error!");
//        return -1;
//    }
//
//    bzero(&addr,sizeof(addr));
//    addr.sin_family=AF_INET;
//    addr.sin_port=htons(serverPort);
//    addr.sin_addr.s_addr=inet_addr(server);//按IP初始化
//    if(addr.sin_addr.s_addr == INADDR_NONE){//如果输入的是域名
//        phost = (struct hostent*)gethostbyname(server);
//        if(phost==NULL){
//            herror("Init socket s_addr error!");
//            return -1;
//        }
//        addr.sin_addr.s_addr =((struct in_addr*)phost->h_addr)->s_addr;
//    }
//    if(connect(sockfd,(struct sockaddr*)&addr,sizeof(addr))<0)
//        return -1;//0表示成功，-1表示失败
//    else
//        return sockfd;
//
//}
//
///**************************************************************
// * 发送消息，如果出错返回-1，否则返回发送的字符长度
// * sockfd：socket标识，sendBuff：发送的字符串
// * *********************************************************/
//int    send_msg(int sockfd,char * sendBuff){
//    int    sendSize=0;
//    if((sendSize=send(sockfd,sendBuff,strlen(sendBuff),0))<=0){
//        herror("Send msg error!");
//        return -1;
//    }else
//        return sendSize;
//}
//
///****************************************************************
// *接受消息，如果出错返回NULL，否则返回接受字符串的指针(动态分配，注意释放)
// *sockfd：socket标识
// * *********************************************************/
//char *    recv_msg(int sockfd){
//    char * response;
//    int  flag=0,recLenth=0;
//    response=(char *)malloc(RES_LENGTH);
//    memset(response,0,RES_LENGTH);
//    for(flag=0;;){
//        if((recLenth=recv(sockfd,response+flag,RES_LENGTH-flag,0))==-1){
//            free(response);
//            herror("Recv msg error!");
//            return NULL;
//        }else if(recLenth==0)
//            break;
//        else{
//            flag+=recLenth;
//            recLenth=0;
//        }
//    }
//    response[flag]='/0';
//
//    return response;
//}
///**************************************************
// *关闭连接
// * **********************************************/
//int    close_socket(int sockfd){
//    close(sockfd);
//    return 0;
//}

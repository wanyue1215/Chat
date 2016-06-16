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
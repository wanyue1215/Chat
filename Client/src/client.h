//
//  client.h
//  Chat
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#ifndef client_h
#define client_h

#include <stdio.h>
#include <netdb.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <string.h>
#include "ChatLog.h"
/**
 初始化socket
 
 - returns: <#return value description#>
 */
int initSocket();

/**
 *  发送消息
 *
 *  @param msg 消息字符串
 *
 *  @return 发送状态
 */
int sendMsg(char * msg);

#endif /* client_h */

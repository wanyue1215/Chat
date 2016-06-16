//
//  Server.h
//  Chat
//
//  Created by 宛越 on 16/6/6.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#ifndef Server_h
#define Server_h

#include <stdio.h>

#include <netdb.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <string.h>
#include "ChatLog.h"

int openServer();

void closeSocketSever();

#endif /* Server_h */

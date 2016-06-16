//
//  redisClient.c
//  Chat
//
//  Created by 宛越 on 16/6/16.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#include "redisClient.h"

#define     REDIS_HOST  "127.0.0.1"
#define     REDIS_PORT  6379

int connect_redis()
{
    redisContext* context = redisConnect(REDIS_HOST, REDIS_PORT);
    if (context == NULL || context->err) {
        if (context) {
            printf("Error %s\n",context->errstr);
        } else {
            printf("Can't allocate redis context\n");
        }
    }
    
    return 0;
};
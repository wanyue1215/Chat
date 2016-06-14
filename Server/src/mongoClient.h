//
//  mongoClient.h
//  Chat
//
//  Created by 宛越 on 16/6/14.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#ifndef mongoClient_h
#define mongoClient_h

#include <stdio.h>

#include <bson.h>
#include <bcon.h>
#include <mongoc.h>

#include "cJSON_Utils.h"

#include "Marcos.h"

#include "JSONDefine.h"



/**
 *  连接mongodb 数据库
 *
 *  @param db_host 数据库地址
 *  @param db_name 数据库名称
 */
//void connect_mongo_db(const char *host, const char *name);

/**
 *  关闭 mongodb 的连接
 *  包括 数据库连接和mongo 客户端连接；
 */
//void free_db_connect();

/**
 *  获取 mongodb 的collection;
 *  没有情况下创建collection，有的情况下获取collection;
 *
 *  @param collection_name collection 名
 *
 */
//mongoc_collection_t*  get_mongo_collection(const char* collection_name);


/**
 *  数据库连接
 *
 *  @return 连接状态
 */
int connect_db();

/**
 *  释放数据库连接
 *
 *  @return 状态
 */
int freeDb();


#endif /* mongoClient_h */

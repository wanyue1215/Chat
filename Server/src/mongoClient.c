//
//  mongoClient.c
//  Chat
//
//  Created by 宛越 on 16/6/14.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#include "mongoClient.h"

/**
 *  mongodb     客户端
 */
mongoc_client_t     *client;
/**
 *  mongodb     数据库
 */
mongoc_database_t   *database;


void connect_mongo_db(const char *host, const char *name)
{
    bson_t              *command,
    reply;
    
    bson_error_t        error;
    char                *str;
    bool                retval;
    
    mongoc_init();
    client = mongoc_client_new(host);
    //连接失败
    if(client == NULL){
        printf("connect mongodb fail db_host: %s" , host);
        return;
    }
    
    command = BCON_NEW ("ping", BCON_INT32 (1));
    
    retval = mongoc_client_command_simple (client, "admin", command, NULL, &reply, &error);
    
    if (!retval) {
        fprintf (stderr, "%s\n", error.message);
        bson_destroy (&reply);
        return;
    }
    
    str = bson_as_json (&reply, NULL);
    printf ("%s\n", str);
    bson_destroy (&reply);
    bson_destroy (command);
    bson_free (str);
    database = mongoc_client_get_database(client, name);
    
    mongoc_cleanup();
    return;
};

void free_db_connect()
{
    if (client == NULL) {
        printf("mongdb do not connect\n");
        return;
    }
    if (database == NULL) {
        printf("database is null\n");
    } else {
        mongoc_database_destroy(database);
    }
    mongoc_client_destroy(client);
    return;
};


int connect_db()
{
//    mongoc_collection_t     * collection;
//    bson_t                  *insert;
//    bson_error_t            error;
//    
//    
//    const char *value = "{\"hello\": \"world\", \"a\": \"b\"}";
//    cJSON *root = cJSON_Parse(value);
//    char *a = cJSON_GetObjectItem(root, Hello)->valuestring;
////    printf("%s\n",a);
    
    //连接数据库
    connect_mongo_db(DB_host, DB_name);
    if (client ==NULL || database == NULL) {
        free_db_connect();
        return -1;
    }
    
    return 0;
};

int freeDb()
{
//    const char *collection_name = "test_collection";
//    collection = mongoc_client_get_collection (client, DB_name , collection_name);
//    
//    insert = BCON_NEW("hello" ,BCON_UTF8("mongodb"));
//    if(!mongoc_collection_insert(collection, MONGOC_INSERT_NONE, insert, NULL, &error)){
//        fprintf (stderr, "%s\n", error.message);
//    }
//    mongoc_collection_destroy (collection);
    free_db_connect();
    mongoc_cleanup ();
    return 1;
};


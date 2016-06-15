//
//  ChatLog.h
//  Chat
//
//  Created by 宛越 on 16/6/14.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#ifndef ChatLog_h
#define ChatLog_h

extern int LogLevel[5];

/**
 *  写入日志
 *
 *  @param file   出错的文件名
 *  @param line   行数
 *  @param level  级别
 *  @param status 状态
 *  @param fmt    格式
 *  @param ...
 */
void CHAT_LOG(const char *file , int line,int level , int status , const char *fmt , ...);

#endif /* ChatLog_h */

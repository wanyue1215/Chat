//
//  ChatLog.c
//  Chat
//
//  Created by 宛越 on 16/6/14.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#include "ChatLog.h"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>

#include <time.h>

#define CHAT_DEBUG_FILE_	"client.log"
#define CHAT_MAX_STRING_LEN 		10240

#define CT_NO_LOG_LEVEL			0
#define CT_DEBUG_LEVEL			1
#define CT_INFO_LEVEL			2
#define CT_WARNING_LEVEL		3
#define CT_ERROR_LEVEL			4

int  LogLevel[5] = {CT_NO_LOG_LEVEL, CT_DEBUG_LEVEL, CT_INFO_LEVEL, CT_WARNING_LEVEL, CT_ERROR_LEVEL};

char CHLevelName[5][10] = { "NOLOG" , "DEBUG" , "INFO" ,"WARNING" ,"ERROR" };

static int CHAT_Error_OpenFile(int* pf)
{
    char    fileName[1024];
    memset(fileName, 0, sizeof(fileName));
    
    
//    strncpy(fileName, CHAT_DEBUG_FILE_, sizeof(CHAT_DEBUG_FILE_));
    
    sprintf(fileName, "%s/log/%s", getenv("HOME"), CHAT_DEBUG_FILE_);
    *pf = open(fileName, O_WRONLY|O_CREAT|O_APPEND,0666);
    
    if(*pf < 0){
        return -1;
    }
    return 0;
};

static int CHAT_Error_GetCurTime(char *timeStr)
{
   	struct tm*		tmTime = NULL;
    time_t			tTime = 0;
    
    if (timeStr == NULL) {
        return 0;
    }
    
    tTime = time(NULL);
    tmTime = localtime(&tTime);
    
    size_t timeLen = strftime(timeStr, 40, "%Y.%m.%d %H:%M:%S", tmTime);
    printf("%s\n",timeStr);
    
    return timeLen;
};


void CHAT_Error_Code(const char *file , int line,int level , int status , const char *fmt,va_list args)
{
    char    str[CHAT_MAX_STRING_LEN];
    int     strlen = 0;
    char    tmpStr[64];
    int     tmpStrLen = 0;
    int     pf = 0;
    
    memset(str, 0, CHAT_MAX_STRING_LEN);
    memset(tmpStr, 0, sizeof(tmpStr));
    
    if (CHAT_Error_OpenFile(&pf) == -1)
    {
        printf("%s\n","文件打开失败");
    }
    
    //日志时间
    tmpStrLen = CHAT_Error_GetCurTime(tmpStr);
    tmpStrLen = sprintf(str, "[%s]",tmpStr);
    strlen = tmpStrLen;
    //状态
    if (status != 0) {
        tmpStrLen = sprintf(str + strlen, "[ERRNO %d]", status);
    } else {
        tmpStrLen = sprintf(str + strlen, "[SUCCESS] ");
    }
    strlen += tmpStrLen;
    //
    tmpStrLen = vsprintf(str + strlen, fmt, args);
    strlen += tmpStrLen;
    
    //文件名
    tmpStrLen = sprintf(str + strlen , "[%s]",file);
    strlen += tmpStrLen;
    //行数
    tmpStrLen = sprintf(str + strlen, "[%d] \n", line);
    strlen += tmpStrLen;
    
    write(pf, str, strlen);
    close(pf);
    return;
};

void CHAT_LOG(const char *file , int line,int level , int status , const char *fmt , ...)
{
    if (level == CT_NO_LOG_LEVEL)
    {
        return;
    }
    
    va_list args;
    va_start(args, fmt);
    CHAT_Error_Code(file, line, level, status, fmt, args);
    va_end(args);
};
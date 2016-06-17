//
//  Common.m
//  Chat
//
//  Created by 宛越 on 16/6/16.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import "Common.h"

@implementation Common


+(NSData *) toJSONDdata:(id) data
{

    NSError* err = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&err];
    if (jsonData.length > 0 && err == nil) {
        return jsonData;
    } else {
        return nil;
    }
};

@end

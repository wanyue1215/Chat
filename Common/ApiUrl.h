//
//  ApiUrl.h
//  Chat
//
//  Created by 宛越 on 16/7/13.
//  Copyright © 2016年 yuewan. All rights reserved.
//

#import <Foundation/Foundation.h>


#define  GET_QR_CODE_URL        "https://ssl.ptlogin2.qq.com/ptqrshow?appid=501004106&e=0&l=M&s=5&d=72&v=4&t=0.1"
#define  GET_QR_CODE_REFERER    ""


#define  VERIFY_QR_CODE_URL     "https://ssl.ptlogin2.qq.com/ptqrlogin?webqq_type=10&remember_uin=1&login2qq=1&aid=501004106&u1=http%3A%2F%2Fw.qq.com%2Fproxy.html%3Flogin2qq%3D1%26webqq_type%3D10&ptredirect=0&ptlang=2052&daid=164&from_ui=1&pttype=1&dumy=&fp=loginerroralert&action=0-0-157510&mibao_css=m_webqq&t=1&g=1&js_type=0&js_ver=10143&login_sig=&pt_randsalt=0"
#define  VERIFY_QR_REFERER      "https://ui.ptlogin2.qq.com/cgi-bin/login?daid=164&target=self&style=16&mibao_css=m_webqq&appid=501004106&enable_qlogin=0&no_verifyimg=1&s_url=http%3A%2F%2Fw.qq.com%2Fproxy.html&f_url=loginerroralert&strong_login=1&login_state=10&t=20131024001"

#define PTWEBQQ_URL         ""
#define PTWEBQQ_REFERER     "http://s.web2.qq.com/proxy.html?v=20130916001&callback=1&id=1"

#define VFWEBQQ_URL         "http://s.web2.qq.com/api/getvfwebqq?ptwebqq=%@&clientid=53999199&psessionid=&t=%@"
#define VFWEBQQ_REFERER     "http://s.web2.qq.com/proxy.html?v=20130916001&callback=1&id=1"


#define GET_UIN_AND_PSESSIONID_URL      "http://d1.web2.qq.com/channel/login2"
#define GET_UIN_AND_PSESSIONID_REFERER  "http://d1.web2.qq.com/proxy.html?v=20151105001&callback=1&id=2"

@interface Urls : NSObject
@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) NSString* referer;
@end

@interface ApiUrl : NSObject

+(instancetype)sharedManager;

@property (nonatomic,strong) NSString* USER_AGENT;

@property (nonatomic,strong) Urls* GET_QR_CODE;
@property (nonatomic,strong) Urls* VERIFY_QR_CODE;
@property (nonatomic,strong) Urls* GET_PTWEBQQ;
@property (nonatomic,strong) Urls* GET_VFWEBQQ;
@property (nonatomic,strong) Urls* GET_UIN_AND_PSESSIONID;

-(void) setVFWebQQUrl:(NSString* )url;

@end

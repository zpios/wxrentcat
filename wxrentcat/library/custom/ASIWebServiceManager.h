//
//  ASIWebServiceManager.h
//  ASIWebServiceManager
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "ASIFormDataRequest.h"

typedef enum {
    WXWEB_REQ_BANNER = 0,
    WXWEB_REQ_LOGIN,
    WXWEB_REQ_RETRIVE_PWD,
	WXWEB_REQ_STORES,
	WXWEB_REQ_VECHICLES,
 	WXWEB_REQ_SUBMIT_ORDER,
	WXWEB_REQ_MODIFY_INFO,
 	WXWEB_REQ_CHANGE_PWD,
	WXWEB_REQ_SCORES,
 	WXWEB_REQ_COMPLAINT,
    WXWEB_REQ_ORDERS,
	WXWEB_REQ_SRCH_ORDER,
	WXWEB_REQ_CANCEL_ORDER,
 	WXWEB_REQ_CONTINUE_ORDER,
	WXWEB_REQ_SRCH_POWER,
 	WXWEB_REQ_SRCH_RECHARGE,
	WXWEB_REQ_FAVORITE,
    WXWEB_REQ_PUSH
} WXWebRequestTypes;


#ifndef __SOAP_WEBSERVICE_MANAGER__
#define __SOAP_WEBSERVICE_MANAGER__
#endif



@interface ASIWebServiceManager :NSObject <MBProgressHUDDelegate, ASIHTTPRequestDelegate, NSXMLParserDelegate>
{}

+ (ASIWebServiceManager *)defaultManager;
- (void)checkWebStatus;

@end


//
//  ASIWebServiceManager.m
//  ASIWebServiceManager
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//

#import "ASIWebServiceManager.h"
#import "Reachability.h"

static ASIWebServiceManager* _defMgr = nil;

@interface ASIWebServiceManager ()
@property (nonatomic,retain) MBProgressHUD *hintsAlert;
@property (nonatomic,retain) ASIFormDataRequest *dataRequest;
@property (nonatomic,assign) WXWebRequestTypes reqType;
@property (nonatomic,assign) NSInteger mServiceType;

@property (nonatomic,retain) NSXMLParser *mXmlParser;
@property (nonatomic,assign) BOOL mRecordStatus;


@property (nonatomic, retain) NSMutableArray *mFindElems;
@property (nonatomic,retain) NSMutableString *mResults;

@end

@interface ASIWebServiceManager ( Private )
- (void)parseRecievedData:(NSData *)data;

@end


@implementation ASIWebServiceManager
@synthesize hintsAlert;
@synthesize dataRequest;
@synthesize reqType;
@synthesize mServiceType;

@synthesize mResults;
@synthesize mXmlParser;
@synthesize mRecordStatus;

@synthesize mFindElems;

#pragma mark - 
#pragma mark - PRIVATE Methods
- (NSURL *)decodedGBKURL:(NSString *)gbkUrlString
{
    //resolved the url contained chinese string:kCFStringEncodingGB_18030_2000
    NSString *decodedGBurl = [gbkUrlString stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    // NSLog(@"decoded gbk url=\n%@", decodedGBurl);
    NSURL *url  =   [NSURL URLWithString:decodedGBurl];
    return url;
}

- (void)showAlert:(NSString*)infoStr
{
	[self performSelectorOnMainThread:@selector(showAlertInfoA:) withObject: infoStr waitUntilDone:NO];
}

- (void) showAlertInfoA:(NSString*) infoStr
{
	NSString *ok = NSLocalizedStringWithDefaultValue(@"ok", nil, [NSBundle mainBundle], @"确定", @"确定");
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message: infoStr delegate:nil cancelButtonTitle:ok otherButtonTitles:nil];
	[alert show];
    [alert release];
}

- (void) displayHintsAlert
{
    if (self.hintsAlert != nil) {
        self.hintsAlert = nil;
    }
    UIWindow *baseWindow = [[UIApplication sharedApplication].delegate window];
    self.hintsAlert = [[[MBProgressHUD alloc] initWithView:baseWindow] autorelease];
    [baseWindow addSubview:self.hintsAlert];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    self.hintsAlert.delegate = self;
    self.hintsAlert.dimBackground = YES;
    
    [self.hintsAlert show:YES];
    
}

- (void)hideHintsAlert
{
    [self.hintsAlert hide:YES];
    self.hintsAlert = nil;
}


#pragma mark -
#pragma mark Private Service Methods
// construct message body
// 0
- (NSString *)wxsoopBannerMessage:(NSDictionary *)msgDict
{
    NSString *adVersion = [msgDict valueForKey:@"adVersion"];
    if ([adVersion length] <= 0) {
        adVersion = @"";
    }
    return SOAP_BANNER_CMD(adVersion); 
}
// 1
- (NSString *)wxsoopLoginMessage:(NSDictionary *)msgDict
{
    // TODO: 
    NSString *userName = @"ineedtwo@126.com";//[msgDict valueForKey:@"userName"];
    NSString *userPwd = @"wangle123";//[msgDict valueForKey:@"userPwd"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    return SOAP_LOGIN_CMD(userName, userPwd);
}
// 2
- (NSString *)wxsoopRetrievePwdMessage:(NSDictionary *)msgDict
{
    NSString *phone = [msgDict valueForKey:@"phoneNumber"];
    NSString *email = [msgDict valueForKey:@"email"];
    if ([phone length] <= 0) { phone = @""; }
    if ([email length] <= 0) { email = @""; }
    return SOAP_PWDRETRIVE_CMD(phone, email);
}
// 3
- (NSString *)wxsoopStoresMessage:(NSDictionary *)msgDict
{
    NSString *longitude = [msgDict valueForKey:@"longitude"];
    NSString *latitude = [msgDict valueForKey:@"latitude"];
    NSString *altitude = [msgDict valueForKey:@"altitude"];
    NSString *cityName = [msgDict valueForKey:@"cityName"];
    if ([longitude length] <= 0) { longitude = @""; }
    if ([latitude length] <= 0) { latitude = @""; }
    if ([altitude length] <= 0) { altitude = @""; }
    if ([cityName length] <= 0) { cityName = @""; }
    return SOAP_STORES_CMD(longitude, latitude, altitude, cityName);
}
// 4
- (NSString *)wxsoopVehiclesMessage:(NSDictionary *)msgDict
{
    NSString *storeID = [msgDict valueForKey:@"storeID"];
    if ([storeID length] <= 0) { storeID = @""; }
    return SOAP_VEHICLES_CMD(storeID);
    
}
// 5
- (NSString *)wxsoopSubmitOrderMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *vehicleID = [msgDict valueForKey:@"vehicleID"];
    NSString *takeVehicleStoreID = [msgDict valueForKey:@"takeVehicleStoreID"];
    NSString *vehicleDate = [msgDict valueForKey:@"vehicleDate"];
    NSString *retVehicleStoreID = [msgDict valueForKey:@"retVehicleStoreID"];
    NSString *childSeat = [msgDict valueForKey:@"childSeat"];
    NSString *gpsDevice = [msgDict valueForKey:@"gpsDevice"];
    NSString *invoice = [msgDict valueForKey:@"invoice"];
    if ([userName length] <= 0) { userName = @""; }
    if ([vehicleID length] <= 0) { vehicleID = @""; }
    if ([takeVehicleStoreID length] <= 0) { takeVehicleStoreID = @""; }
    if ([vehicleDate length] <= 0) { vehicleDate = @""; }
    if ([retVehicleStoreID length] <= 0) { retVehicleStoreID = @""; }
    if ([childSeat length] <= 0) { childSeat = @""; }
    if ([gpsDevice length] <= 0) { gpsDevice = @""; }
    if ([invoice length] <= 0) { invoice = @""; }
    return SOAP_SUBMITORDER_CMD(userName,vehicleID, takeVehicleStoreID, 
                        vehicleDate, retVehicleStoreID, childSeat, gpsDevice,invoice);

}
// 6
- (NSString *)wxsoopModifyInfoMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *password = [msgDict valueForKey:@"password"];
    NSString *name = [msgDict valueForKey:@"name"];
    NSString *userRank = [msgDict valueForKey:@"userRank"];
    NSString *idType = [msgDict valueForKey:@"idType"];
    NSString *idx = [msgDict valueForKey:@"idx"];
    NSString *phone = [msgDict valueForKey:@"phoneNumber"];
    NSString *email = [msgDict valueForKey:@"email"];
    if ([userName length] <= 0) { userName = @""; }
    if ([password length] <= 0) { password = @""; }
    if ([name length] <= 0) { name = @""; }
    if ([userRank length] <= 0) { userRank = @""; }
    if ([idType length] <= 0) { idType = @""; }
    if ([idx length] <= 0) { idx = @""; }
    if ([phone length] <= 0) { phone = @""; }
    if ([email length] <= 0) { email = @""; }
    return SOAP_MODIFYINFO_CMD(userName,password, name, 
                                userRank, idType, idx, phone,email);

}
// 7
- (NSString *)wxsoopModifyPwdMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *oldPwd = [msgDict valueForKey:@"oldPwd"];
    NSString *newPwd = [msgDict valueForKey:@"newPwd"];
    if ([userName length] <= 0) { userName = @""; }
    if ([oldPwd length] <= 0) { oldPwd = @""; }
    if ([newPwd length] <= 0) { newPwd = @""; }
    return SOAP_MODIFYPWD_CMD(userName,oldPwd,newPwd);

}
// 8
- (NSString *)wxsoopScoresMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *userPwd = [msgDict valueForKey:@"userPwd"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    return SOAP_SCORES_CMD(userName, userPwd);
}
// 9
- (NSString *)wxsoopComplaintMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *comment = [msgDict valueForKey:@"comment"];
    NSString *phone = [msgDict valueForKey:@"phoneNumber"];
    NSString *email = [msgDict valueForKey:@"email"];
    if ([userName length] <= 0) { userName = @""; }
    if ([comment length] <= 0) { comment = @""; }
    if ([phone length] <= 0) { phone = @""; }
    if ([email length] <= 0) { email = @""; }
    return SOAP_COMPLAINT_CMD(userName,comment,phone,email);
    
}
// 10
- (NSString *)wxsoopOrdersMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *userPwd = [msgDict valueForKey:@"userPwd"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    return SOAP_ORDERS_CMD(userName, userPwd);

}
// 11
- (NSString *)wxsoopSrchOderMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *userPwd = [msgDict valueForKey:@"userPwd"];
    NSString *orderID = [msgDict valueForKey:@"orderID"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    if ([orderID length] <= 0) { orderID = @""; }
    return SOAP_SRCHORDER_CMD(userName, userPwd, orderID);
 
}
// 12
- (NSString *)wxsoopCancelOrderMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *userPwd = [msgDict valueForKey:@"userPwd"];
    NSString *orderID = [msgDict valueForKey:@"orderID"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    if ([orderID length] <= 0) { orderID = @""; }
    return SOAP_CONTINUEORDER_CMD(userName, userPwd, orderID);
}
// 13
- (NSString *)wxsoopContinueOrderMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *userPwd = [msgDict valueForKey:@"userPwd"];
    NSString *orderID = [msgDict valueForKey:@"orderID"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    if ([orderID length] <= 0) { orderID = @""; }
    return SOAP_CONTINUEORDER_CMD(userName, userPwd, orderID);
 
}
// 14
- (NSString *)wxsoopFavoritesMessage:(NSDictionary *)msgDict
{
    NSString *userName = [msgDict valueForKey:@"userName"];
    NSString *userPwd = [msgDict valueForKey:@"userPwd"];
    if ([userName length] <= 0) { userName = @""; }
    if ([userPwd length] <= 0) { userPwd = @""; }
    return SOAP_FAVORITES_CMD(userName, userPwd);

}
// 15
- (NSString *)wxsoopPushMessage:(NSDictionary *)msgDict
{
    return @""; 
}


- (NSString *)dispatchRequestCommand:(NSDictionary *)requestDict
{
    NSString *cmdsLine = @"";
    switch (self.mServiceType) {
        case 0: // banner
        {
            cmdsLine = [self wxsoopBannerMessage:requestDict];
        }
            break;
        case 1: // login
        {
            cmdsLine = [self wxsoopLoginMessage:requestDict];
        }
            break;
        case 2: // password retrived
        {
            cmdsLine = [self wxsoopRetrievePwdMessage:requestDict];
        }
            break;
        case 3: // query stores
        {
            cmdsLine = [self wxsoopStoresMessage:requestDict];
        }
            break;
        case 4: // query vehicles
        {
            cmdsLine = [self wxsoopVehiclesMessage:requestDict];
        }
            break;
        case 5: // submit order
        {
            cmdsLine = [self wxsoopSubmitOrderMessage:requestDict];
        }
            break;
        case 6: // modify user info
        {
            cmdsLine = [self wxsoopModifyInfoMessage:requestDict];
        }
            break;
        case 7: // modify password
        {
            cmdsLine = [self wxsoopModifyPwdMessage:requestDict];
        }
            break;
        case 8: // query scores
        {
            cmdsLine = [self wxsoopScoresMessage:requestDict];
        }
            break;
        case 9: // complaints
        {
            cmdsLine = [self wxsoopComplaintMessage:requestDict];
        }
            break;
        case 10: // query orders
        {
            cmdsLine = [self wxsoopOrdersMessage:requestDict];
        }
            break;
        case 11: // search order
        {
            cmdsLine = [self wxsoopSrchOderMessage:requestDict];
        }
            break;
        case 12: // cancel order
        {
            cmdsLine = [self wxsoopCancelOrderMessage:requestDict];
        }
            break;
        case 13: // continue order
        {
            cmdsLine = [self wxsoopContinueOrderMessage:requestDict];
        }
            break;
        case 14: // power status
        {
        }
            break;
        case 15: // recharge address
        {
        }
            break;
            
        case 16: // query favorites
        {
            cmdsLine = [self wxsoopFavoritesMessage:requestDict];
        }
            break;
        case 17: // push
        {
        }
            break;
            
        default:
            break;
    }
    
    return cmdsLine;
}



/////////////////////////////////////
#pragma mark -
#pragma mark Construction & Destructions Methods
+ (ASIWebServiceManager *)defaultManager
{
	@synchronized(self) {
		if (_defMgr == nil) {
			_defMgr = [[self alloc] init];
		}
	}
	return _defMgr;
}

- (id)init
{
	if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData:) name:kCWXNotificationWebServiceRequest object:nil];
        hintsAlert = nil;
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self]; 
    
    self.hintsAlert = nil;
    [self.dataRequest clearDelegatesAndCancel];
    self.dataRequest = nil;
    [super dealloc];
    
}

- (void)checkWebStatus
{
    self.mServiceType = -1;
    [self requestData:nil];
    
}

#pragma mark -
#pragma mark Web Service Methods
-(void) requestData:(NSNotification *)notification 
{
    Reachability *reacher   =   [Reachability reachabilityWithHostName:WXWEB_HOST];
    if([reacher currentReachabilityStatus] == NotReachable) {
        NSString *alertStr = @"连接服务器失败。请检查您的网络";
        [self showAlert:alertStr]; 
    }else{
        [self displayHintsAlert];
        NSString *hostURL = [NSString stringWithFormat:@"%@", WXWEB_HOST];

     
        NSString *path = @"";
		NSString *notifName = [notification name];
        if (notifName == kCWXNotificationWebServiceRequest) {
            NSDictionary *reqInfo = [notification userInfo];
            if (reqInfo != nil  && [reqInfo count] > 0) {
                NSString *theTYPE = [reqInfo valueForKey:@"type"];
                NSInteger theID = [[reqInfo valueForKey:@"requestID"] integerValue];
                NSString *theURL = [reqInfo valueForKey:@"requstURL"];
                if (theTYPE == @"0") {
                    [self.dataRequest cancel];
                    [self hideHintsAlert];
                    return;
                }
                
                if ([theURL length] <= 0) {
                    [self hideHintsAlert];
                    return;
                }
                self.mServiceType = theID;
                path = theURL;

                
                NSString *urlString = [hostURL stringByAppendingFormat:@"%@",path];
                NSString *reqMessage = [self dispatchRequestCommand:reqInfo];
                NSLog(@"urlString=%@\n\n request comand:%@\n", urlString, reqMessage);
                
                self.dataRequest     =   [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
                [self.dataRequest setRequestMethod:@"POST"]; 
                [self.dataRequest addRequestHeader:@"Content-Type" value:@"application/soap+xml; charset=utf-8"]; 
                //[dataRequest addRequestHeader:@"SOAPAction" value:@"http://rentcar.bbcwx.com/Login"]; 
                
                NSString *msgLength = [NSString stringWithFormat:@"%d", [reqMessage length]];
                [self.dataRequest addRequestHeader:@"Content-Length" value:msgLength]; 
                [self.dataRequest appendPostData:[reqMessage dataUsingEncoding:NSUTF8StringEncoding]]; 

                [self.dataRequest setResponseEncoding: NSUTF8StringEncoding];
                [self.dataRequest setTimeOutSeconds:60];
                [self.dataRequest setShouldContinueWhenAppEntersBackground:YES];
                [self.dataRequest setDelegate:self];
                [self.dataRequest startAsynchronous];

            }
        }

    }

}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate Methods
-(void) requestFinished:(ASIFormDataRequest *)request {
    [self hideHintsAlert];
    NSString *retStr = [request responseString];
    
    NSLog(@"\n Request finished!\n%@\n\n", retStr); 
    if (retStr && [retStr length] <= 0) {
        [self showAlert:@"服务器返回数据为空，请重试"];
        return;
    }
    
    [self parseRecievedData:[request responseData]];

}

-(void) requestFailed:(ASIHTTPRequest *)request{
    [self hideHintsAlert];
    NSLog(@"\n Request failed!\n%@\n\n", [request responseString]);

    
    NSString *errString = NSLocalizedStringWithDefaultValue(@"connection to server failed, please check", nil, 
                                    [NSBundle mainBundle], @"与服务器通信出现错误，请重试", @"与服务器通信出现错误，请重试");
   [self showAlert:errString];

}


#pragma mark -
#pragma mark XML Methods
// parse xml DATA
- (void)parseRecievedData:(NSData *)data
{
    if(self.mXmlParser != nil) {
        self.mXmlParser = nil;
    }
    
    if (self.mFindElems == nil) {
        self.mFindElems = [NSMutableArray arrayWithCapacity:10];
    } else if ([self.mFindElems count] > 0) {
        [self.mFindElems removeAllObjects];
    }
    
    self.mXmlParser = [[[NSXMLParser alloc] initWithData: data] autorelease];
    [self.mXmlParser setDelegate: self];
    [self.mXmlParser setShouldResolveExternalEntities: YES];
    [self.mXmlParser parse];
    
}

#pragma mark -
#pragma mark XML Parser Delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    // TODO: start one element record.
    if(self.mResults == nil) {
        self.mResults = [[[NSMutableString alloc] init] autorelease];
    } else if ([self.mResults length] > 0) {
        // clear for each tag.
        [self.mResults setString:@""];
    }
    self.mRecordStatus = TRUE;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if( self.mRecordStatus ) {
        [self.mResults appendString: string];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (self.mResults != nil) { // ignore key with no value.
        //if ([self.mResults length] > 0) { // ignore key with empty value.
            NSDictionary *keyValNode = [NSDictionary dictionaryWithObject:[NSString stringWithString:self.mResults] forKey:elementName];
            [self.mFindElems addObject:keyValNode];
        //}
    }
    
    self.mRecordStatus = FALSE;
    self.mResults = nil;
//     keep the empty tag.
//    [self.mResults setString:@""];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    // post notification for parse completed.
    NSMutableDictionary *responseDict = [NSMutableDictionary dictionaryWithCapacity:3];
    [responseDict setValue:[NSNumber numberWithBool:YES] forKey:@"result"];
    [responseDict setValue:[NSNumber numberWithInteger:self.mServiceType] forKey:@"responseID"];
    [responseDict setValue:[NSArray arrayWithArray:self.mFindElems] forKey:@"responseINFO"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCWXNotificationWebServiceResponse object:responseDict];

}

@end


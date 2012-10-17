//
//  WXAppDefaults.h
//  wxrentcat
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#ifndef RENTCAR_WXAppDefaults_h
#define RENTCAR_WXAppDefaults_h

//#define __M_DEBUG__
#ifdef __M_DEBUG__
#endif

#define WXWEB_HOST         @"http://rentcar.bbcwx.com"

// SOAP

// 0
#ifndef SOAP_BANNER_CMD
#define SOAP_BANNER_CMD(adVersion) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<advertiseUpgrade xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<currentAdvertiseVersion>%@</currentAdvertiseVersion>\n"\
"</advertiseUpgrade>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", adVersion]
#endif
// 1
#ifndef SOAP_LOGIN_CMD
#define SOAP_LOGIN_CMD(name, pwd) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"\
"<soap12:Body>\n"\
"<login xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"</login>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", name, pwd]
#endif
// 2
#ifndef SOAP_PWDRETRIVE_CMD
#define SOAP_PWDRETRIVE_CMD(phone, email) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<passwordRetrieval xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<phoneNumber>%@</phoneNumber>\n"\
"<emailAddress>%@</emailAddress>\n"\
"</passwordRetrieval>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", phone, email]
#endif
// 3
#ifndef SOAP_STORES_CMD
#define SOAP_STORES_CMD(longit, latit, altit, city) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<getStores xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<longitude>%@</longitude>\n"\
"<latitude>%@</latitude>\n"\
"<altitude>%@</altitude>\n"\
"<cityName>%@</cityName>\n"\
"</getStores>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", longit, latit, altit, city]
#endif
// 4
#ifndef SOAP_VEHICLES_CMD
#define SOAP_VEHICLES_CMD(storeid) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<getVehicles xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<storeId>%@</storeId>\n"\
"</getVehicles>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", storeid]
#endif
// 5
#ifndef SOAP_SUBMITORDER_CMD
#define SOAP_SUBMITORDER_CMD(username, vehicleid, takestoreid, vehicledate, retstoreid, childseat, gpsdevice, invoice) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<submitOrder xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<vehicleId>%@</vehicleId>\n"\
"<takeVehicleStoreId>%@</takeVehicleStoreId>\n"\
"<takeVehicleDate>%@</takeVehicleDate>\n"\
"<returnVehicleStoreId>%@</returnVehicleStoreId>\n"\
"<returnVehicleDate>%@</returnVehicleDate>\n"\
"<childSeat>%@</childSeat>\n"\
"<gpsDevice>%@</gpsDevice>\n"\
"<invoice>%@</invoice>\n"\
"</submitOrder>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", username, vehicleid, takestoreid, vehicledate, retstoreid, childseat, gpsdevice, invoice]
#endif
// 6
#ifndef SOAP_MODIFYINFO_CMD
#define SOAP_MODIFYINFO_CMD(user,pwd,name,rank, idx, type,phone,email) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<modifyPersonalInfo xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"<name>%@</name>\n"\
"<userRank>%@</userRank>\n"\
"<idType>%@</idType>\n"\
"<id>%@</id>\n"\
"<phoneNumber>%@</phoneNumber>\n"\
"<emailAddress>%@</emailAddress>\n"\
"</modifyPersonalInfo>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd,name,rank,type,idx, phone,email]
#endif
// 7
#ifndef SOAP_MODIFYPWD_CMD
#define SOAP_MODIFYPWD_CMD(user,oldpwd, newpwd) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<modifyPassword xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<oldPassword>%@</oldPassword>\n"\
"<newPassword>%@</newPassword>\n"\
"</modifyPassword>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,oldpwd, newpwd]
#endif
// 8
#ifndef SOAP_SCORES_CMD
#define SOAP_SCORES_CMD(user,pwd) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<queryScores xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"</queryScores>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd]
#endif
// 9
#ifndef SOAP_COMPLAINT_CMD
#define SOAP_COMPLAINT_CMD(user,content, phone, email) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<submitComplaintAndSuggestion xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<content>%@</content>\n"\
"<phoneNumber>%@</phoneNumber>\n"\
"<emailAddress>%@</emailAddress>\n"\
"</submitComplaintAndSuggestion>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,content, phone, email]
#endif

// 10
#ifndef SOAP_ORDERS_CMD
#define SOAP_ORDERS_CMD(user,pwd) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<queryOrders xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"</queryOrders>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd]
#endif
// 11
#ifndef SOAP_SRCHORDER_CMD
#define SOAP_SRCHORDER_CMD(user,pwd,orderid) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<queryOrder xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"<orderid>%@</orderid>\n"\
"</queryOrder>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd,orderid]
#endif
// 12
#ifndef SOAP_CNCELORDER_CMD
#define SOAP_CNCELORDER_CMD(user,pwd,orderid) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<cancelOrder xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"<orderId>%@</orderId>\n"\
"</cancelOrder>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd,orderid]
#endif
// 13
#ifndef SOAP_CONTINUEORDER_CMD
#define SOAP_CONTINUEORDER_CMD(user,pwd,orderid) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<continueOrder xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"<orderId>%@</orderId>\n"\
"</continueOrder>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd,orderid]
#endif
// 14
#ifndef SOAP_FAVORITES_CMD
#define SOAP_FAVORITES_CMD(user,pwd) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"<queryFavorite xmlns=\"http://rentcar.bbcwx.com/\">\n"\
"<userName>%@</userName>\n"\
"<password>%@</password>\n"\
"</queryFavorite>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd]
#endif
// 15
#ifndef SOAP_PUSH_CMD
#define SOAP_PUSH_CMD(user,pwd) [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"\
"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope/\">\n"\
"<soap12:Body>\n"\
"</soap12:Body>\n"\
"</soap12:Envelope>\n", user,pwd]
#endif


////////////
#ifndef RGBA
#define RGBA(r,g,b,a) [UIColor colorWithRed:(CGFloat)(r/255.0f) green:(CGFloat)(g/255.0f) blue:(CGFloat)(b/255.0f) alpha:a]
#endif

// Data Request Notifications
#ifndef kCWXNotificationWebService
#define kCWXNotificationWebServiceResponse  @"kCWXNotificationWebServiceResponse"
#define kCWXNotificationWebServiceRequest   @"kCWXNotificationWebServiceRequest"
#endif


#endif

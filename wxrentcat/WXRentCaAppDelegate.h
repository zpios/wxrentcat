//
//  WXRentCaAppDelegate.h
//  wxrentcat
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXRentCaWebServiceController;

@interface WXRentCaAppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *_navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WXRentCaWebServiceController *viewController;

@end

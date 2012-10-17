//
//  WXRentCaAppDelegate.m
//  wxrentcat
//
//  Created by WilliamQiu<qiuwilliam@hotmail.com> on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WXRentCaAppDelegate.h"

#import "WXRentCaWebServiceController.h"
#import "ASIWebServiceManager.h"

@interface WXRentCaAppDelegate ()
@property (nonatomic, retain) ASIWebServiceManager *mWebsManager;
@property (nonatomic, retain) UINavigationController *mNavigator;
@end

@implementation WXRentCaAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize mWebsManager;
@synthesize mNavigator = _navigationController;


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [_navigationController release];
    self.mWebsManager = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    self.mWebsManager = [ASIWebServiceManager defaultManager];
    [self.mWebsManager checkWebStatus];
    // Override point for customization after application launch.
    
    // Create the view controller
	WXRentCaWebServiceController *webServicesCon = [[[WXRentCaWebServiceController alloc] init] autorelease];
	self.mNavigator = [[[UINavigationController alloc] initWithRootViewController:webServicesCon] autorelease];
	
	// Display the window
	[self.window addSubview:self.mNavigator.view];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

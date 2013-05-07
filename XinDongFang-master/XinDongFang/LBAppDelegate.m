//
//  LBAppDelegate.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "LBAppDelegate.h"
#import "LoginViewController.h"
#import "SinaWeibo.h"
#import <sqlite3.h>
#import "LBData.h"


@implementation LBAppDelegate

@synthesize window;
@synthesize loginViewController;
@synthesize sinaweibo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.loginViewController = [[LoginViewController alloc] initWithData:[self checkUserPreferenceAndloadIt]];
    
    self.window.rootViewController = loginViewController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
  
    [self initDB];
    
    return YES;
}




- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}



- (NSDictionary *)checkUserPreferenceAndloadIt
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [self getFilepathForUserpreferencePlist];
    
    if (![fileManager fileExistsAtPath:plistPath]) {
        
        NSString *bundlePlistPath = [[NSBundle mainBundle] pathForResource:@"userPreference" ofType:@"plist"];
        NSError *error = nil;
        
        if (![fileManager copyItemAtPath:bundlePlistPath toPath:plistPath error:&error]) {
            
            NSAssert1(0, @"failed to create userPreference plist with message %@", [error localizedDescription]);
        }
    }
    
    NSDictionary *userPreferenceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    return userPreferenceDic;
}



- (NSString *)getFilepathForUserpreferencePlist
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:documentsDirectory]) {
        
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *plistName = [documentsDirectory stringByAppendingPathComponent:@"userPreference.plist"];
    
    return plistName;
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSLog(@"My token is %@", deviceToken);
}



- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSLog(@"error %@", error);
}




- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.sinaweibo applicationDidBecomeActive];
}




- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [self.sinaweibo handleOpenURL:url];
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.sinaweibo handleOpenURL:url];
}







- (SinaWeibo *)sinaWeibo:(id<SinaWeiboDelegate>)viewController
{
    if (!sinaweibo) {
        
        sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:viewController];
    }
    else {
        
        sinaweibo.delegate = viewController;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:kSinaKeyChainAccessToken] && [sinaweiboInfo objectForKey:kSinaKeyChainExpireTime] && [sinaweiboInfo objectForKey:kSinaKeyChainUserID]) {
        
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:kSinaKeyChainAccessToken];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:kSinaKeyChainExpireTime];
        sinaweibo.userID = [sinaweiboInfo objectForKey:kSinaKeyChainUserID];
    }
    
    
    return sinaweibo;
    
}




- (void)initDB
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:DBNAME];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
}



















@end

//
//  LBAppDelegate.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import <sqlite3.h>

@class LoginViewController;
@class SinaWeibo;

@interface LBAppDelegate : UIResponder <UIApplicationDelegate> {
    
    NSDictionary *dic;
    sqlite3 *db;
    
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) SinaWeibo *sinaweibo;


- (SinaWeibo *)sinaWeibo:(id<SinaWeiboDelegate>)viewController;

@end

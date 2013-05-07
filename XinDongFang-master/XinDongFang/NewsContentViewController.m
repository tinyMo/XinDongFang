//
//  NewsContentViewController.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-11.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "NewsContentViewController.h"
#import "SinaWeibo.h"
#import "LBAppDelegate.h"

@interface NewsContentViewController ()

@end

@implementation NewsContentViewController

@synthesize content;
@synthesize sinauserInfo;
@synthesize sinaStatuses;


- (id)initWitData:(NSDictionary *)data
{
    self = [super initWithNibName:@"NewsContentViewController" bundle:nil];
    
    if (self) {
        
        dataList = data;
    }
    
    return self;
}

- (IBAction)sinaAction:(id)sender {
    
    LBAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    SinaWeibo *sinaweibo = [delegate sinaWeibo:self];
    
    if ([self sinaIsValid]) {
        
        [self sinaShare:sinaweibo];
        return;
    }
    [sinaweibo logIn];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"newCenterNav.png"] forBarMetrics:UIBarMetricsDefault];
    
    
//    NSString *contentView = [dataList objectForKey:[NSString stringWithFormat:@"content"]];
//    self.content.text = contentView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50.0, 29.0);
    [btn setImage:[UIImage imageNamed:@"backItemN.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"backItemY.png"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}




- (void)backItemAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)storeAuthData
{
    LBAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    SinaWeibo *sinaWeibo = [delegate sinaWeibo:self];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:sinaWeibo.accessToken, kSinaKeyChainAccessToken, sinaWeibo.expirationDate, kSinaKeyChainExpireTime, sinaWeibo.userID, kSinaKeyChainUserID, sinaWeibo.refreshToken, kSinaKeyChainRefreshToken, nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




#pragma mark SinaWeiboDelegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{

    [self storeAuthData];
}


- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    
}



#pragma mark SinaWeiboRequestDelegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
}




- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"user/show.json"]) {
        
        self.sinauserInfo = result;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"]) {
        
        sinaStatuses = [result objectForKey:@"statuses"];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"恭喜你，信息已经成功分享到新浪微博"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道啦", nil];
        [alertView show];
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
    }
}



#pragma -mark

- (BOOL)sinaIsValid
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [user objectForKey:@"SinaWeiboAuthData"];
    
    NSString *userID = [userDic objectForKey:kSinaKeyChainUserID];
    NSString *accessToken = [userDic objectForKey:kSinaKeyChainAccessToken];
    NSDate *expireTime = [userDic objectForKey:kSinaKeyChainExpireTime];
    if ([self isAuthorizeExpired:expireTime]) {
        
        [user removeObjectForKey:@"SinaWeiboAuthData"];
    }
    
    return userID && accessToken && expireTime && ![self isAuthorizeExpired:expireTime];
    
}


- (BOOL)isAuthorizeExpired:(NSDate *)expireTime
{
    NSDate *now = [NSDate date];
    return ([now compare:expireTime] == NSOrderedDescending);
}



- (void)sinaShare:(SinaWeibo *)sinaWeibo
{
    NSString *textViewContent = self.content.text;
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                  sinaWeibo.accessToken, @"access_token",
                                                                  textViewContent, @"status" ,nil];
    
    
    [sinaWeibo requestWithURL:@"statuses/update.json" params:paramDic httpMethod:@"POST" delegate:self];
}


















@end

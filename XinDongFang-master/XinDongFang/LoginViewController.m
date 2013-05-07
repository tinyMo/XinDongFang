//
//  LBViewController.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedbackViewController.h"
#import "NewsViewController.h"
#import "SayViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize keyboardVisible;
@synthesize tabBarController;
@synthesize userName;
@synthesize code;
@synthesize isAutologon;
@synthesize isRememberPassword;
@synthesize rememberPassword;
@synthesize autologon;
@synthesize chaShang;
@synthesize chaXia;
@synthesize userPreDic;
@synthesize nameDic;

#pragma -mark lifeCircle


- (id)initWithData:(NSDictionary *)userPreferenceDic
{
    self = [super initWithNibName:@"LoginViewController" bundle:nil];
    
    if (self) {
        
        self.userPreDic = [NSMutableDictionary dictionaryWithDictionary:userPreferenceDic];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        self.nameDic = dic;
        
        isAutologon = [[userPreDic objectForKey:@"isAutologon"] boolValue];
        isRememberPassword = [[userPreDic objectForKey:@"isRememberPassword"] boolValue];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    float vision = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if (vision >= 5.0) {
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    
    
    [self performUserPreference];
    [self changeCheckView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark





- (void)keyboardShow:(NSNotification *)notification
{
    NSDictionary *infor = [notification userInfo];
    NSValue *aValue = [infor objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *durationValue = [infor objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSTimeInterval animationDuration;
    [durationValue getValue:&animationDuration];
    
    
    
    if (keyboardVisible) {
        return;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y-keyboardRect.size.height + 60)];
    }];
    
    keyboardVisible = YES;
}



- (void)keyboardHide:(NSNotification *)notification
{
    NSDictionary *infor = [notification userInfo];
    NSValue *aValue = [infor objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *durationValue = [infor objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSTimeInterval animationDuration;
    [durationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y + keyboardRect.size.height - 60)];
    }];
    
    keyboardVisible = NO;
}



- (IBAction)enter:(id)sender {
    
    NSString *userN = self.userName.text;
    NSString *cod = self.code.text;
    
    if ([userN isEqual:@""] && [cod isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入用户名和密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    NSDictionary *personList = [nameDic objectForKey:userN];
    
    if (personList != nil) {
        
        NSString *password = [personList objectForKey:@"password"];
        
        if ([password isEqualToString:cod]) {
            
            NSNumber *personNumber = [personList objectForKey:@"personnumber"];
            
            if (tabBarController == nil) {
                
                [self inittabBarController:personNumber];
            }
            
            [self refreshUserPreferencePlist];
            [self presentViewController:self.tabBarController animated:YES completion:nil];
            return;
        }
        

    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名或密码错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    
    
    


}

- (IBAction)rememberPassword:(id)sender {
    
    isRememberPassword = !isRememberPassword;
    
    [self changeCheckView];
    
}

- (IBAction)autologon:(id)sender {
    
    isAutologon = !isAutologon;
    
    [self changeCheckView];
    

}


- (void)changeCheckView
{
    if (isAutologon) {
        
        [autologon setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }
    else {
        
        [autologon setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }

    
    if (isRememberPassword) {
        
        [rememberPassword setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }
    else {
        
        [rememberPassword setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    

}




- (IBAction)chaShangAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.hidden = YES;
    
    userName.text = @"";
    
}

- (IBAction)chaXiaAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.hidden = YES;
    
    code.text = @"";
}

- (IBAction)beginEdit:(id)sender {
    
    chaShang.hidden = NO;
    
    if ([userName.text isEqual:@""]) {
        
        chaShang.hidden = YES;
    }
    
}

- (IBAction)codebeginEdit:(id)sender {
    
    chaXia.hidden = NO;
    
    if ([code.text isEqual:@""]) {
        
        chaXia.hidden = YES;
    }
}

- (IBAction)endEdit:(id)sender {
    
    [sender resignFirstResponder];
    
}





- (void)inittabBarController:(NSNumber *)personNumber
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"information" ofType:@"plist"];
    NSArray *jiaoXueFanKuiData = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *personList = [jiaoXueFanKuiData objectAtIndex:[personNumber integerValue]];
    
    
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"教学反馈" image:[UIImage imageNamed:@"1.png"] tag:0];
    FeedbackViewController *jiaoXueFanKuiVC = [[FeedbackViewController alloc] initWithData:personList];
    jiaoXueFanKuiVC.tabBarItem = item1;
    UINavigationController *jiaoXueFanKuiNav = [[UINavigationController alloc] initWithRootViewController:jiaoXueFanKuiVC];
    
    
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"新闻中心" image:[UIImage imageNamed:@"2.png"] tag:1];
    NewsViewController *newsVC = [[NewsViewController alloc] initWithNibName:@"LBNewsViewController" bundle:nil];
    newsVC.tabBarItem = item2;
    UINavigationController *newsNav = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    
    UIImage *image = [UIImage imageNamed:@"saysome.png"];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"我有话说" image:[UIImage imageNamed:@"3.png"] tag:2];
    SayViewController *sayVC = [[SayViewController alloc] initWithNibName:@"LBSayViewController" bundle:nil];
    sayVC.tabBarItem = item3;
    UINavigationController *sayNav = [[UINavigationController alloc] initWithRootViewController:sayVC];
    
    self.tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:jiaoXueFanKuiNav, newsNav, sayNav, nil];
    
}





- (void)refreshUserPreferencePlist
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"userPreference.plist"];
    
    NSNumber *isAutologoinNumber = [NSNumber numberWithBool:isAutologon];
    NSNumber *isRememberPasswordNumber = [NSNumber numberWithBool:isRememberPassword];
    
    NSString *userNamelocal = @"";
    NSString *passWordlocal = @"";
    
        
    userNamelocal = self.userName.text;
    passWordlocal = self.code.text;
        
    [userPreDic setValue:userNamelocal forKey:@"username"];
    [userPreDic setValue:passWordlocal forKey:@"password"];
    [userPreDic setValue:isAutologoinNumber forKey:@"isAutologon"];
    [userPreDic setValue:isRememberPasswordNumber forKey:@"isRememberPassword"];
        
    [userPreDic writeToFile:path atomically:YES];

}
             




- (void)performUserPreference
{
    
    
    
    if (isRememberPassword) {
        
        self.userName.text = [userPreDic objectForKey:@"username"];
        self.code.text = [userPreDic objectForKey:@"password"];
    }
    
    if (isAutologon) {
        
        self.userName.text = [userPreDic objectForKey:@"username"];
        self.code.text = [userPreDic objectForKey:@"password"];
//        [self enter:nil];
    }
}



































@end

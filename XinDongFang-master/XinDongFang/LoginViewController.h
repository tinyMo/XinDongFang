//
//  LBViewController.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController {

}

@property (nonatomic, assign) BOOL isRememberPassword;
@property (nonatomic, assign) BOOL isAutologon;

@property (nonatomic, assign) BOOL keyboardVisible;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *rememberPassword;
@property (weak, nonatomic) IBOutlet UIButton *autologon;

@property (weak, nonatomic) IBOutlet UIButton *chaShang;
@property (weak, nonatomic) IBOutlet UIButton *chaXia;

@property (nonatomic, strong) NSMutableDictionary *userPreDic;
@property (nonatomic, strong) NSDictionary *nameDic;





- (IBAction)enter:(id)sender;
- (IBAction)rememberPassword:(id)sender;
- (IBAction)autologon:(id)sender;
- (IBAction)chaShangAction:(id)sender;
- (IBAction)chaXiaAction:(id)sender;
- (IBAction)beginEdit:(id)sender;
- (IBAction)codebeginEdit:(id)sender;
- (IBAction)endEdit:(id)sender;


- (id)initWithData:(NSDictionary *)userPreferenceDic;


@end

//
//  LBSayViewController.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "SayViewController.h"

@interface SayViewController ()

@end

@implementation SayViewController

@synthesize textView;
@synthesize showBar;
@synthesize showBarsButton;
@synthesize isFirstResponder;


#pragma mark lifeCircle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textView.backgroundColor = [UIColor clearColor];
    textView.delegate = self;
    isFirstResponder = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"sayIt.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    showBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"showbarSayIt.png"]];
    showBar.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 45);
    showBar.alpha = 0.5;
    [self.view addSubview:showBar];
    
    showBarsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [showBarsButton setBackgroundImage:[UIImage imageNamed:@"okbutton.png"] forState:UIControlStateNormal];
    [showBarsButton setTitle:@"完成" forState:UIControlStateNormal];
    [showBarsButton addTarget:self action:@selector(barButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    showBarsButton.frame = CGRectMake(250, self.view.frame.size.height+6, 60, 32);
    [self.view addSubview:showBarsButton];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    float vision = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (vision >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
                                              


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [textView becomeFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma -mark




- (void)keyboardShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aVlaue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *durationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardRect = [aVlaue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSTimeInterval animationDuration;
    [durationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        
        showBar.frame = CGRectMake(showBar.frame.origin.x, keyboardRect.origin.y - showBar.frame.size.height, showBar.frame.size.width, showBar.frame.size.height);
        showBarsButton.frame = CGRectMake(showBarsButton.frame.origin.x, keyboardRect.origin.y - showBar.frame.size.height + 6 , showBarsButton.frame.size.width, showBarsButton.frame.size.height);
    }];
    
}



- (void)keyboardHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aVlaue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *durationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect keyboardRect = [aVlaue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSTimeInterval animationDuration;
    [durationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        
        showBar.frame = CGRectMake(showBar.frame.origin.x, keyboardRect.origin.y + keyboardRect.size.height, showBar.frame.size.width, showBar.frame.size.height);
        showBarsButton.frame = CGRectMake(showBarsButton.frame.origin.x, keyboardRect.origin.y + keyboardRect.size.height + 6, showBarsButton.frame.size.width, showBarsButton.frame.size.height);
    }];
}





- (void)textViewDidBeginEditing:(UITextView *)textView
{
    

}



static NSInteger yPlus = 240;
- (void)barButtonAction:(id)sender
{
    [self.textView resignFirstResponder];
    isFirstResponder = NO;
    

    
    yPlus = 240;
}




- (void)gofirstResponder
{
    [self.textView becomeFirstResponder];
    isFirstResponder = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [showBarsButton setCenter:CGPointMake(showBarsButton.center.x, showBarsButton.center.y - yPlus)];
        [showBar setCenter:CGPointMake(showBar.center.x, showBar.center.y - yPlus)];
    }];
}




                                

- (IBAction)senderAction:(id)sender {
    
    if ([textView.text isEqual:@""]) {
        
        UIAlertView *alertkong = [[UIAlertView alloc] initWithTitle:@"消息不能空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertkong show];
        return;
        
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已发送" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    self.textView.text = @"";
    
    [alert show];
}
























@end

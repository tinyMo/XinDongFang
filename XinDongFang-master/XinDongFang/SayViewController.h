//
//  LBSayViewController.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SayViewController : UIViewController<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIImageView *showBar;
@property (strong, nonatomic) UIButton *showBarsButton;

@property (nonatomic, assign) BOOL isFirstResponder;

- (IBAction)senderAction:(id)sender;
@end

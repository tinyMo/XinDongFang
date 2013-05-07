//
//  headsectionCell.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-25.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FeedbackViewController;
@interface HeadsectionCell : UITableViewCell

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong)FeedbackViewController *jiaoxuefankuiVC;




- (IBAction)cellbuttonAction:(id)sender;

@end

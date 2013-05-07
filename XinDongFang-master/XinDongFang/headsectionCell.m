//
//  headsectionCell.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-25.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "HeadsectionCell.h"
#import "FeedbackViewController.h"

@implementation HeadsectionCell

@synthesize jiaoxuefankuiVC;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (IBAction)cellbuttonAction:(id)sender {
    
    [jiaoxuefankuiVC checkBtnCondition:_number];
}
@end

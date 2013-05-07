//
//  strView.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-12.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "strView.h"

@implementation strView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    UIColor *manageColor = [UIColor blueColor];
    [manageColor set];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:26.0];
    
    NSString *str = @"反馈确认发送中";
    
    [str drawAtPoint:CGPointMake(0, 0) withFont:font];
    
    
}


@end

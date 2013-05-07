//
//  NewsContentViewController.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-11.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"




@interface NewsContentViewController : UIViewController <SinaWeiboDelegate, SinaWeiboRequestDelegate>  {
    
    NSDictionary *dataList;
    
}

@property (weak, nonatomic) IBOutlet UITextView *content;


@property (strong, nonatomic) NSDictionary *sinauserInfo;
@property (strong, nonatomic) NSArray *sinaStatuses;



- (id)initWitData:(NSArray *)data;
- (IBAction)sinaAction:(id)sender;

@end

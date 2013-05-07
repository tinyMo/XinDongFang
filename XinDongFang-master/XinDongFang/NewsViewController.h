//
//  LBNewsViewController.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface NewsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    
    sqlite3 *db;
}

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@property (nonatomic, strong) NSArray *dataList;


@end

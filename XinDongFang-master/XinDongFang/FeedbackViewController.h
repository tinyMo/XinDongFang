//
//  LBJiaoXueFanKuiViewController.h
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HZActivityIndicatorView;
@interface FeedbackViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *dataDictionary;
    
    NSArray *tableViewData;
}
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *headersectionbtn;


@property (weak, nonatomic) IBOutlet UILabel *yearlabel;
@property (weak, nonatomic) IBOutlet UILabel *studentlabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UILabel *placelabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherlabel;
@property (weak, nonatomic) IBOutlet UILabel *classlabel;

@property (weak, nonatomic) IBOutlet UIButton *classCheckNormal;
@property (weak, nonatomic) IBOutlet UIButton *classCheckGood;
@property (weak, nonatomic) IBOutlet UIButton *classCheckExcellent;
@property (weak, nonatomic) IBOutlet UIButton *lastHomeworkNormal;
@property (weak, nonatomic) IBOutlet UIButton *lastHomewrokGood;
@property (weak, nonatomic) IBOutlet UIButton *lastHomeworkExcellent;
@property (weak, nonatomic) IBOutlet UIButton *timePoint5;
@property (weak, nonatomic) IBOutlet UIButton *time1;
@property (weak, nonatomic) IBOutlet UIButton *time1point5;

@property (nonatomic, assign) BOOL isbeSure;
@property (nonatomic, strong) UIButton *pressButton;

@property (nonatomic, strong) NSDictionary *tableViewCellDic;
@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (strong, nonatomic) IBOutlet UITableView *midTableView;
@property (nonatomic, strong) NSArray *classCheckArray;
@property (nonatomic, strong) NSArray *lastHomeworkArray;
@property (nonatomic, strong) NSArray *timeArray;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, strong) UIButton *checkButtonClass;
@property (nonatomic, strong) UIButton *checkButtonHomework;
@property (nonatomic, strong) UIButton *checkButtonWorktime;

@property (nonatomic, strong) NSMutableArray *animationView;

@property (nonatomic, strong) NSMutableDictionary *isOpenDictionary;
@property (nonatomic, strong) NSMutableArray *sectionHeaderArray;


- (IBAction)checkButtonPress:(id)sender;
- (IBAction)classCheck:(id)sender;
- (IBAction)homework:(id)sender;
- (IBAction)worktimeCheck:(id)sender;
- (IBAction)headsectionAction:(id)sender;

- (id)initWithData:(NSDictionary *)dataInformation;
- (void)checkBtnCondition:(NSInteger)section;



@end
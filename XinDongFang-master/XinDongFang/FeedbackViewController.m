//
//  LBJiaoXueFanKuiViewController.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackCell.h"
#import "HZActivityIndicatorView.h"
#import "HZActivityIndicatorSubclassExample.h"
#import "strView.h"
#import "HeadsectionCell.h"
#import "ODRefreshControl.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

@synthesize tableViewCellDic;
@synthesize imageViewArray;
@synthesize titleArray;
@synthesize selectIndexPath;
@synthesize midTableView;
@synthesize checkButtonClass;
@synthesize checkButtonHomework;
@synthesize checkButtonWorktime;
@synthesize animationView;
@synthesize isbeSure;
@synthesize pressButton;
@synthesize yearlabel, studentlabel, datelabel, placelabel, teacherlabel, classlabel;
@synthesize classCheckNormal, classCheckGood, classCheckExcellent, lastHomeworkNormal, lastHomewrokGood, lastHomeworkExcellent, timePoint5, time1, time1point5;
@synthesize lastHomeworkArray, timeArray, classCheckArray;
@synthesize checkButton;
@synthesize isOpenDictionary;
@synthesize headersectionbtn;
@synthesize sectionHeaderArray;


#pragma -mark lifeCircle


- (id)initWithData:(NSDictionary *)dataInformation
{
    
    
    self = [super initWithNibName:@"FeedbackViewController" bundle:nil];
    if (self) {
        dataDictionary = dataInformation;
        
        
        NSString *tableViewDataPathList = [[NSBundle mainBundle] pathForResource:@"feedbackTableList" ofType:@"plist"];
        tableViewData = [NSArray arrayWithContentsOfFile:tableViewDataPathList];
        
        
        imageViewArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"classcontent.png"], [UIImage imageNamed:@"feedback.png"], [UIImage imageNamed:@"thishomework"], nil];
        titleArray = [NSArray arrayWithObjects:@"课程内容", @"反馈评价", @"本次作业", nil];
        
        
        isbeSure = NO;
        
        isOpenDictionary = [[NSMutableDictionary alloc] init];
        [isOpenDictionary setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"section0"]];
        [isOpenDictionary setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"section1"]];
        [isOpenDictionary setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"section2"]];
        
        sectionHeaderArray = [[NSMutableArray alloc] initWithObjects:@" ", @" ", @" ", nil];
        
}
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar"]forBarMetrics:UIBarMetricsDefault];
    self.midTableView.backgroundColor = [UIColor clearColor];
    

    yearlabel.text = [dataDictionary objectForKey:@"year"];
    studentlabel.text = [dataDictionary objectForKey:@"name"];
    datelabel.text = [dataDictionary objectForKey:@"date"];
    placelabel.text = [dataDictionary objectForKey:@"place"];
    teacherlabel.text = [dataDictionary objectForKey:@"teacher"];
    classlabel.text = [dataDictionary objectForKey:@"class"];
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.midTableView];
    [refreshControl addTarget:self action:@selector(dropTableViewBeginRefresh:) forControlEvents:UIControlEventValueChanged];
    [refreshControl setMaxDistance:18.0];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}




#pragma -mark


#pragma -mark tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableViewData count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL checkCross = [[isOpenDictionary objectForKey:[NSString stringWithFormat:@"section%d", section]] boolValue];
    
    if (checkCross) {
        
        return [[tableViewData objectAtIndex:section] count];
    }
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        static NSString *backContentCellIdentifier = @"backContentCellIdentifier";
        static BOOL backCellIsRegisted = NO;
        if (!backCellIsRegisted) {
            
            UINib *backCellNib = [UINib nibWithNibName:@"backContentCell" bundle:nil];
            [tableView registerNib:backCellNib forCellReuseIdentifier:backContentCellIdentifier];
            backCellIsRegisted = YES;
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backContentCellIdentifier];
        
        return cell;
        
    }

    
    
    
    static NSString *cellIdentifier = @"jiaoXueFanKuiCellIdentifier";
    static BOOL isRegisted = NO;
    if (!isRegisted) {
        
        UINib *nib = [UINib nibWithNibName:@"jiaoXueFanKuiCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        isRegisted = YES;
    }
    
    FeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
    NSString *context = [[tableViewData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.customlabel.text = context;
    cell.customlabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.customlabel.numberOfLines = 0;
    cell.customlabel.font = font;
    
    
    
    
    return cell;
    
}





#pragma -mark tableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    HeadsectionCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"headsectionView" owner:self options:nil] objectAtIndex:0];
    self.headersectionbtn.tag = section;
    

    
    cell.imageView.image = [imageViewArray objectAtIndex:section];
    cell.textLabel.text = [titleArray objectAtIndex:section];
    cell.textLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    
    BOOL isOpen = [[isOpenDictionary objectForKey:[NSString stringWithFormat:@"section%d", section]] boolValue];
    cell.accessoryView = isOpen?[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowD.png"]]:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowR.png"]];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.number = section;
    cell.jiaoxuefankuiVC = self;
    
    [sectionHeaderArray replaceObjectAtIndex:section withObject:cell];
    
    
    return cell;
    
    
    
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        return 160;
    }
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
    
    NSString *content = [[tableViewData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    return size.height + 20;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}











- (IBAction)checkButtonPress:(id)sender {
    
    self.pressButton = (UIButton *)sender;
    
    if (animationView == nil) {
        
        animationView = [[NSMutableArray alloc] init];
    }
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 507)];
    backView.backgroundColor = [UIColor grayColor];
    backView.alpha = 0.6;
    [self.view addSubview:backView];
    [animationView addObject:backView];
    
    
    
    HZActivityIndicatorView *activityIndicator;
    activityIndicator = [[HZActivityIndicatorSubclassExample alloc] initWithFrame:CGRectMake(140, 150, 0, 0)];
    activityIndicator.backgroundColor = self.view.backgroundColor;
    activityIndicator.opaque = YES;
    activityIndicator.steps = 8;
    activityIndicator.finSize = CGSizeMake(20, 10);
    activityIndicator.indicatorRadius = 10;
    activityIndicator.stepDuration = 0.0570;
    activityIndicator.roundedCoreners = UIRectCornerAllCorners;
    activityIndicator.cornerRadii = CGSizeMake(4, 4);
    activityIndicator.color = [UIColor darkGrayColor];
    activityIndicator.backgroundColor = [UIColor clearColor];
    activityIndicator.direction = HZActivityIndicatorDirectionCounterClockwise;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    [animationView addObject:activityIndicator];

    
    [self performSelector:@selector(stopAnimation:) withObject:sender afterDelay:2.0];
    
}


- (void)stopAnimation:(id)sender
{
    for (UIView *view in animationView) {
        [view removeFromSuperview];
    }
    
    [animationView removeAllObjects];
    
    self.pressButton.enabled = NO;
    [self.pressButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.isbeSure = YES;
}






//headsection insert  >>



- (IBAction)headsectionAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    [self checkBtnCondition:btn.tag];
    
//    [self.midTableView reloadData];
}




- (void)checkBtnCondition:(NSInteger)section
{
    HeadsectionCell *cell = (HeadsectionCell *)[sectionHeaderArray objectAtIndex:section];
    
    
    NSNumber *conditionNumber = [isOpenDictionary objectForKey:[NSString stringWithFormat:@"section%d", section]];
    BOOL condition = [conditionNumber boolValue];
    
    NSInteger rows = [[tableViewData objectAtIndex:section] count];
    NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    while (i < rows) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPathArray addObject:indexPath];
        i++;
    }
    
    
    if (condition) {
        
        [isOpenDictionary setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"section%d", section]];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowR.png"]];
        
    }
    else {

        [isOpenDictionary setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"section%d", section]];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowD.png"]];
    }
    
    
    
    [self.midTableView beginUpdates];
    
    if (condition) {
        
        [self.midTableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
    }
    else {
        
        [self.midTableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.midTableView endUpdates];
    
}


//<<



- (void)checkBoxCheck
{
    classCheckArray = [NSArray arrayWithObjects:classCheckNormal, classCheckGood, classCheckExcellent, nil];
    lastHomeworkArray = [NSArray arrayWithObjects:lastHomeworkNormal, lastHomewrokGood, lastHomeworkExcellent, nil];
    timeArray = [NSArray arrayWithObjects:timePoint5, time1, time1point5, nil];
    
    
    NSArray *checkBoxArray = [dataDictionary objectForKey:@"feedbackinformation"];
    
    NSInteger num = [[checkBoxArray objectAtIndex:0] integerValue];
    UIButton *classBtn = [classCheckArray objectAtIndex:num];
    
    
    [classBtn setImage:[UIImage imageNamed:@"checkboxon.png"] forState:UIControlStateNormal];
    
    UIButton *lastHomeworkBtn = [lastHomeworkArray objectAtIndex:[[checkBoxArray objectAtIndex:1] integerValue]];
    [lastHomeworkBtn setImage:[UIImage imageNamed:@"checkboxon.png"] forState:UIControlStateNormal];
    
    UIButton *timeBtn = [timeArray objectAtIndex:[[checkBoxArray objectAtIndex:2] integerValue]];
    [timeBtn setImage:[UIImage imageNamed:@"checkboxon.png"] forState:UIControlStateNormal];
}





- (void)dropTableViewBeginRefresh:(ODRefreshControl *)odRefreshControl
{
    double delaySeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [odRefreshControl endRefreshing];
    });

}






















@end

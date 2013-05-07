//
//  LBNewsViewController.m
//  XinDongFang
//
//  Created by 楼 彬 on 13-4-10.
//  Copyright (c) 2013年 楼 彬. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsContentViewController.h"
#import "ODRefreshControl.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize newsTableView;
@synthesize dataList;


#pragma mark lifeCircle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"plist"];
        dataList = [[NSArray alloc] initWithContentsOfFile:path];
    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"newCenterNav.png"] forBarMetrics:UIBarMetricsDefault];
    ODRefreshControl *odRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.newsTableView];
    [odRefreshControl addTarget:self action:@selector(dropTableViewBeginRefresh:) forControlEvents:UIControlEventValueChanged];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark




#pragma mark tableviewdatasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsIdentifier = @"NewsTableViewCellIdentifier";
    static BOOL isRegisted = NO;
    if (!isRegisted) {
        
        UINib *nib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:newsIdentifier];
        isRegisted = YES;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsIdentifier];
    
    NSDictionary *dic = [dataList objectAtIndex:indexPath.row];
    NSString *contenttitle = [dic objectForKey:[NSString stringWithFormat:@"title"]];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.textLabel.font = font;
    cell.textLabel.text = contenttitle;
    
    return cell;
}


#pragma -mark 



#pragma mark tableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 2) {
        
        NSDictionary *dic = [dataList objectAtIndex:indexPath.row];
        
        NewsContentViewController *newsContentController = [[NewsContentViewController alloc] initWitData:dic];
        [self.navigationController pushViewController:newsContentController animated:YES];
    }
    
    
}



#pragma -mark



- (void)dropTableViewBeginRefresh:(ODRefreshControl *)odRefreshControl
{
    double delaySeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [odRefreshControl endRefreshing];
    });
}












@end

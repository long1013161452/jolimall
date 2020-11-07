//
//  XZZRepairOrderListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRepairOrderListViewController.h"

#import "XZZRepairOrderDetailsViewController.h"

#import "ZZFeedbackListTableViewCell.h"

#import "XZZMyTicketsListIsEmptyTableViewCell.h"

@interface XZZRepairOrderListViewController ()<UITableViewDataSource, UITableViewDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * dataArray;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int page;

@end

@implementation XZZRepairOrderListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"My Tickets";
    self.nameVC = @"工单列表";
    
    [XZZBuriedPoint SupportPerson:2];
    
    WS(wSelf)
    self.tableView = [UITableView allocInit];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = kColor(0xf2f2f2);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
    self.dataArray = @[].mutableCopy;
    [self.tableView addLoading:self refreshingAction:@selector(dataDownload)];
    self.page = 0;
    [self dataDownload];
    
}



- (void)dataDownload
{
    WS(wSelf)
    wSelf.page++;
    [XZZDataDownload userGetFeedbackListPage:self.page httpBlock:^(id data, BOOL successful, NSError *error) {
        if (wSelf.page == 1) {
            [wSelf.dataArray removeAllObjects];
        }
        [wSelf.dataArray addObjectsFromArray:data];
        [wSelf.tableView reloadData];
        [wSelf.tableView endRefreshing];
    }];
    
    return;

    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCJwt alloc] initWithToken:User_Infor.email];
    
    [[ZDKZendesk instance] setIdentity:userIdentity];
    ZDKRequestProvider * provider = [ZDKRequestProvider new];
    [provider getAllRequestsWithCallback:^(ZDKRequestsWithCommentingAgents *requestsWithCommentingAgents, NSError *error) {
        
        wSelf.dataArray = requestsWithCommentingAgents.requests;
        [wSelf.tableView reloadData];
        
    }];

}


- (void)checkWorkOrderDetails:(NSString *)requestId
{
    XZZRepairOrderDetailsViewController * repairOrderDetailsVC = [XZZRepairOrderDetailsViewController allocInit];
    repairOrderDetailsVC.requestId = requestId;
    [self pushViewController:repairOrderDetailsVC animated:YES];
}


#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count > 0 ? self.dataArray.count : 1;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count > 0) {
    ZZFeedbackListTableViewCell * cell = [ZZFeedbackListTableViewCell codeCellWithTableView:tableView];
    cell.feedback = self.dataArray[indexPath.row];
    return cell;
    }
    
    XZZMyTicketsListIsEmptyTableViewCell * cell = [XZZMyTicketsListIsEmptyTableViewCell codeCellWithTableView:tableView];
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
    
}
#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (self.dataArray.count > 0) {
        
        
        XZZFeedback * feedback = self.dataArray[indexPath.row];
        
        [self checkWorkOrderDetails:feedback.tokenId];
    }
}
#pragma mark ----- tableView代理结束



@end

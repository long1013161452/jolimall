//
//  XZZOrderListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderListViewController.h"
#import "XZZOrderDetailsViewController.h"
#import "XZZOrderIsEmptyTableViewCell.h"
#import "XZZOrderListTableViewCell.h"

#import "XZZPayResultsViewController.h"

@interface XZZOrderListViewController ()<UITableViewDelegate, UITableViewDataSource, XZZMyDelegate>

/**
 * tableview
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int page;

/**
 * 订单列表信息
 */
@property (nonatomic, strong)NSMutableArray * orderListArray;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL isEmpty;

@end

@implementation XZZOrderListViewController

- (void)back
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = self.navigationController.viewControllers.count > 2 ? YES : NO;
    [self refreshData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Orders";
    self.nameVC = @"订单列表";
    self.isEmpty = NO;

    WS(wSelf)
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    self.orderListArray = @[].mutableCopy;
    [self.tableView addRefresh:self refreshingAction:@selector(refreshData)];
    [self.tableView addLoading:self refreshingAction:@selector(downloadData)];
    
    
    loadView(self.view)
    
}

#pragma mark ----更新数据
- (void)refreshData
{
    self.page = 0;
    [self downloadData];
}
#pragma mark ----下载数据
- (void)downloadData
{
    WS(wSelf)
    self.page++;
    [XZZDataDownload orderGetOrderListPage:self.page httpBlock:^(id data, BOOL successful, NSError *error) {
        wSelf.isEmpty = YES;
        loadViewStop
        if (successful) {
            if (wSelf.page == 1) {
                [wSelf.orderListArray removeAllObjects];
            }
            [wSelf.orderListArray addObjectsFromArray:data];
        }
        [wSelf.tableView reloadData];
        [wSelf.tableView endRefreshing];
    }];
}
#pragma mark ---- *  进入订单详情
/**
 *  进入订单详情
 */
- (void)enterOrderDetails:(NSString *)orderId
{
    XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
    orderDetailsVC.orderID = orderId;
    [self pushViewController:orderDetailsVC animated:YES];
}

#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orderListArray.count > 0 ? self.orderListArray.count : self.isEmpty;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderListArray.count <= 0) {
        XZZOrderIsEmptyTableViewCell * cell = [XZZOrderIsEmptyTableViewCell codeCellWithTableView:tableView];
        [cell addView];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    XZZOrderListTableViewCell * cell = [XZZOrderListTableViewCell codeCellWithTableView:tableView];
    cell.orderList = self.orderListArray[indexPath.section];
    cell.delegate = self;
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderListArray.count <= 0) {
        return 226;
    }
    return [XZZOrderListTableViewCell calculateHeight:self.orderListArray[indexPath.section]];
}
#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = BACK_COLOR;
    return view;
}

#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[XZZOrderListTableViewCell class]]) {
        XZZOrderListTableViewCell * cell2 = (XZZOrderListTableViewCell *)cell;
        
        [self enterOrderDetails:cell2.orderList.orderId];
    }
    
}
#pragma mark ----- tableView代理结束

@end

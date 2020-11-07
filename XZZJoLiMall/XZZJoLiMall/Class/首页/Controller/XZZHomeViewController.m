//
//  XZZHomeViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHomeViewController.h"

#import "XZZSearchViewController.h"

#import "XZZHomeViewModel.h"
#import "XZZGoodsListViewModel.h"

@interface XZZHomeViewController ()<XZZMyDelegate>

/**
 * tableView
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * 首页mvvm
 */
@property (nonatomic, strong)XZZHomeViewModel * homeViewModel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModel;
/**
 * 弹出加购框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addToCartBuyNewViewModel;

@end

@implementation XZZHomeViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:kColor(0xF41C19)}];
    
    if (self.homeViewModel.tableHeardArray.count == 0) {
        [self.homeViewModel updateData];
    }
    
}

- (void)goSearchPage
{
    [self pushViewController:[XZZSearchViewController allocInit] animated:YES];
}

- (void)BackTop
{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)myiskol
{
//    if (my_AppDelegate.iskol) {
        [self addChatAndActivityFloatWindow];
//    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myiskol) name:@"myiskol" object:nil];


    NSLog(@"~~~~~~~`%@", font_bold_16);
    NSLog(@"~~~~~~~`%@", font_16);

    
    
    self.myTitle = @"Jolimall";
    self.nameVC = @"首页";
    
    UIButton * searchButton = [UIButton allocInitWithFrame:CGRectMake(0, 0, 50, 40)];
    [searchButton setImage:imageName(@"home_search") forState:(UIControlStateNormal)];
    [searchButton setImage:imageName(@"home_search") forState:(UIControlStateHighlighted)];
    searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);//
    [searchButton addTarget:self action:@selector(goSearchPage) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    WS(wSelf)
    /*** 创建tableview视图 */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 00, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self.goodsListViewModel;
    self.tableView.dataSource = self.goodsListViewModel;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView addRefresh:self.homeViewModel refreshingAction:@selector(updateData)];
    [self.tableView addLoading:self.homeViewModel refreshingAction:@selector(dataDownload)];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
    loadView(self.view)


    
    [self addChatAndActivityFloatWindow];
    
}


- (XZZHomeViewModel *)homeViewModel
{
    if (!_homeViewModel) {
        XZZHomeViewModel * homeViewModel = [XZZHomeViewModel allocInit];
        homeViewModel.VC = self;
        WS(wSelf)
        [homeViewModel setReloadData:^{
            loadViewStop
            wSelf.goodsListViewModel.tableHeardArray = wSelf.homeViewModel.tableHeardArray;
            wSelf.goodsListViewModel.goodsArray = wSelf.homeViewModel.goodsArray;
            [wSelf.tableView reloadData];
            [wSelf.tableView endRefreshing];
        }];
//        [homeViewModel updateData];
        self.homeViewModel = homeViewModel;
    }
    return _homeViewModel;
}

- (XZZAddCartAndBuyNewViewModel *)addToCartBuyNewViewModel
{
    if (!_addToCartBuyNewViewModel) {
        XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel = [XZZAddCartAndBuyNewViewModel allocInit];
        addCartAndBuyNewViewModel.VC = self;
        self.addToCartBuyNewViewModel = addCartAndBuyNewViewModel;
    }
    return _addToCartBuyNewViewModel;
}

- (XZZGoodsListViewModel *)goodsListViewModel
{
    if (!_goodsListViewModel) {
        WS(wSelf)
        self.goodsListViewModel = [XZZGoodsListViewModel allocInit];
        _goodsListViewModel.hideEmpty = YES;
        _goodsListViewModel.VC = self;
        _goodsListViewModel.goods_list_count = 2;
        [_goodsListViewModel setReloadData:^{
            [wSelf.tableView reloadData];
        }];
    }
    return _goodsListViewModel;
}








@end

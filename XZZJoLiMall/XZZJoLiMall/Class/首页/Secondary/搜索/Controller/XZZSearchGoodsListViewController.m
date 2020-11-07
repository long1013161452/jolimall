//
//  XZZSearchGoodsListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSearchGoodsListViewController.h"
#import "XZZFilteringAndSortingView.h"
#import "XZZGoodsListViewModel.h"
///***  列表一排几个商品 */
//#define goods_list_count 2

@interface XZZSearchGoodsListViewController ()<UITextFieldDelegate, XZZMyDelegate>

/**
 * 输入框
 */
@property (nonatomic, strong)UITextField * textField;

/**
 * 请求信息
 */
@property (nonatomic, strong)XZZRequestSearch * requestSearch;

/**
 * tableview
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray * goodsArray;

/**
 * 弹出加购框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addToCartBuyNewViewModel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModel;

@end

@implementation XZZSearchGoodsListViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameVC = @"搜索商品";
    
    [self setNavigationBar];
    
    self.textField.text = self.searchContent;
    
    
    WS(wSelf)
    
    XZZFilteringAndSortingView * sortingView = [XZZFilteringAndSortingView allocInit];
    sortingView.hiddenFilter = YES;
    sortingView.sortingArray = @[@"New Arrivals", @"Recommend", @"Low price", @"High price"];
    [sortingView addView];
    sortingView.selectedSorting = @"New Arrivals";
    [sortingView setSelectionSort:^(NSInteger index) {
        switch (index) {
            case 0:{//最新
                wSelf.requestSearch.orderBy = 1;
            }
                break;
            case 1:{//销量
                wSelf.requestSearch.orderBy = 2;
            }
                break;
            case 2:{//价格高到低
                wSelf.requestSearch.orderBy = 3;
            }
                break;
            case 3:{//价格低到高
                wSelf.requestSearch.orderBy = 4;
            }
                break;
                
            default:
                wSelf.requestSearch.orderBy = 0;
                break;
        }
        [wSelf updateData];
    }];
    [self.view addSubview:sortingView];
    [sortingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
        make.height.equalTo(@40);
    }];
    weakView(weak_sortingView, sortingView)
    self.tableView = [UITableView allocInit];
    self.tableView.dataSource = self.goodsListViewModel;
    self.tableView.delegate = self.goodsListViewModel;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    [self.view addSubview:self.tableView];
    [self.tableView addRefresh:self refreshingAction:@selector(updateData)];
    [self.tableView addLoading:self refreshingAction:@selector(dataDownload)];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.top.equalTo(weak_sortingView.mas_bottom);
    }];
    self.goodsArray = [NSMutableArray array];
    [self updateData];
}

#pragma mark ----*  设置导航栏
/**
 *  设置导航栏
 */
- (void)setNavigationBar
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    UIButton * leftButton = [UIButton allocInitWithImageName:@"nav_back" selectedImageName:@"nav_back"];
    leftButton.frame = CGRectMake(0, 0, 30, 40);
    [leftButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth - 30, 35)];
    backView.backgroundColor = BACK_COLOR;
    self.navigationItem.titleView = backView;
    
    FLAnimatedImageView * searchImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(10, 0, 15, 15) imageName:@"search_search"];
    searchImageView.centerY = backView.height / 2.0;
    [backView addSubview:searchImageView];
    
    self.textField = [UITextField allocInitWithFrame:CGRectMake(searchImageView.right + 10, 0, backView.width - (searchImageView.right + 10) - 40, backView.height)];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.delegate = self;
    self.textField.placeholder = @"type something";
    [backView addSubview:self.textField];
    
    
    
}

- (XZZRequestSearch *)requestSearch
{
    if (!_requestSearch) {
        self.requestSearch = [XZZRequestSearch allocInit];
        _requestSearch.pageNum = 0;
        _requestSearch.pageSize = 20;
        _requestSearch.orderBy = 1;
    }
    return _requestSearch;
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

- (void)setSearchContent:(NSString *)searchContent
{
    _searchContent = searchContent;
    self.requestSearch.query = searchContent;
}

- (void)updateData
{
    self.requestSearch.pageNum = 0;
    [self dataDownload];
    !self.selectionSearchContent?:self.selectionSearchContent(self.searchContent);
}

- (void)dataDownload
{
    self.requestSearch.pageNum++;
    WS(wSelf)
    [XZZDataDownload searchGetSearchGoods:self.requestSearch httpBlock:^(id data, BOOL successful, NSError *error) {
        if (wSelf.requestSearch.pageNum == 1) {
            [wSelf.goodsArray removeAllObjects];
        }
        if (successful) {
            [wSelf.goodsArray addObjectsFromArray:data];
        }else{
            wSelf.requestSearch.pageNum--;
        }
        wSelf.goodsListViewModel.hideEmpty = NO;
        wSelf.goodsListViewModel.goodsArray = wSelf.goodsArray;
        [wSelf.tableView reloadData];
        [wSelf.tableView endRefreshing];
    }];
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

#pragma mark ----*  textField Return键调用方法
/**
 *  textField Return键调用方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * searchContent = [textField.text removeForeAndAftSpaces];

    if (searchContent.length) {
        [textField resignFirstResponder];//取消第一响应者
        self.searchContent = searchContent;
        [self updateData];
    }else{
        self.textField.text = @"";
        SVProgressError(@"Please enter search content!")
    }
    return YES;
}

@end

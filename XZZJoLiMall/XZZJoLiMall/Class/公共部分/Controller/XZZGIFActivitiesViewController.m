//
//  XZZGIFActivitiesViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGIFActivitiesViewController.h"

#import "XZZGoodsListViewModel.h"

@interface XZZGIFActivitiesViewController ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModel;

@end

@implementation XZZGIFActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Why Jolimall";
    
    WS(wSelf)
    /*** 创建tableview视图 */
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 00, 0) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self.goodsListViewModel;
    self.tableView.dataSource = self.goodsListViewModel;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    [self.view addSubview:self.tableView];

    [self downloadCategoryGoods];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
        UIImageView * imageView2 = [UIImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 375.0 * 193) imageName:@"home_gif_activity_two"];
    
    self.tableView.tableFooterView = imageView2;
    
}

- (XZZGoodsListViewModel *)goodsListViewModel
{
    if (!_goodsListViewModel) {
        WS(wSelf)
        self.goodsListViewModel = [XZZGoodsListViewModel allocInit];
        _goodsListViewModel.hideEmpty = YES;
        _goodsListViewModel.VC = self;
        _goodsListViewModel.goods_list_count = 2;
        _goodsListViewModel.tableHeardArray = self.tableHeadViewArray;
//        _goodsListViewModel.tableHeardArray
        [_goodsListViewModel setReloadData:^{
            [wSelf.tableView reloadData];
        }];
    }
    return _goodsListViewModel;
}

- (NSArray *)tableHeadViewArray
{
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 375.0 * 751) imageName:@"home_gif_activity_one"];
    

    return @[imageView];
}

- (void)downloadCategoryGoods
{
    loadView(self.view)
    XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
    categoryGoods.orderBy = 2;
    categoryGoods.pageSize = 6;
    categoryGoods.pageNum = 1;
    categoryGoods.categoryId = 0;
    WS(wSelf)
    [XZZDataDownload goodsGetCategoryGoods:categoryGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {

            wSelf.goodsListViewModel.goodsArray = data;
            [wSelf.tableView reloadData];
        }else{

        }
    }];
    
}



@end

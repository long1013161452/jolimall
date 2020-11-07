//
//  XZZGoodsListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsListViewController.h"

#import "XZZFilteringAndSortingView.h"
#import "XZZFilterView.h"

#import "XZZActivityCountdownGoodsListHeaderView.h"

#import "XZZFilterModel.h"
#import "XZZGoodsListViewModel.h"

#import "XZZCartViewController.h"

#import "XZZActivityInfor.h"

@interface XZZGoodsListViewController ()<XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, assign)int count;
/**
 * 列表
 */
@property (nonatomic, strong)UITableView * tableView;

///**
// * 活动的区头信息
// */
//@property (nonatomic, strong)UIView * activityTableHeaderView;
/**
 * 活动的区头信息
 */
@property (nonatomic, strong)FLAnimatedImageView * activityImageView;
/**
 * 区头
 */
@property (nonatomic, strong)XZZFilteringAndSortingView * tableHeaderView;

/**
 * 筛选
 */
@property (nonatomic, strong)XZZFilterView * filterView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModel;

/**
 * 数据源
 */
@property (nonatomic, strong)NSMutableArray * goodsArray;

/**
 * 弹出加购框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addToCartBuyNewViewModel;
/**
 * 展示购物车里面的数量信息
 */
@property (nonatomic, strong)UILabel * numberLabel;

/**
 * 活动
 */
@property (nonatomic, strong)XZZRequestActivityGoods * activityGoods;
/**
 * 优惠券
 */
@property (nonatomic, strong)XZZRequestCouponGoods * couponsGoods;

/**
 * 活动信息
 */
@property (nonatomic, strong)XZZActivityInfor * activityInfor;

/**
 * 活动信息视图
 */
@property (nonatomic, strong)XZZActivityCountdownGoodsListHeaderView * activityView;

@end

@implementation XZZGoodsListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.count = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartQuantity) name:@"numberShoppingCartsHasChanged" object:nil];

    [self.tableView reloadData];
    [self shoppingCartQuantity];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)back
{
    [super back];
    [self.tableHeaderView hiddenSortView];
}

- (XZZGoodsListViewModel *)goodsListViewModel
{
    if (!_goodsListViewModel) {
        WS(wSelf)
        self.goodsListViewModel = [XZZGoodsListViewModel allocInit];
        if (self.activityId) {
            _goodsListViewModel.goodsViewDisplay = XZZGoodsViewDisplayActivityGoodsList;
        }
        _goodsListViewModel.VC = self;
        _goodsListViewModel.hideEmpty = YES;
        _goodsListViewModel.goods_list_count = 2;
        if (self.activityId || self.couponsId) {
        }else{
            _goodsListViewModel.tableHeardArray = @[self.tableHeaderView];
        }
        [_goodsListViewModel setReloadData:^{
            [wSelf.tableView reloadData];
        }];
    }
    return _goodsListViewModel;
}

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        self.goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (XZZRequestActivityGoods *)activityGoods
{
    if (!_activityGoods) {
        
        self.activityGoods = [XZZRequestActivityGoods allocInit];
        _activityGoods.activityId = self.activityId;
    }
    return _activityGoods;
}

- (XZZRequestCouponGoods *)couponsGoods
{
    if (!_couponsGoods) {
        
        self.couponsGoods = [XZZRequestCouponGoods allocInit];
        _couponsGoods.couponId = self.couponsId;
    }
    return _couponsGoods;
}

- (void)setActivityInfor:(XZZActivityInfor *)activityInfor
{
    _activityInfor = activityInfor;
    self.activityView.activityInfor = activityInfor;
    NSString * imageUrl = activityInfor.bannerPicture;
    
    WS(wSelf)
    if ([imageUrl containsString:@"*"]) {
        CGFloat imageWidth = 0;
        CGFloat imageHeight = 0;
        
        NSArray * array = [imageUrl componentsSeparatedByString:@"_"];
        NSString * str = [array lastObject];
        if ([str containsString:@"*"]) {
            array = [str componentsSeparatedByString:@"."];
            str = [array firstObject];
            array = [str componentsSeparatedByString:@"*"];
            if (array.count > 0) {
                imageWidth = [[array firstObject] floatValue];
                imageHeight = [[array lastObject] floatValue];
                wSelf.activityImageView.height = (ScreenWidth) * (imageHeight / imageWidth);
                wSelf.tableHeaderView.top = wSelf.activityImageView.bottom;
                [wSelf.tableView reloadData];
            }
        }
        [self.activityImageView addImageFromUrlStr:imageUrl];
    }else{
        [self.activityImageView addImageFromUrlStr:imageUrl httpBlock:^(id data, BOOL successful, NSError *error) {
            UIImage * image = nil;
            CGFloat imageWidth = 0;
            CGFloat imageHeight = 0;
            if (successful) {
                image = data;
            }
            if (image) {
                imageWidth = image.size.width;
                imageHeight = image.size.height;
            }else if(wSelf.activityImageView.animatedImage){
                imageHeight = wSelf.activityImageView.height;
                imageWidth = wSelf.activityImageView.width;
            }else{
                imageWidth = ScreenWidth;
                imageHeight = 0;
            }
            
            wSelf.activityImageView.height = (ScreenWidth) * (imageHeight / imageWidth);
            wSelf.tableHeaderView.top = wSelf.activityImageView.bottom;
            [wSelf.tableView reloadData];
        }];
    }
}

- (void)shoppingCartQuantity
{

        if (all_cart.allCartArray.count == 0) {
            self.numberLabel.hidden = YES;
            self.addToCartBuyNewViewModel.addCartAndBuyNewView.addCartAndBuyButtonView.cartNumLabel.hidden = YES;
        }else{
            self.numberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)all_cart.allCartArray.count];
            self.addToCartBuyNewViewModel.addCartAndBuyNewView.addCartAndBuyButtonView.cartNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)all_cart.allCartArray.count];
            self.addToCartBuyNewViewModel.addCartAndBuyNewView.addCartAndBuyButtonView.cartNumLabel.hidden = NO;
            self.numberLabel.hidden = NO;
        }
}

- (void)setNavRightButton
{
    /***  创建按钮   购物车按钮 */
    UIButton * rightButton = [UIButton allocInitWithFrame:CGRectMake(0, 0, 50, 40)];
    [rightButton setImage:imageName(@"list_nav_cart") forState:(UIControlStateNormal)];
    [rightButton setImage:imageName(@"list_nav_cart") forState:(UIControlStateHighlighted)];
    [rightButton addTarget:self action:@selector(enterShoppingCartPage) forControlEvents:(UIControlEventTouchUpInside)];
    [rightButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = textFont(14);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);//
    /***  创建视图  购物车数量label */
    UILabel * numberLabel = [UILabel allocInitWithFrame:CGRectMake(37, 3, 16, 16)];
    numberLabel.backgroundColor = kColorWithRGB(254, 93, 65, 1);
    numberLabel.layer.cornerRadius = 8;
    numberLabel.layer.masksToBounds = YES;
    numberLabel.textColor = kColor(0xffffff);
    numberLabel.font = textFont(8);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [rightButton addSubview:numberLabel];
    numberLabel.hidden = YES;
    self.numberLabel = numberLabel;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark ----   进入购物车
- (void)enterShoppingCartPage
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    XZZCartViewController * cartVC = [XZZCartViewController allocInit];
    [self pushViewController:cartVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameVC = [NSString stringWithFormat:@"分类-%@", self.myTitle];

    [self setNavRightButton];
    
    WS(wSelf)
    UIView * topView = nil;
    if (self.activityId) {
        self.activityView = [XZZActivityCountdownGoodsListHeaderView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
        [self.activityView setRefreshBlock:^{
            if (wSelf.count < 5) {
                wSelf.count++;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [wSelf refreshData];
                });
            }
        }];
        [self.view addSubview:self.activityView];
        topView = self.activityView;
    }
    
    weakView(weak_topView, topView)
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self.goodsListViewModel;
    self.tableView.dataSource = self.goodsListViewModel;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = BACK_COLOR;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        if (weak_topView) {
            make.top.equalTo(weak_topView.mas_bottom);
        }else{
            make.top.equalTo(wSelf.view);
        }
    }];
    [self.tableView addRefresh:self refreshingAction:@selector(refreshData)];
    [self.tableView addLoading:self refreshingAction:@selector(downloadData)];
    
    if (self.activityId) {
        self.activityImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        [self.tableView setTableHeaderView:self.activityImageView];
    }
    
    self.categoryGoods.pageSize = 20;
    self.categoryGoods.orderBy = 1;
    
    self.activityGoods.pageSize = 20;
    self.activityGoods.orderBy = 2;
    
    self.couponsGoods.pageSize = 20;
    self.couponsGoods.orderBy = 1;
    
    if (self.isHomePage) {
        self.categoryGoods.orderBy = 2;
        self.activityGoods.orderBy = 2;
        self.couponsGoods.orderBy = 2;
    }
    
        [self addChatAndActivityFloatWindow];

    [self refreshData];
    if (self.categoryGoods) {
        [self downloadSizeData];
    }
    
}
#pragma mark ----
/**
 *  下载size数据新
 */
- (void)downloadSizeData
{
    WS(wSelf)
    [XZZDataDownload goodsGetSizeLiostCategoryId:self.categoryGoods.categoryId httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.filterView.sizeArray = data;
        }
    }];
}

#pragma mark ----更新数据
- (void)refreshData
{
    self.categoryGoods.pageNum = 0;
    self.activityGoods.pageNum = 0;
    self.couponsGoods.pageNum = 0;
    [self downloadData];
}

#pragma mark ----下载数据
- (void)downloadData
{
    WS(wSelf)
    if (self.activityId) {
        self.activityGoods.pageNum++;
        [XZZDataDownload goodsGetActivityGoods:self.activityGoods httpBlock:^(id data, BOOL successful, NSError *error) {
            if (wSelf.activityGoods.pageNum == 1) {
                [wSelf.goodsArray removeAllObjects];
            }
            if (successful) {
                [wSelf.goodsArray addObjectsFromArray:[data isKindOfClass:[NSArray class]] ? data : nil];
            }
            
            if (wSelf.activityGoods.pageNum == 1) {
                XZZGoodsList * goodsList = [wSelf.goodsArray firstObject];
                wSelf.activityInfor = goodsList.activityVo;
            }
            
            wSelf.goodsListViewModel.hideEmpty = NO;
            wSelf.goodsListViewModel.goodsArray = wSelf.goodsArray;
            [wSelf.tableView reloadData];
            [wSelf.tableView endRefreshing];
        }];
    }
    
    if (self.categoryGoods) {
        self.categoryGoods.pageNum++;
        [XZZDataDownload goodsGetCategoryGoods:self.categoryGoods httpBlock:^(id data, BOOL successful, NSError *error) {
            if (wSelf.categoryGoods.pageNum == 1) {
                [wSelf.goodsArray removeAllObjects];
            }
            if (successful) {
                [wSelf.goodsArray addObjectsFromArray:[data isKindOfClass:[NSArray class]] ? data : nil];
            }
            wSelf.goodsListViewModel.hideEmpty = NO;
            wSelf.goodsListViewModel.goodsArray = wSelf.goodsArray;
            [wSelf.tableView reloadData];
            [wSelf.tableView endRefreshing];
        }];
    }
    
    if (self.couponsId) {
        self.couponsGoods.pageNum++;
        [XZZDataDownload goodsGetCouponGoods:self.couponsGoods httpBlock:^(id data, BOOL successful, NSError *error) {
            if (wSelf.couponsGoods.pageNum == 1) {
                [wSelf.goodsArray removeAllObjects];
            }
            if (successful) {
                [wSelf.goodsArray addObjectsFromArray:[data isKindOfClass:[NSArray class]] ? data : nil];
            }
            wSelf.goodsListViewModel.hideEmpty = NO;
            wSelf.goodsListViewModel.goodsArray = wSelf.goodsArray;
            [wSelf.tableView reloadData];
            [wSelf.tableView endRefreshing];
        }];
    }
}


- (XZZFilterView *)filterView
{
    if (!_filterView) {
        WS(wSelf)
        self.filterView = [XZZFilterView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _filterView.colorArray = [XZZFilterModel shareFilterModel].colorArray;
        [_filterView setSelectSizeAndColorInfor:^(NSArray * _Nonnull sizeArray, NSArray * _Nonnull colorArray) {
            wSelf.categoryGoods.sizeCodeList = sizeArray;
            wSelf.categoryGoods.colorCodeList = colorArray;
            [wSelf refreshData];
        }];
    }
    return _filterView;
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

- (XZZFilteringAndSortingView *)tableHeaderView
{
    if (!_tableHeaderView) {
        WS(wSelf)
        XZZFilteringAndSortingView * view = [XZZFilteringAndSortingView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        view.hiddenFilter = !self.categoryGoods;
        view.sortingArray = @[@"New Arrivals", @"Recommend", @"Price High to Low", @"Price Low To High"];
        [view addView];
        if (self.isHomePage) {
            view.selectedSorting = @"Recommend";
        }else{
            view.selectedSorting = @"New Arrivals";
        }
        

        [view setSelectionSort:^(NSInteger index) {
                switch (index) {
                    case 0:{//最新
                        wSelf.categoryGoods.orderBy = 1;
                        wSelf.activityGoods.orderBy = 1;
                        wSelf.couponsGoods.orderBy = 1;
                    }
                        break;
                    case 1:{//销量
                        wSelf.categoryGoods.orderBy = 2;
                        wSelf.activityGoods.orderBy = 2;
                        wSelf.couponsGoods.orderBy = 2;
                    }
                        break;
                    case 2:{//g低到高
                        wSelf.categoryGoods.orderBy = 3;
                        wSelf.activityGoods.orderBy = 3;
                        wSelf.couponsGoods.orderBy = 3;
                    }
                        break;
                    case 3:{//高到低
                        wSelf.categoryGoods.orderBy = 4;
                        wSelf.activityGoods.orderBy = 4;
                        wSelf.couponsGoods.orderBy = 4;
                    }
                        break;
                        
                    default:
                        break;
                }
            [wSelf refreshData];
        }];
        
        [view setSelectionFilter:^{
            [wSelf.filterView addSuperviewView];
        }];
        
        self.tableHeaderView = view;
    }
    return _tableHeaderView;
}

//- (UIView *)activityTableHeaderView
//{
//    if (!_activityTableHeaderView) {
//        self.activityTableHeaderView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
//        self.activityImageView = imageView;
//        [_activityTableHeaderView addSubview:imageView];
//        self.tableHeaderView.top = imageView.bottom;
//        [_activityTableHeaderView addSubview:self.tableHeaderView];
//        _activityTableHeaderView.height = self.tableHeaderView.bottom;
//    }
//    return _activityTableHeaderView;
//}



@end

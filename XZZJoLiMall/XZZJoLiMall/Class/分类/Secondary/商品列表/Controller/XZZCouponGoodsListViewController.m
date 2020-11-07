//
//  XZZCouponGoodsListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/7.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponGoodsListViewController.h"

#import "XZZCartViewController.h"

#import "XZZGoodsListViewModel.h"

#import "XZZCouponsGoodsListHeaderView.h"


#import "XZZShareView.h"

@interface XZZCouponGoodsListViewController ()<XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCouponsGoodsListHeaderView * headerView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * 列表
 */
@property (nonatomic, strong)UITableView * tableView;
/**
 * 列表
 */
@property (nonatomic, strong)UITableView * tableViewTwo;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModelTwo;

/**
 * 数据源
 */
@property (nonatomic, strong)NSMutableArray * goodsArrayOne;
/**
 * 数据源
 */
@property (nonatomic, strong)NSMutableArray * goodsArrayTwo;

/**
 * 弹出加购框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addToCartBuyNewViewModel;

/**
 * 展示购物车里面的数量信息
 */
@property (nonatomic, strong)UILabel * numberLabel;

/**
 * 优惠券
 */
@property (nonatomic, strong)XZZRequestCouponGoods * couponGoodsX;

/**
 * 优惠券
 */
@property (nonatomic, strong)XZZRequestCouponGoods * couponGoodsY;

/**
 * 1 第一个   2 第二个
 */
@property (nonatomic, assign)NSInteger recommendType;


@end

@implementation XZZCouponGoodsListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartQuantity) name:@"numberShoppingCartsHasChanged" object:nil];
    
    [self.tableView reloadData];
    [self shoppingCartQuantity];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (XZZRequestCouponGoods *)couponGoodsX
{
    if (!_couponGoodsX) {
        self.couponGoodsX = [XZZRequestCouponGoods allocInit];
        _couponGoodsX.couponId = self.couponsId;
        _couponGoodsX.orderBy = 2;
        _couponGoodsX.pageSize = 20;
        _couponGoodsX.recommendType = @"X";
    }
    return _couponGoodsX;
}

- (XZZRequestCouponGoods *)couponGoodsY
{
    if (!_couponGoodsY) {
        self.couponGoodsY = [XZZRequestCouponGoods allocInit];
        _couponGoodsY.couponId = self.couponsId;
        _couponGoodsY.orderBy = 2;
        _couponGoodsY.pageSize = 20;
        _couponGoodsY.recommendType = @"Y";
    }
    return _couponGoodsY;
}

- (void)setCouponsId:(NSString *)couponsId
{
    _couponsId = couponsId;
    [self downloadCouponData];
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

- (void)setCouponsInfor:(XZZCouponsInfor *)couponsInfor
{
    _couponsInfor = couponsInfor;
    _couponsId = couponsInfor.couponId;
    if (couponsInfor.couponType >= 4 && couponsInfor.couponType <= 6) {
        self.headerView.couponsInfor = couponsInfor;
    }else{
        self.headerView.height = 0;
    }
//    if (!self.myTitle.length) {
//        self.myTitle = couponsInfor.seoTitle;
//    }
    
}

#pragma mark ----更新数据
- (void)refreshData
{
    self.couponGoodsX.pageNum = 0;
    [self downloadData];
}

#pragma mark ----更新数据
- (void)refreshDataTwo
{
    self.couponGoodsY.pageNum = 0;
    [self downloadDataTwo];
}

- (void)setRecommendType:(NSInteger)recommendType
{
    _recommendType = recommendType;
    if (recommendType == 2) {
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}

- (void)downloadCouponData
{
    loadView(self.view)
    WS(wSelf)
    [XZZDataDownload userGetCouponsInforCouponsId:self.couponsId httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            wSelf.couponsInfor = data;
        }else{
            [wSelf back];
        }
    }];
}

#pragma mark ----下载数据
- (void)downloadData
{
    WS(wSelf)
    self.couponGoodsX.pageNum++;
    [XZZDataDownload goodsGetCouponGoods:self.couponGoodsX httpBlock:^(id data, BOOL successful, NSError *error) {
        if (wSelf.couponGoodsX.pageNum == 1) {
            [wSelf.goodsArrayOne removeAllObjects];
        }
        [wSelf.goodsArrayOne addObjectsFromArray:data];
        [wSelf.tableView reloadData];
        [wSelf.tableView endRefreshing];
    }];
}

#pragma mark ----下载数据
- (void)downloadDataTwo
{
    WS(wSelf)
    self.couponGoodsY.pageNum++;
    [XZZDataDownload goodsGetCouponGoods:self.couponGoodsY httpBlock:^(id data, BOOL successful, NSError *error) {
        if (wSelf.couponGoodsY.pageNum == 1) {
            [wSelf.goodsArrayTwo removeAllObjects];
        }
        [wSelf.goodsArrayTwo addObjectsFromArray:data];
        
        [wSelf.tableViewTwo reloadData];
        [wSelf.tableViewTwo endRefreshing];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameVC = [NSString stringWithFormat:@"列表-%@", self.myTitle];
    if (!self.myTitle) {
        self.myTitle = @"Jolimall";
    }
    
    [self setNavRightButton];
    self.recommendType = 1;
    
    WS(wSelf)
    [self.view addSubview:self.headerView];
    
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.headerView.mas_bottom);
        make.right.left.bottom.equalTo(wSelf.view);
    }];
    
    
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self.goodsListViewModel;
    self.tableView.dataSource = self.goodsListViewModel;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = BACK_COLOR;
    [self.scrollView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.equalTo(wSelf.view);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    [self.tableView addRefresh:self refreshingAction:@selector(refreshData)];
    [self.tableView addLoading:self refreshingAction:@selector(downloadData)];
    
    
    
    self.tableViewTwo = [UITableView allocInit];
    self.tableViewTwo.delegate = self.goodsListViewModelTwo;
    self.tableViewTwo.dataSource = self.goodsListViewModelTwo;
    self.tableViewTwo.separatorColor = [UIColor clearColor];
    self.tableViewTwo.estimatedRowHeight = 0;
    self.tableViewTwo.estimatedSectionHeaderHeight = 0;
    self.tableViewTwo.estimatedSectionFooterHeight = 0;
    self.tableViewTwo.backgroundColor = BACK_COLOR;
    [self.scrollView addSubview:self.tableViewTwo];
    [self.tableViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.bottom.equalTo(wSelf.tableView);
        make.left.equalTo(wSelf.tableView.mas_right);
    }];
    [self.tableViewTwo addRefresh:self refreshingAction:@selector(refreshDataTwo)];
    [self.tableViewTwo addLoading:self refreshingAction:@selector(downloadDataTwo)];
    
    
    
    [self addChatAndActivityFloatWindow];
    
    [self refreshData];
    [self refreshDataTwo];
    
    
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
        _goodsListViewModel.goodsViewDisplay = XZZGoodsViewDisplayGoodsList;
        _goodsListViewModel.VC = self;
        _goodsListViewModel.hideEmpty = YES;
        _goodsListViewModel.goods_list_count = 2;
        _goodsListViewModel.goodsArray = self.goodsArrayOne;
        [_goodsListViewModel setReloadData:^{
            [wSelf.tableView reloadData];
        }];
    }
    return _goodsListViewModel;
}

- (XZZGoodsListViewModel *)goodsListViewModelTwo
{
    if (!_goodsListViewModelTwo) {
        WS(wSelf)
        self.goodsListViewModelTwo = [XZZGoodsListViewModel allocInit];
        _goodsListViewModelTwo.goodsViewDisplay = XZZGoodsViewDisplayGoodsList;
        _goodsListViewModelTwo.VC = self;
        _goodsListViewModelTwo.hideEmpty = YES;
        _goodsListViewModelTwo.goods_list_count = 2;
        _goodsListViewModelTwo.goodsArray = self.goodsArrayTwo;
        [_goodsListViewModelTwo setReloadData:^{
            [wSelf.tableViewTwo reloadData];
        }];
    }
    return _goodsListViewModelTwo;
}

- (XZZCouponsGoodsListHeaderView *)headerView
{
    if (!_headerView) {
        WS(wSelf)
        self.headerView = [XZZCouponsGoodsListHeaderView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _headerView.delegate = self;
        [_headerView setRefreshUI:^{
            //            [wSelf.tableView reloadData];
        }];
        [_headerView setSelectCouponGoodsType:^(NSInteger type) {
            wSelf.recommendType = type;
        }];
    }
    return _headerView;
}

- (NSMutableArray *)goodsArrayOne
{
    if (!_goodsArrayOne) {
        self.goodsArrayOne = [NSMutableArray array];
    }
    return _goodsArrayOne;
}

- (NSMutableArray *)goodsArrayTwo
{
    if (!_goodsArrayTwo) {
        self.goodsArrayTwo = [NSMutableArray array];
    }
    return _goodsArrayTwo;
}

#pragma mark ---- *  点击分享
/**
 *  点击分享
 */
- (void)clickOnGoodsShare
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    XZZShareView * shareView = [XZZShareView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [shareView addView];
    shareView.delegate = self;
    [shareView addSuperviewView];
    shareView.VC = self;
    shareView.title = self.couponsInfor.seoTitle;
    shareView.imageURL = self.couponsInfor.bannerImage;
    shareView.url = [NSString stringWithFormat:@"%@/coupon/goods/list?couponId=%@", h5_prefix, self.couponsId];
}

#pragma mark ----分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
/**
 *  分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
 */
- (void)clickOnGoodsShareType:(NSInteger)type
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/coupon/goods/list?couponId=%@", h5_prefix, self.couponsId];
    NSString * title = self.couponsInfor.seoTitle;
    NSString * imageUrl = self.couponsInfor.bannerImage;
    switch (type) {
        case 1:{
            RFacebookManager* manager = [RFacebookManager shared];
            [manager shareWebpageWithURL:urlStr
                                   quote:title
                                 hashTag:@"JoLiMall"
                                    from:self
                                    mode:ShareModeSheet//ShareModeAutomatic
                              completion:^(RShareSDKPlatform platform, ShareResult result, NSString *errorInfo) {
                                  if (result == RShareResultSuccess) {
                                      NSLog(@"分享成功");
                                  } else if (result == RShareResultCancel){
                                      NSLog(@"分享取消");
                                  } else {
                                      NSLog(@"分享失败%@", errorInfo);
                                  }
                              }];
        }
            break;
        case 2:{
            [[RFBMessenger shared] shareTitle:title
                                          url:urlStr
                                 elementTitle:title
                                     subtitle:title
                                     imageUrl:imageUrl
                                   completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
                                       if (result == RShareResultSuccess) {
                                           NSLog(@"分享成功");
                                       } else if (result == RShareResultCancel){
                                           NSLog(@"分享取消");
                                       } else {
                                           NSLog(@"分享失败%@", errorInfo);
                                           
                                       }
                                   }];
        }
            break;
        case 3:{
            [[RWhatsAppManager shared]shareText:[NSString stringWithFormat:@"%@\n%@", title, urlStr]];
        }
            break;
        case 4:{
            RPinterestManager* manager = [RPinterestManager shared];
            [manager shareImageWithURL:imageUrl
                            webpageURL:urlStr
                               onBoard:@"JoLiMall"
                           description:title
                                  from:self
                            completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
                                if (result == RShareResultSuccess) {
                                    NSLog(@"分享成功");
                                } else if (result == RShareResultCancel){
                                    NSLog(@"分享取消");
                                } else {
                                    NSLog(@"分享失败%@", errorInfo);
                                    
                                }
                            }];
        }
            break;
            
        default:
            break;
    }
}

@end

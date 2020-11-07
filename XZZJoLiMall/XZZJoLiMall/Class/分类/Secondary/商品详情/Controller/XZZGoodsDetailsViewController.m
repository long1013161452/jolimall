//
//  XZZGoodsDetailsViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsDetailsViewController.h"

#import "XZZCommentsListViewController.h"
#import "XZZCheckOutViewController.h"
#import "XZZAddAddressViewController.h"
#import "XZZCartViewController.h"
#import "XZZCheckOutAddressViewController.h"
#import "XZZGoodsListViewController.h"
#import "XZZCouponGoodsListViewController.h"
#import "XZZGoodsCommentsViewController.h"

#import "XZZGoodsDetailsImageView.h"
#import "XZZGoodsNameAndPriceView.h"
#import "XZZGoodsColorView.h"
#import "XZZGoodsIntroductionView.h"
#import "XZZGoodsScoreView.h"
#import "XZZCommentsTableViewCell.h"
#import "XZZGoodsAlsoLikeView.h"
#import "XZZAddCartAndBuyNewButtonView.h"
#import "XZZGoodsDetailsYouSaveView.h"
#import "XZZGoodsDetailsCouponInforView.h"
#import "XZZAddCartAndBuyNewView.h"
#import "XZZSizeTypeImageView.h"
#import "XZZShareView.h"
#import "XZZGetCouponsView.h"
#import "XZZGoodsWhyJolimallView.h"
#import "XZZRecommendedGoodsListCell.h"

#import "XZZGoodsColorAndSizeView.h"
#import "XZZCouponsRecommendedGoodsView.h"
#import "XZZgoodsDetailsAddReviewView.h"

#import "XZZMyTabBarView.h"

#define goods_list_count 3

@interface XZZGoodsDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, XZZMyDelegate>
/**
 * <#expression#>
 */
@property (nonatomic, assign)int count;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsDetails * goodsInfor;

/**
 * 商品评论
 */
@property (nonatomic, strong)NSArray * commentsArray;

/**
 * 商品评分
 */
@property (nonatomic, strong)XZZGoodsScore * goodsScore;

/**
 * 选中的颜色
 */
@property (nonatomic, weak)XZZColor * selectedColor;

/**
 * 选中的尺码
 */
@property (nonatomic, weak)XZZSize * selectedSize;
/**
 * 选中的sku
 */
@property (nonatomic, strong)XZZSku * selectedSku;

/**
 * 关联商品信息
 */
@property (nonatomic, strong)NSMutableArray * recommendedGoodsArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;
/**
 * 导航栏
 */
@property (nonatomic, strong)UIView * myNavView;
/**
 * 返回按钮
 */
@property (nonatomic, strong)UIButton * backButton;

/**
 * 首页按钮
 */
@property (nonatomic, strong)UIButton * homeButton;
/**
 * 头部视图  数组
 */
@property (nonatomic, strong)NSMutableArray * tableHeardArray;
/**
 * 优惠券信息
 */
@property (nonatomic, strong)XZZGoodsDetailCoupon * goodsDetailCoupon;
/**
 * 商品详情图片
 */
@property (nonatomic, strong)XZZGoodsDetailsImageView * goodsDetailsImageView;
/**
 * 上面价格名称
 */
@property (nonatomic, strong)XZZGoodsNameAndPriceView * goodsNameAndPriceView;
/**
 * 颜色
 */
@property (nonatomic, strong)XZZGoodsColorView * colorView;
/**
 * 颜色与尺码
 */
@property (nonatomic, strong)XZZGoodsColorAndSizeView * colorSizeView;
/**
 * 优惠券推荐商品
 */
@property (nonatomic, strong)XZZCouponsRecommendedGoodsView * couponsRecommendedGoodsView;
/**
 * why jolimall
 */
@property (nonatomic, strong)XZZGoodsWhyJolimallView * whyJolimallView;
/**
 * you save view
 */
@property (nonatomic, strong)XZZGoodsDetailsYouSaveView * youSaveView;
/**
 * 商品介绍
 */
@property (nonatomic, strong)XZZGoodsIntroductionView * goodsIntroductionView;
/**
 * 添加评论
 */
@property (nonatomic, strong)XZZgoodsDetailsAddReviewView * addReviewView;
/**
 * 商品评分
 */
@property (nonatomic, strong)XZZGoodsScoreView * goodsScoreView;
/**
 * 推荐商品 标题
 */
@property (nonatomic, strong)XZZGoodsAlsoLikeView * goodsAlsoLikeView;

/**
 * 按钮
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewButtonView * addCartView;

/**
 * 弹框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewView * addCartAndBuyView;

/**
 * 弹框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel;

/**
 * 滚动高度
 */
@property (nonatomic, assign)CGFloat scrollGHeight;

/**
 * 收藏按钮
 */
@property (nonatomic, strong)UIButton * collectionButton;

/**
 * 优惠券弹框
 */
@property (nonatomic, strong)XZZGetCouponsView * couponsView;

@end

@implementation XZZGoodsDetailsViewController

+ (instancetype)allocInit
{
    XZZGoodsDetailsViewController * vc = [super allocInit];
    vc.tabBarController.tabBar.hidden = NO;
    return vc;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.count = 0;
    [self shoppingCartQuantity];
    
    self.fd_interactivePopDisabled = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartQuantity) name:@"numberShoppingCartsHasChanged" object:nil];


    self.tabBarController.tabBar.hidden = NO;
    
    [self getCommodityCoupons:NO];
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    if (self.navigationController.viewControllers.count > 2) {

        self.tabBarController.tabBar.hidden = YES;
    }
    [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![viewController isKindOfClass:[self class]]) {
        self.tabBarController.tabBar.hidden = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
#pragma mark ----*  返回首页
/**
 *  返回首页
 */
- (void)returnHomePage
{
    self.navigationController.tabBarController.selectedIndex = 0;
    [self popToRootViewControllerAnimated:YES];
}

- (void)shoppingCartQuantity
{
    if (all_cart.allCartArray.count == 0) {
        self.addCartView.cartNumLabel.hidden = YES;
        self.addCartAndBuyView.addCartAndBuyButtonView.cartNumLabel.hidden = YES;
    }else{
        self.addCartView.cartNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)all_cart.allCartArray.count];
        self.addCartAndBuyView.addCartAndBuyButtonView.cartNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)all_cart.allCartArray.count];
        self.addCartAndBuyView.addCartAndBuyButtonView.cartNumLabel.hidden = NO;
        self.addCartView.cartNumLabel.hidden = NO;
    }
    self.collectionButton.selected = StateCollectionGoodsId(self.goodsId);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;

    NSArray *views = self.tabBarController.view.subviews;
    UIView *contentView = [views objectAtIndex:0];
    NSLog(@"-----============-----%f      %f", contentView.height, ScreenHeight);

    
    self.myTitle = @"Product Detail";
    self.nameVC = [NSString stringWithFormat:@"商品详情-%@", self.goodsId];

    
    UIButton * rightButton = [UIButton allocInitWithImageName:@"goods_details_home" selectedImageName:@"goods_details_home"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    WS(wSelf)

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundColor = other_Color_F8F8F8;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.view);
        make.top.equalTo(wSelf.view);
    }];

    
    //获取导航栏的rect
    CGRect navRect = self.navigationController.navigationBar.frame;
    
    self.myNavView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, StatusRect.size.height+navRect.size.height)];
    self.myNavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myNavView];
    [self.myNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
        make.height.equalTo(@(StatusRect.size.height+navRect.size.height));
    }];
    
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:17 textAlignment:(NSTextAlignmentCenter) tag:1];
    titleLabel.text = self.myTitle;
    [self.myNavView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@40);
        make.bottom.equalTo(wSelf.myNavView).offset(-2);
        make.centerX.equalTo(wSelf.myNavView);
    }];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.myNavView.height - .5, ScreenWidth, .5)];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.myNavView addSubview:dividerView];
    
    weakView(weak_titleLabel, titleLabel)
    
    UIView * backButtonBacbView = [UIView allocInit];
    backButtonBacbView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backButtonBacbView];
    backButtonBacbView.layer.cornerRadius = 18;
    backButtonBacbView.alpha = .6;
    [backButtonBacbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@36);
        make.centerY.equalTo(weak_titleLabel);
        make.left.equalTo(@10);
    }];
    self.myNavView.alpha = 0;
    
    self.backButton = [UIButton allocInit];
    [self.backButton setImage:imageName(@"nav_back") forState:(UIControlStateNormal)];
    [self.backButton setImage:imageName(@"nav_back") forState:(UIControlStateHighlighted)];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_titleLabel);
        make.left.equalTo(@15);
        make.width.equalTo(@50);
        make.height.equalTo(@40);
    }];

    [self creatingViewInfor];
    [self dataDownload];
    [self getCommodityCoupons:NO];
    
    [self addChatAndActivityFloatWindow];
}

#pragma mark ----创建视图信息
- (void)creatingViewInfor
{
    WS(wSelf)
    [self.tableHeardArray removeAllObjects];
    CGFloat pictureViewHeight = (ScreenWidth - right_View_Exposing_Width - Image_interval) * (4.0 / 3.0);
    
    self.goodsDetailsImageView = [XZZGoodsDetailsImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, pictureViewHeight) imageUrl:@[] imageClick:^(NSInteger imageIndex, FLAnimatedImageView * _Nonnull imageView) {
        
        
        HUPhotoBrowser * tuPianView = [HUPhotoBrowser showFromImageView:imageView withURLStrings:wSelf.goodsDetailsImageView.imageURLArray placeholderImage:imageName(@"booth_figure_longitudinal") atIndex:imageIndex dismiss:^(UIImage * _Nullable image, NSInteger index) {
            [wSelf.goodsDetailsImageView mobileLocationAtIndex:index];
        }];
        [wSelf.view addSubview:tuPianView];
        
        
    }];
    [self.goodsDetailsImageView setRefresh:^{
        [wSelf.tableView reloadData];
        wSelf.scrollGHeight = wSelf.goodsDetailsImageView.height + wSelf.goodsNameAndPriceView.height + wSelf.colorSizeView.height;
    }];
    self.goodsDetailsImageView.backgroundColor = [UIColor whiteColor];
    [self.tableHeardArray addObject:self.goodsDetailsImageView];
    
    
    ///商品价格名字信息
    self.goodsNameAndPriceView = [XZZGoodsNameAndPriceView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    self.goodsNameAndPriceView.delegate = self;
    [self.goodsNameAndPriceView setRefresh:^{
        [wSelf.tableView reloadData];
        wSelf.scrollGHeight = wSelf.goodsDetailsImageView.height + wSelf.goodsNameAndPriceView.height + wSelf.colorSizeView.height;
    }];
    [self.goodsNameAndPriceView setRefreshData:^{
        if (wSelf.count < 5) {
            wSelf.count++;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wSelf goodsDataDownload];
            });
        }
    }];
    [self.goodsNameAndPriceView setActivityGoodsList:^{
        [wSelf viewActivityGoodsList];
    }];
    [self.tableHeardArray addObject:self.goodsNameAndPriceView];
    
    ///尺寸颜色信息
    self.colorSizeView = [XZZGoodsColorAndSizeView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 500)];
    [self.colorSizeView setRefresh:^{
        [wSelf.tableView reloadData];
        wSelf.scrollGHeight = wSelf.goodsDetailsImageView.height + wSelf.goodsNameAndPriceView.height + wSelf.colorSizeView.height;
    }];
    [self.colorSizeView setSizeGuide:^{
        [wSelf selectProductInfor];
    }];
    [self.colorSizeView setChooseSize:^(XZZSize * _Nonnull size) {
        wSelf.selectedSize = size;
    }];
    [self.colorSizeView setChooseColor:^(XZZColor * _Nonnull color) {
        wSelf.selectedColor = color;
    }];
    [self.colorSizeView setBuyNew:^{
        [wSelf buyNowAccordingSku:wSelf.selectedSku num:wSelf.colorSizeView.numLabel.text.intValue whetherReadSku:YES];
    }];
    [self.colorSizeView setAddToCart:^{
        [wSelf addToCartAccordingSku:wSelf.selectedSku num:wSelf.colorSizeView.numLabel.text.intValue whetherReadSku:YES];
    }];
    [self.colorSizeView setCouponsBack:^{
        [wSelf getCommodityCoupons:YES];
    }];
    [self.tableHeardArray addObject:self.colorSizeView];
    ///推荐商品
    self.couponsRecommendedGoodsView = [XZZCouponsRecommendedGoodsView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    self.couponsRecommendedGoodsView.delegate = self;
    [self.couponsRecommendedGoodsView setCheckCoupons:^{
        XZZCouponGoodsListViewController * couponsGoodsListVC = [XZZCouponGoodsListViewController allocInit];
        couponsGoodsListVC.couponsId = wSelf.goodsDetailCoupon.couponId;
        [wSelf pushViewController:couponsGoodsListVC animated:YES];
    }];
    [self.tableHeardArray addObject:self.couponsRecommendedGoodsView];
    
    ///优惠信息
    if (My_Basic_Infor.detailsPageOfferList.count > 0) {
        XZZGoodsDetailsCouponInforView * couponInforView = [XZZGoodsDetailsCouponInforView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        [self.tableHeardArray addObject:couponInforView];
    }
    
    self.whyJolimallView = [XZZGoodsWhyJolimallView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.tableHeardArray addObject:self.whyJolimallView];
    
    self.youSaveView = [XZZGoodsDetailsYouSaveView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.tableHeardArray addObject:self.youSaveView];
    
    self.goodsIntroductionView = [XZZGoodsIntroductionView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 40.5 * 3)];
    [self.goodsIntroductionView setGoodsIntroductionView:^(XZZGoodsIntroductionSingleView * _Nonnull view) {
        [wSelf.tableView beginUpdates];
        wSelf.goodsIntroductionView.inforView = view;
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:3];
        [wSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [wSelf.tableView endUpdates];
    }];
    [self.tableHeardArray addObject:self.goodsIntroductionView];
    
    self.addReviewView = [XZZgoodsDetailsAddReviewView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    [self.addReviewView setAddReview:^{
        [wSelf addCommentInformation];
    }];
    [self.tableHeardArray addObject:self.addReviewView];
    
    
    self.goodsScoreView = [XZZGoodsScoreView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.goodsScoreView setViewAll:^{
        [wSelf viewAllComments];
    }];
    [self.tableHeardArray addObject:self.goodsScoreView];
    
    self.goodsAlsoLikeView = [XZZGoodsAlsoLikeView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    [self.tableHeardArray addObject:self.goodsAlsoLikeView];
    
}

- (void)clickOutCollectGoods
{
    [self collectGoodsAccordingId:self.goodsId];
}

#pragma mark ---- 添加评论信息
/**
 * #pragma mark ---- 添加评论信息
 */
- (void)addCommentInformation
{
    WS(wSelf)
    XZZGoodsCommentsViewController * goodsCommentsVC = [XZZGoodsCommentsViewController allocInit];
    goodsCommentsVC.goodsId = self.goodsId;
    goodsCommentsVC.skuOrderList = self.goodsScore.canCommentList;
    [goodsCommentsVC setRemoveCanCommentSku:^(XZZCanCommentSku * _Nonnull canCommentSku) {
        [wSelf.goodsScore.canCommentList removeObject:canCommentSku];
        if (wSelf.goodsScore.canCommentList.count == 0) {
            [wSelf.tableHeardArray removeObject:wSelf.addReviewView];
            [wSelf.tableView reloadData];
        }
    }];
    [self pushViewController:goodsCommentsVC animated:YES];
}

- (void)clickOutCart
{
    [self goToCartVC];
}

#pragma mark ----*  懒加载
/**
 *  懒加载
 */
- (XZZAddCartAndBuyNewView *)addCartAndBuyView
{
    if (!_addCartAndBuyView) {
        WS(wSelf)
        self.addCartAndBuyView = [XZZAddCartAndBuyNewView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//        _addCartAndBuyView.goods = self.goodsInfor;
        [_addCartAndBuyView setAddToCart:^{
            [wSelf addToCartAccordingSku:wSelf.selectedSku num:wSelf.addCartAndBuyView.numLabel.text.intValue whetherReadSku:YES];
        }];
        [_addCartAndBuyView setBuyNew:^{//立即购买
            [wSelf buyNowAccordingSku:wSelf.selectedSku num:wSelf.addCartAndBuyView.numLabel.text.intValue whetherReadSku:YES];
        }];
        [_addCartAndBuyView setGoCart:^{//进入购物车
            [wSelf goToCartVC];
        }];
        
        [_addCartAndBuyView setSelectedSize:^(XZZSize * _Nonnull size) {
            wSelf.selectedSize = size;
        }];
        [_addCartAndBuyView setSelectedColor:^(XZZColor * _Nonnull color) {
            wSelf.selectedColor = color;
        }];
        [_addCartAndBuyView setSizeGuide:^{
            [wSelf selectProductInfor];
        }];
    }
    return _addCartAndBuyView;
}

- (XZZAddCartAndBuyNewViewModel *)addCartAndBuyNewViewModel
{
    if (!_addCartAndBuyNewViewModel) {
        XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel = [XZZAddCartAndBuyNewViewModel allocInit];
        addCartAndBuyNewViewModel.VC = self;
        self.addCartAndBuyNewViewModel = addCartAndBuyNewViewModel;
    }
    return _addCartAndBuyNewViewModel;
}

- (XZZGetCouponsView *)couponsView
{
    if (!_couponsView) {
        WS(wSelf)
        self.couponsView = [XZZGetCouponsView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_couponsView setGetCouponBlock:^(XZZCouponsInfor *couponsInfor) {
            [wSelf getCoupons:couponsInfor];
        }];
    }
    return _couponsView;
}

- (void)getCoupons:(XZZCouponsInfor *)couponsInfor
{
    if (!User_Infor.isLogin) {
        logInVC(self)
        [self.couponsView removeView];
        return;
    }
    WS(wSelf)
    [XZZDataDownload userGetCouponsParams:couponsInfor.param httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            
            [wSelf successfulDataProcessingReceivingCoupons:couponsInfor];
            SVProgressSuccess(data)
            
        }else{
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
            }else{
                SVProgressError(@"Try again later")
            }
        }
    }];
}
#pragma mark ----领取优惠券成功处理数据信息
/**
 *  领取优惠券成功处理数据信息
 */
- (void)successfulDataProcessingReceivingCoupons:(XZZCouponsInfor *)couponsInfor
{
    couponsInfor.isReceived = YES;
    [self.couponsView.tableView reloadData];
    for (XZZCouponsInfor * infor in self.couponsView.dataArray) {
        if (!infor.isReceived) {
            return;
        }
    }
    
    [self.couponsView removeView];
    self.colorSizeView.couponsButton.hidden = YES;
    
}




- (NSMutableArray *)tableHeardArray
{
    if (!_tableHeardArray) {
        self.tableHeardArray = [NSMutableArray array];
    }
    return _tableHeardArray;
}

- (NSMutableArray *)recommendedGoodsArray
{
    if (!_recommendedGoodsArray) {
        self.recommendedGoodsArray = @[].mutableCopy;
    }
    return _recommendedGoodsArray;
}
#pragma mark ----*  数据下载
/**
 *  数据下载
 */
- (void)dataDownload
{

    WS(wSelf)
    [self goodsDataDownload];
    
    
    [XZZDataDownload goodsGetGoodsScore:self.goodsId httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.goodsScore = data;
            if (!wSelf.goodsScore.canCommentList.count) {
                [wSelf.tableHeardArray removeObject:wSelf.addReviewView];
            }
            wSelf.goodsScoreView.score = data;
            wSelf.goodsNameAndPriceView.score = data;
        }else{
            [wSelf.tableHeardArray removeObject:wSelf.addReviewView];
            [wSelf.tableHeardArray removeObject:wSelf.goodsScoreView];
        }
        [wSelf.tableView reloadData];
    }];
    
    [XZZDataDownload goodsGetGoodsComments:self.goodsId page:1 httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.commentsArray = data;
            [wSelf.tableHeardArray removeObject:wSelf.addReviewView];
        }else{
            [wSelf.tableHeardArray removeObject:wSelf.goodsScoreView];
        }
        [wSelf.tableView reloadData];
    }];
    
    
}

#pragma mark ----*  商品详情数据下载
/**
 *  商品详情数据下载
 */
- (void)goodsDataDownload
{
    WS(wSelf)
    loadView(nil)
    [XZZDataDownload goodsGetGoodsDetails:self.goodsId entrance:@"detail" httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.goodsInfor = data;
            [wSelf assignmentGoodsDetails];
            [wSelf downloadRelatedProducts];
        }else{
            [wSelf back];
        }
        loadViewStop
    }];
}

- (void)setGoodsDetailCoupon:(XZZGoodsDetailCoupon *)goodsDetailCoupon
{
    _goodsDetailCoupon = goodsDetailCoupon;
    if (goodsDetailCoupon.couponId.length <= 0) {
        [self.tableHeardArray removeObject:self.couponsRecommendedGoodsView];
        [self.tableView reloadData];
        return;
    }
    self.couponsRecommendedGoodsView.prompt = goodsDetailCoupon.prompt;
    
    WS(wSelf)
    XZZRequestCouponGoods * requestCouponsGoods = [XZZRequestCouponGoods allocInit];
    requestCouponsGoods.couponId = goodsDetailCoupon.couponId;
    requestCouponsGoods.recommendType = goodsDetailCoupon.recommendType;
    requestCouponsGoods.recommendExcludeGoodsId = self.goodsId;
    requestCouponsGoods.pageNum = 1;
    requestCouponsGoods.pageSize = 3;
    requestCouponsGoods.orderBy = 2;
    [XZZDataDownload goodsGetCouponGoods:requestCouponsGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.couponsRecommendedGoodsView.goodsList = data;
        }else{
            [wSelf.tableHeardArray removeObject:wSelf.couponsRecommendedGoodsView];
        }
        [wSelf.tableView reloadData];
    }];
}

#pragma mark ----获取商品优惠券
/**
 *  获取商品优惠券
 */
- (void)getCommodityCoupons:(BOOL)isBounced
{
    WS(wSelf)
    if (isBounced) {
        loadView(self.view)
    }
    [XZZDataDownload userGetGoodsCoupons:self.goodsId httpBlock:^(id data, BOOL successful, NSError *error) {
        wSelf.goodsDetailCoupon = data;
        [wSelf dataProcessingCoupons:data isBounced:isBounced];
    }];
}
#pragma mark ----优惠券数据处理
/**
 *  优惠券数据处理
 */
- (void)dataProcessingCoupons:(XZZGoodsDetailCoupon *)goodsDetailCoupon isBounced:(BOOL)isBounced
{
    
    NSMutableArray * arrayTwo = @[].mutableCopy;
    for (XZZCouponsInfor * couponsInfor in goodsDetailCoupon.couponVos) {
        if (!couponsInfor.isReceived) {
            [arrayTwo addObject:couponsInfor];
        }
    }
    if (arrayTwo.count > 0) {
        self.colorSizeView.couponsButton.hidden = NO;
    }else{
        self.colorSizeView.couponsButton.hidden = YES;
        return;
    }
    self.couponsView.dataArray = arrayTwo.copy;
    if (isBounced) {
        loadViewStop
        [self.couponsView addSuperviewView];
    }
}

#pragma mark ----*  下载推荐商品
/**
 *  下载推荐商品
 */
- (void)downloadRelatedProducts
{
    WS(wSelf)
    XZZRequestRecommendedGoods * recommendedGoods = [XZZRequestRecommendedGoods allocInit];
    recommendedGoods.goodsIdList = @[self.goodsId];
    recommendedGoods.keywords = self.goodsInfor.goods.keywords;
    recommendedGoods.page = 1;
    recommendedGoods.pageSize = 60;
    recommendedGoods.toppingGoodsIdList = self.goodsInfor.goods.associatedGoods;
    
    [XZZDataDownload goodsGetGoodsRecommended:recommendedGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf.recommendedGoodsArray addObjectsFromArray:data];
        }else{
            
            if (wSelf.recommendedGoodsArray.count == 0) {
                [wSelf.tableHeardArray removeObject:wSelf.goodsAlsoLikeView];
            }
        }
        [wSelf.tableView reloadData];
    }];
    
}

#pragma mark ----*  商品信息赋值
/**
 *  商品信息赋值
 */
- (void)assignmentGoodsDetails
{
    self.tableView.backgroundColor = other_Color_F8F8F8;
    [self.goodsDetailsImageView recreateImageviewAccordingToImageUrl:self.goodsInfor.picArray];
    
    if (self.goodsInfor.goods.status == 0) {
        [self.addCartView whetherCanAddShoppingCartAndBuy:NO];
    }
    
    self.goodsNameAndPriceView.goods = self.goodsInfor;
    self.colorView.goods = self.goodsInfor;
    self.colorSizeView.goods = self.goodsInfor;
    
    XZZBasicInformation * basicInfor = My_Basic_Infor;
    
    self.youSaveView.preferential = self.goodsInfor.goods.youSave;

    if (self.goodsInfor.goods.introduction.length) {
        self.whyJolimallView.introduction = self.goodsInfor.goods.introduction;
    }else{
        if (self.goodsInfor.goods.youSave.length <= 0) {
            [self.tableHeardArray removeObject:self.youSaveView];
        }
        [self.tableHeardArray removeObject:self.whyJolimallView];
    }
    
    self.goodsIntroductionView.titleArray = @[@"Description", basicInfor.detailsPageInfo1Title, basicInfor.detailsPageInfo2Title];
    
    self.goodsIntroductionView.contentArray = @[self.goodsInfor.goods.descriptionStr,
                                                basicInfor.detailsPageInfo1Desc,
                                                basicInfor.detailsPageInfo2Desc
                                                ];
    //    self.addCartAndBuyView.goods = self.goodsInfor;
    if (self.couponsView.dataArray.count > 0) {
        self.colorSizeView.couponsButton.hidden = NO;
    }
    [self.tableView reloadData];
}

#pragma mark ----*  选中的颜色赋值
/**
 *  选中的颜色赋值
 */
- (void)setSelectedColor:(XZZColor *)selectedColor
{
    if (!_selectedColor) {
        _selectedColor = selectedColor;
        return;
    }
    if ([self.selectedColor isEqual:selectedColor]) {
        return;
    }
    _selectedColor = selectedColor;
    
    NSLog(@"===========================%@", selectedColor.picturesArray);

    if (selectedColor) {
        [self.goodsDetailsImageView recreateImageviewAccordingToImageUrl:selectedColor.picturesArray];
       
        [self getSkuInfor];
    }else{
        [self.goodsDetailsImageView recreateImageviewAccordingToImageUrl:self.goodsInfor.picArray];
    }
//     [self.colorView selectedColorInfor:selectedColor];
    
}
#pragma mark ----*  选中尺寸赋值
/**
 *  选中尺寸赋值
 */
- (void)setSelectedSize:(XZZSize *)selectedSize
{
    _selectedSize = selectedSize;
    if (selectedSize) {
        [self getSkuInfor];
    }else{
        self.selectedSku = nil;
    }
}
#pragma mark ----*  选中的sku赋值
/**
 *  选中的sku赋值
 */
- (void)setSelectedSku:(XZZSku *)selectedSku
{
    _selectedSku = selectedSku;
    if (selectedSku) {
        self.addCartAndBuyView.selectedSku = selectedSku;
        [self.addCartAndBuyView whetherCanAddShoppingCartAndBuy:selectedSku.status];
    }
}

#pragma mark ---- *  点击商品购物车  根据商品id
/**
 *  点击商品购物车  根据商品id
 */
- (void)goodsViewShopCartAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    self.addCartAndBuyNewViewModel.goodsId = goodsId;
}

#pragma mark ----*  获取sku信息
/**
 *  获取sku信息
 */
- (void)getSkuInfor
{

    if (!self.selectedSize) {
        return;
    }
    if (!self.selectedColor) {
        return;
    }
    self.selectedSku = [self.goodsInfor accordingColor:self.selectedColor size:self.selectedSize];
}
#pragma mark ----*  加入购物车  根据id  数量 whetherReadSku 是否需要重新拉去sku信息
/**
 *  加入购物车  根据id  数量 whetherReadSku 是否需要重新拉去sku信息
 */
- (void)addToCartAccordingSku:(XZZSku *)sku num:(int)num whetherReadSku:(BOOL)whetherReadSku
{
    if (!self.selectedColor) {
        SVProgressError(@"Please choose color")
        [self.colorSizeView promptsSelectColorOrSize];
        return;
    }
    if (!self.selectedSize) {
        SVProgressError(@"Please choose size")
        [self.colorSizeView promptsSelectColorOrSize];
        return;
    }
    if (sku.status != 1) {
        SVProgressError(@"Out of stock")
        [self.addCartAndBuyView whetherCanAddShoppingCartAndBuy:NO];
        return;
    }
    NSLog(@"%s %d 行", __func__, __LINE__);
    WS(wSelf)
    loadView(self.view)
    if (whetherReadSku) {
        [XZZDataDownload cartGetSkuInforSkuIDs:@[sku.ID] httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                NSArray * array = data;
                if ([array isKindOfClass:[NSArray class]]) {
                    XZZSku * skuTwo = [array firstObject];
                    [wSelf addToCartAccordingSku:skuTwo num:num whetherReadSku:NO];
                }
            }else{
                SVProgressError(@"Out of stock")
                [wSelf.addCartAndBuyView whetherCanAddShoppingCartAndBuy:NO];
            }
        }];
        
        return;
    }
    sku.weight = self.goodsInfor.goods.weight;
    XZZCartInfor * cartInfor = [XZZCartInfor cartInforWithSku:sku num:num];
    [all_cart addCart:cartInfor goodsDetails:self.goodsInfor httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(data)
            [wSelf.addCartAndBuyView removeView];
        }else{
            SVProgressError(data)
        }
    }];
}
#pragma mark ----*  立即购买  根据id  数量 whetherReadSku 是否需要重新拉去sku信息
/**
 *  立即购买  根据id  数量   whetherReadSku 是否需要重新拉去sku信息
 */
- (void)buyNowAccordingSku:(XZZSku *)sku num:(int)num whetherReadSku:(BOOL)whetherReadSku
{
    if (!self.selectedColor) {
        SVProgressError(@"Please choose color")
        [self.colorSizeView promptsSelectColorOrSize];
        return;
    }
    if (!self.selectedSize) {
        SVProgressError(@"Please choose size")
        [self.colorSizeView promptsSelectColorOrSize];
        return;
    }
    if (sku.status != 1) {
        SVProgressError(@"Out of stock")
        [self.addCartAndBuyView whetherCanAddShoppingCartAndBuy:NO];
        return;
    }
    
    if (whetherReadSku) {
        WS(wSelf)
        loadView(self.view)
        [XZZDataDownload cartGetSkuInforSkuIDs:@[sku.ID] httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                NSArray * array = data;
                if ([array isKindOfClass:[NSArray class]]) {
                    XZZSku * skuTwo = [array firstObject];
                    [wSelf buyNowAccordingSku:skuTwo num:num whetherReadSku:NO];
                }
            }else{
                SVProgressError(@"Out of stock")
                [wSelf.addCartAndBuyView whetherCanAddShoppingCartAndBuy:NO];
            }
        }];
        
        return;
    }
    [self.addCartAndBuyView removeView];
    
    if (!User_Infor.isLogin) {
        logInVC(self);
        return;
    }
    sku.weight = self.goodsInfor.goods.weight;
    XZZCartInfor * cartInfor = [XZZCartInfor cartInforWithSku:sku num:num];
    cartInfor.goodsCode = self.goodsInfor.goods.code;
    
    [XZZBuriedPoint aws_buyNow:cartInfor];
    


    XZZCheckOutViewController * checkOutVC = [XZZCheckOutViewController allocInit];
    checkOutVC.cartInforArray = @[cartInfor];
    checkOutVC.isBuyNow = YES;
    [checkOutVC setHidesBottomBarWhenPushed:YES];
    
    if (User_Infor.addressArray.count <= 0) {
        XZZAddAddressViewController * addAddressVC = [XZZAddAddressViewController allocInit];
        addAddressVC.delegate = checkOutVC;
        [self pushViewController:addAddressVC animated:YES];
        
        NSMutableArray*tempMarr =[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        
        [tempMarr insertObject:checkOutVC atIndex:tempMarr.count- 1];
        
        [self.navigationController setViewControllers:tempMarr animated:YES];
    }else{
        [self pushViewController:checkOutVC animated:YES];
    }
}
#pragma mark ----*  进入购物车
/**
 *  进入购物车
 */
- (void)goToCartVC
{
    [self.addCartAndBuyView removeView];
    if (self.navigationController.viewControllers.count > 1) {
        [self pushViewController:[XZZCartViewController allocInit] animated:YES];
    }else{
        self.tabBarController.selectedIndex = 2;
    }
}
#pragma mark ---- * 查看尺寸
/**
 * 查看尺寸
 */
- (void)selectProductInfor
{
    XZZSizeTypeImageView * sizeTypeView = [XZZSizeTypeImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    sizeTypeView.transparentLayerView.backgroundColor = [UIColor clearColor];
    sizeTypeView.imageUrl = self.goodsInfor.goods.sizeTypeCodePicture;
    [sizeTypeView addSuperviewView];
}


#pragma mark ----*  加载弹出框
/**
 *  加载弹出框
 */
- (void)handlePopupsButtonType:(XZZAddCartAndBuyNewButtonType)buttonType
{
    self.addCartAndBuyView.buttonType = buttonType;
    [self.addCartAndBuyView selectedColor:self.selectedColor size:nil];
    [self.addCartAndBuyView addSuperviewView];
}



#pragma mark ---- 进入活动商品列表信息
/**
 * #pragma mark ---- 进入活动商品列表信息
 */
- (void)viewActivityGoodsList
{
    XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
//    goodsListVC.myTitle = self.goodsInfor.activityVo.shortTitle;
    goodsListVC.myTitle = @"Jolimall";
    goodsListVC.activityId = self.goodsInfor.activityVo.activityId;
    [self pushViewController:goodsListVC animated:YES];
}
#pragma mark ----查看所有的评论信息
/**
 *  查看所有的评论信息
 */
- (void)viewAllComments
{
    XZZCommentsListViewController * commentsListVC = [XZZCommentsListViewController allocInit];
    commentsListVC.goodsId = self.goodsId;
    commentsListVC.goodsScore = self.goodsScore;
    [self pushViewController:commentsListVC animated:YES];
}

#pragma mark ---- *  对商品进行收藏
/**
 *  对商品进行收藏
 */
- (void)collectGoodsAccordingId:(NSString *)goodsId
{
    WS(wSelf)
    [XZZCommonLogicalInfor goodsCollectionAccordingId:goodsId source:2 VC:self reloadData:^{
        wSelf.collectionButton.selected = StateCollectionGoodsId(goodsId);
        wSelf.goodsNameAndPriceView.collectionButton.selected = StateCollectionGoodsId(goodsId);
        [wSelf.tableView reloadData];
    }];
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
}
#pragma mark ----分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
/**
 *  分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
 */
- (void)clickOnGoodsShareType:(NSInteger)type
{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@/p-%@", h5_goods_prefix, self.goodsInfor.goods.title, self.goodsId];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    [XZZBuriedPoint shareProductInfor:self.goodsInfor platform:type];
    
    switch (type) {
        case 1:{
            RFacebookManager* manager = [RFacebookManager shared];
            [manager shareWebpageWithURL:urlStr
                                   quote:self.goodsInfor.goods.title
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
            [[RFBMessenger shared] shareTitle:self.goodsInfor.goods.title
                                          url:urlStr
                                 elementTitle:self.goodsInfor.goods.title
                                     subtitle:self.goodsInfor.goods.title
                                     imageUrl:self.goodsInfor.goods.pictureUrl
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
            [[RWhatsAppManager shared]shareText:[NSString stringWithFormat:@"%@\n%@", self.goodsInfor.goods.title, urlStr]];
        }
            break;
        case 4:{
            RPinterestManager* manager = [RPinterestManager shared];
            [manager shareImageWithURL:self.goodsInfor.goods.pictureUrl
                            webpageURL:urlStr
                               onBoard:@"JoLiMall"
                           description:self.goodsInfor.goods.title
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
#pragma mark ---- *  点击商品    进入商品详情使用
/**
 *  点击商品    进入商品详情使用
 */
- (void)clickOnGoodsAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    GoodsDetails(goodsId, self)
}

#pragma mark ----*  查看大图
/**
 *  查看大图
 */
- (void)viewLargerVersionImages:(NSArray *)imageArray imageView:(UIImageView *)imageView index:(int)index
{
    
    //获取导航栏的rect
    CGRect navRect = self.navigationController.navigationBar.frame;
    CGFloat top = StatusRect.size.height + navRect.size.height;
    HUPhotoBrowser * tuPianView = [HUPhotoBrowser showFromImageView:imageView withURLStrings:imageArray placeholderImage:imageName(@"booth_figure_longitudinal") atIndex:index dismiss:^(UIImage * _Nullable image, NSInteger index) {

    }];
    [self.view addSubview:tuPianView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.myNavView.alpha = (scrollView.contentOffset.y - self.goodsDetailsImageView.height) / 50.0;
}



#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableHeardArray.count;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UIView * view = self.tableHeardArray[section];
    if ([view isEqual:self.goodsScoreView]) {
        if (self.commentsArray.count > 0) {
            return self.commentsArray.count > 3 ? 3 : self.commentsArray.count;
        }else{
            return 0;
        }
    }
    if ([view isEqual:self.goodsAlsoLikeView]) {
        return (self.recommendedGoodsArray.count + goods_list_count - 1) / goods_list_count;
    }
    return 0;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView * view = self.tableHeardArray[indexPath.section];
    if ([view isEqual:self.goodsScoreView]) {
        XZZCommentsTableViewCell * cell = [XZZCommentsTableViewCell codeCellWithTableView:tableView];
        cell.goodsComments = self.commentsArray[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    XZZGoodsListCell * cell = [XZZGoodsListCell codeCellWithTableView:tableView];
    cell.goodsViewDisplay = XZZGoodsViewDisplayRecommendedGoodsList;
    cell.count = goods_list_count;
    cell.delegate = self;
//    cell.cartHidden = YES;
    cell.collectionHidden = YES;
    static NSMutableArray * array = nil;
    if (!array) {
        array = @[].mutableCopy;
    }
    [array removeAllObjects];
    NSInteger count = indexPath.row * goods_list_count;
    for (int i = 0; i < goods_list_count; i++) {
        if (count < self.recommendedGoodsArray.count) {
            [array addObject:self.recommendedGoodsArray[count]];
        }else{
            break;
        }
        count++;
    }
    cell.goodsArray = array.mutableCopy;
//    cell.backgroundColor = BACK_COLOR;
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView * view = self.tableHeardArray[indexPath.section];
    if ([view isEqual:self.goodsScoreView]) {
        return [XZZCommentsTableViewCell calculateHeightCell:self.commentsArray[indexPath.row]];
    }
    if ([view isEqual:self.goodsAlsoLikeView]) {
        return [XZZGoodsListCell calculateCellHeight:goods_list_count];
        return [XZZRecommendedGoodsListCell calculateCellHeight:goods_list_count];
    }
    return 0;
}
#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UIView * view = self.tableHeardArray[section];
    return view.height;
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = self.tableHeardArray[section];
    return view;
}
#pragma mark ---- 设置区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView * view = self.tableHeardArray[section];
    if ([view isEqual:self.goodsScoreView] && self.goodsScore.canCommentList.count > 0) {
        return 40;
    }
    return 0.01;
}
#pragma mark ---- 设置区尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = self.tableHeardArray[section];
    if ([view isEqual:self.goodsScoreView] && self.goodsScore.canCommentList.count > 0) {
        UIView * viewTwo = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        viewTwo.backgroundColor = [UIColor whiteColor];
        
        weakView(weak_viewTwo, viewTwo);
        UIButton * button = [UIButton allocInitWithTitle:@"Add a review" color:button_back_color selectedTitle:@"Add a review" selectedColor:button_back_color font:14];
        button.titleLabel.font = textFont_bold(14);
        [button cutRounded:14];
        button.layer.borderColor = button_back_color.CGColor;
        button.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(addCommentInformation) forControlEvents:(UIControlEventTouchUpInside)];
        [viewTwo addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weak_viewTwo).offset(16);
            make.height.equalTo(@28);
            make.width.equalTo(@110);
            make.bottom.equalTo(weak_viewTwo).offset(-16);
        }];
        
        return viewTwo;
    }
    return nil;
}
#pragma mark ----- tableView代理结束







@end

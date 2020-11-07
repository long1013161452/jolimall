//
//  XZZUserViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZUserViewController.h"
#import "XZZOrderListViewController.h"
#import "XZZAddressListViewController.h"
#import "XZZAddAddressViewController.h"
#import "XZZSetListViewController.h"
#import "XZZSupportViewController.h"
#import "XZZCouponListViewController.h"

#import "XZZUserHeadView.h"
#import "XZZCollectionIsEmptyTableViewCell.h"
#import "XZZGoodsListViewModel.h"

#define goods_count 2

@interface XZZUserViewController ()<XZZMyDelegate>

/**
 * 收藏商品展示
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * 展示用户信息
 */
@property (nonatomic, strong)XZZUserHeadView * userHeadView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addToCartBuyNewViewModel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsListViewModel * goodsListViewModel;

@end

@implementation XZZUserViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self userLogIn];
}

- (void)userLogIn
{
    [self dataDownload];
    if (User_Infor.isLogin) {
        self.userHeadView.logInButton.hidden = YES;
        self.userHeadView.emailLabel.text = User_Infor.email;
    }else{
        self.userHeadView.logInButton.hidden = NO;
        self.userHeadView.emailLabel.text = @"";
    }
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
        XZZGoodsListViewModel * goodsListViewModel = [XZZGoodsListViewModel allocInit];
        goodsListViewModel.goodsViewDisplay = XZZGoodsViewDisplayRecommendedGoodsList;
        goodsListViewModel.VC = self;
        goodsListViewModel.goods_list_count = 2;
        goodsListViewModel.collectionHidden = NO;
        goodsListViewModel.hideEmpty = YES;
        goodsListViewModel.cellBackColor = [UIColor whiteColor];
        goodsListViewModel.reloadData = ^{
            [wSelf.tableView reloadData];
        };
        self.goodsListViewModel = goodsListViewModel;
    }
    return _goodsListViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = BACK_COLOR;
    
    self.nameVC = @"我的";
    self.fd_prefersNavigationBarHidden = YES;
    WS(wSelf)
    
    self.userHeadView = [XZZUserHeadView allocInit];
    [self.userHeadView setSetUp:^{
        [wSelf viewSetUp];
    }];
    [self.userHeadView setLogIn:^{
        if (!User_Infor.isLogin) {
            logInVC(wSelf)
        }
    }];
    [self.userHeadView setOrderList:^{
        [wSelf viewOrderList];
    }];
    [self.userHeadView setCouponsList:^{
        [wSelf viewCouponsList];
    }];
    [self.userHeadView setAddressList:^{
        [wSelf viewAddressList];
    }];
    [self.userHeadView setSupport:^{
        [wSelf viewSupport];
    }];
    [self.view addSubview:self.userHeadView];
    [self.userHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    
    UIView * wishListBackView = [UIView allocInit];
    wishListBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wishListBackView];
    [wishListBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.height.equalTo(@45);
        make.top.equalTo(wSelf.userHeadView.mas_bottom).offset(10);
    }];
    weakView(weak_wishListBackView, wishListBackView);
    
    UILabel * wishListLabel = [UILabel allocInitWithFrame:CGRectMake(8, 0, 200, 55)];
    wishListLabel.textColor = kColor(0x000000);
    wishListLabel.font = textFont_bold(14);
    wishListLabel.text = @"Wishlist";
    [wishListBackView addSubview:wishListLabel];
    
    UIView * dividerView1 = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, divider_view_width)];
    dividerView1.backgroundColor = DIVIDER_COLOR;
    [wishListBackView addSubview:dividerView1];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self.goodsListViewModel;
    self.tableView.dataSource = self.goodsListViewModel;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.top.equalTo(weak_wishListBackView.mas_bottom).offset(-4);
    }];
    
    

    [self addChatAndActivityFloatWindow];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogIn) name:@"userLogIn" object:nil];

}



#pragma mark ----*  查看设置信息
/**
 *  查看设置信息
 */
- (void)viewSetUp
{
    XZZSetListViewController * setListVC = [XZZSetListViewController allocInit];
    [self pushViewController:setListVC animated:YES];
}
#pragma mark ----*  查看订单列表
/**
 *  查看订单列表
 */
- (void)viewOrderList
{
    if (User_Infor.isLogin) {
        XZZOrderListViewController * orderListVC = [XZZOrderListViewController allocInit];
        [self pushViewController:orderListVC animated:YES];
    }else{
        logInVC(self)
    }
    
}
#pragma mark ----*  查看优惠券列表
/**
 *  查看优惠券列表
 */
- (void)viewCouponsList
{
    if(User_Infor.isLogin){
        XZZCouponListViewController * couponListVC = [XZZCouponListViewController allocInit];
        [self pushViewController:couponListVC animated:YES];
    }else{
        logInVC(self)
    }
}
#pragma mark ----*  查看地址列表
/**
 *  查看地址列表
 */
- (void)viewAddressList
{
    if (User_Infor.isLogin) {
        XZZAddressListViewController * addressListVC = [XZZAddressListViewController allocInit];
        addressListVC.view.backgroundColor = BACK_COLOR;
        [addressListVC setHidesBottomBarWhenPushed:YES];
        
        if (User_Infor.addressArray.count <= 0) {
            XZZAddAddressViewController * addAddressVC = [XZZAddAddressViewController allocInit];
            [self pushViewController:addAddressVC animated:YES];
            
            NSMutableArray * VCs = self.navigationController.viewControllers.mutableCopy;
            [VCs insertObject:addressListVC atIndex:VCs.count - 1];
            [self.navigationController setViewControllers:VCs animated:YES];
            
        }else{
            [self pushViewController:addressListVC animated:YES];
        }
        
    }else{
        logInVC(self)
    }
}
#pragma mark ----*  查看支持
/**
 *  查看支持
 */
- (void)viewSupport
{
    XZZSupportViewController * supportVC = [XZZSupportViewController allocInit];
    [self pushViewController:supportVC animated:YES];
}


- (void)dataDownload
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (User_Infor.isLogin) {
        NSLog(@"%s %d 行  数据下载", __func__, __LINE__);
        WS(wSelf)
        self.goodsListViewModel.hideEmpty = YES;
        [User_Infor getInformationCollectibleGoodsHttpBlock:^(id data, BOOL successful, NSError *error) {
            wSelf.goodsListViewModel.hideEmpty = NO;
            wSelf.goodsListViewModel.goodsArray = User_Infor.collectionArray;
            [wSelf.tableView reloadData];
        }];
    }else{
        /***  cell展示没有商品信息 */
        self.goodsListViewModel.goodsArray = nil;
        self.goodsListViewModel.hideEmpty = NO;
        [self.tableView reloadData];
    }
}




@end

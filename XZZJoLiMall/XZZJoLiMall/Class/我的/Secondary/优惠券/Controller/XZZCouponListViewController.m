//
//  XZZCouponListViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponListViewController.h"
#import "XZZReplaceCouponsStateView.h"
#import "XZZCouponsListTableViewCell.h"
#import "XZZCouponEmptyTableViewCell.h"
#import "XZZCouponsOrderListTableViewCell.h"
#import "XZZCouponPopUpView.h"


#import "XZZGoodsListViewController.h"
#import "XZZCouponGoodsListViewController.h"

@interface XZZCouponListViewController ()<UITableViewDelegate, UITableViewDataSource>


/**
 * 优惠券状态
 */
@property (nonatomic, assign)XZZCouponState couponState;


/**
 * 未使用的优惠券
 */
@property (nonatomic, strong)NSMutableArray * unusedArray;

/**
 * 已经使用的优惠券
 */
@property (nonatomic, strong)NSMutableArray * alreadyUsedArray;

/**
 * 已经过期了的优惠券
 */
@property (nonatomic, strong)NSMutableArray * expiredArray;

/**
 * 展示的数据
 */
@property (nonatomic, strong)NSArray * dataArray;

/**
 * tableview
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * code查询视图
 */
@property (nonatomic, strong)UIView * coupodsCodeView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITextField * textField;

/**
 * 是否为空
 */
@property (nonatomic, assign)BOOL isEmpty;

@end

@implementation XZZCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.couponState = XZZCouponStateUnused;
    
    self.myTitle = @"Coupons";
    self.isEmpty = NO;
    
    WS(wSelf)
    UIView * topView = nil;
    if (!self.goodsArray) {
        XZZReplaceCouponsStateView * stateView = [XZZReplaceCouponsStateView allocInit];
        [stateView setChooseCouponsState:^(XZZCouponState state) {
            wSelf.couponState = state;
            if (state == XZZCouponStateUnused) {
                wSelf.dataArray = wSelf.unusedArray.copy;
            }else if (state == XZZCouponStateAlreadyUsed){
                wSelf.dataArray = wSelf.alreadyUsedArray.copy;
            }else{
                wSelf.dataArray = wSelf.expiredArray.copy;
            }
            [wSelf.tableView reloadData];
        }];
        [self.view addSubview:stateView];
        [stateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@45);
            make.top.left.right.equalTo(wSelf.view);
        }];
        topView = stateView;
    }
    weakView(weak_topView, topView)
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        if (weak_topView) {
            make.top.equalTo(weak_topView.mas_bottom);
        }else{
            make.top.equalTo(wSelf.view);
        }
    }];
    loadView(self.view)
    [self dataDownload];
}

- (NSMutableArray *)unusedArray
{
    if (!_unusedArray) {
        self.unusedArray = @[].mutableCopy;
    }
    return _unusedArray;
}

- (NSMutableArray *)alreadyUsedArray
{
    if (!_alreadyUsedArray) {
        self.alreadyUsedArray = @[].mutableCopy;
    }
    return _alreadyUsedArray;
}

- (NSMutableArray *)expiredArray
{
    if (!_expiredArray) {
        self.expiredArray = @[].mutableCopy;
    }
    return _expiredArray;
}

- (UIView *)coupodsCodeView
{
    if (!_coupodsCodeView) {
        UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 56)];
        view.backgroundColor = BACK_COLOR;
        
        UIView * backView = [UIView allocInitWithFrame:CGRectMake(10, 10, view.width - 10 * 2, 36)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.borderColor = kColor(0x333333).CGColor;
        backView.layer.borderWidth = .5;
        [view addSubview:backView];
        
        UIButton * button = [UIButton allocInitWithTitle:@"Apply" color:kColor(0xffffff) selectedTitle:@"Apply" selectedColor:kColor(0xffffff) font:14];
        button.backgroundColor = button_back_color;
        button.frame = CGRectMake(backView.right - 76, backView.top, 76, backView.height);
        [button addTarget:self action:@selector(couponRedemption) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        
        UITextField * textField = [UITextField allocInitWithFrame:CGRectMake(8, 0, button.left - 16, button.height)];
        textField.placeholder = @"Coupon Code";
        textField.font = textFont(14);
        [backView addSubview:textField];
        self.textField = textField;
        
        self.coupodsCodeView = view;
    }
    return _coupodsCodeView;
}

- (void)couponRedemption
{
    if (self.textField.text.length) {
        [self.textField resignFirstResponder];//取消第一响应者
        WS(wSelf)
        loadView(self.view)
        [XZZDataDownload userGetCouponsCode:self.textField.text httpBlock:^(id data, BOOL successful, NSError *error) {
            wSelf.textField.text = @"";
            if (successful) {
                SVProgressSuccess(data)
                [wSelf dataDownload];
            }else{
                if ([data isKindOfClass:[NSString class]]) {
                    SVProgressError(data)
                }else{
                    SVProgressError(@"This coupon does not exist.")
                }
                loadViewStop
            }
        }];
    }else{
        SVProgressError(@"Please enter coupon code.")
    }
}

- (void)dataDownload
{
    WS(wSelf)
    if (self.goodsArray) {
        [XZZDataDownload userGetCanUseCouponsSkuNum:self.goodsArray httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                [wSelf dealWithCouponInformation:data];
            }else{
                [wSelf dealWithCouponInformation:nil];
            }
        }];
        return;
    }
    [XZZDataDownload userGetCouponsListHttpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf dealWithCouponInformation:data];
        }else{
            [wSelf dealWithCouponInformation:nil];
        }
    }];
}
#pragma mark ----处理优惠券信息
- (void)dealWithCouponInformation:(NSArray *)couponsArray
{
    loadViewStop
    [self.unusedArray removeAllObjects];
    [self.alreadyUsedArray removeAllObjects];
    [self.expiredArray removeAllObjects];
    self.isEmpty = YES;
    for (XZZCouponsInfor * couponsInfor in couponsArray) {
        if (couponsInfor.status == 0) {
            [self.unusedArray addObject:couponsInfor];
        }else if(couponsInfor.status == 1){
            [self.alreadyUsedArray addObject:couponsInfor];
        }else{
            [self.expiredArray addObject:couponsInfor];
        }
    }
    if (self.couponState == XZZCouponStateUnused) {
        self.dataArray = self.unusedArray.copy;
    }else if (self.couponState == XZZCouponStateAlreadyUsed){
        self.dataArray = self.alreadyUsedArray.copy;
    }else{
        self.dataArray = self.expiredArray.copy;
    }

//    if(self.goodsArray){
//        self.dataArray = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//            XZZCouponsInfor * couponsInfor1 = obj1;
//            XZZCouponsInfor * couponsInfor2 = obj2;
//            return couponsInfor2.orderCanUse;
//        }];
//    }
    [self.tableView reloadData];
}

#pragma mark ----*  进入首页
/**
 *  进入首页
 */
- (void)chickOutUseIT:(XZZCouponsInfor *)couponsInfor
{
    if (couponsInfor.giftGoodsId) {
        GoodsDetails(couponsInfor.giftGoodsId, self)
        return;
    }
    
    XZZCouponGoodsListViewController * couponsGoodsListVC = [XZZCouponGoodsListViewController allocInit];
    couponsGoodsListVC.couponsInfor = couponsInfor;
    [self pushViewController:couponsGoodsListVC animated:YES];
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
    if (self.dataArray.count <= 0) {
        return self.isEmpty;
    }
    return self.dataArray.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count <= 0) {
        XZZCouponEmptyTableViewCell * cell = [XZZCouponEmptyTableViewCell codeCellWithTableView:tableView];
        [cell addView];
        return cell;
    }
    WS(wSelf)
    if (self.goodsArray.count) {
        
        XZZCouponsOrderListTableViewCell * cell = [XZZCouponsOrderListTableViewCell codeCellWithTableView:tableView];
        cell.backgroundColor = [UIColor clearColor];
        cell.couponAvailable = self.goodsArray.count;
        cell.couponsInfor = self.dataArray[indexPath.row];
        [cell setGetCouponBlock:^(XZZCouponsInfor *couponsInfor) {
            if (wSelf.chooseCoupons) {
                !wSelf.chooseCoupons?:wSelf.chooseCoupons(couponsInfor);
                [wSelf popViewControllerAnimated:YES];
            }else{
                [wSelf chickOutUseIT:couponsInfor];
            }
        }];
        return cell;
    }
    XZZCouponsListTableViewCell * cell = [XZZCouponsListTableViewCell codeCellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.couponAvailable = self.goodsArray.count;
    cell.couponsInfor = self.dataArray[indexPath.row];
    [cell setGetCouponBlock:^(XZZCouponsInfor *couponsInfor) {
        if (wSelf.chooseCoupons) {
            !wSelf.chooseCoupons?:wSelf.chooseCoupons(couponsInfor);
            [wSelf popViewControllerAnimated:YES];
        }else{
            [wSelf chickOutUseIT:couponsInfor];
        }
    }];
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count <= 0) {
        return 300;
    }
    return 115;
}
#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.couponState == XZZCouponStateUnused) {
        return self.coupodsCodeView.height;
    }
    return 0;
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.couponState == XZZCouponStateUnused) {
        return self.coupodsCodeView;
    }
    return nil;
}

#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
//    XZZCouponPopUpView * couponPopUpView = [XZZCouponPopUpView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    couponPopUpView.couponArray = self.dataArray;
//    [self.view.window addSubview:couponPopUpView];
//    [couponPopUpView bringSubviewToFront:self.view.window];
    
    
}
#pragma mark ----- tableView代理结束


@end

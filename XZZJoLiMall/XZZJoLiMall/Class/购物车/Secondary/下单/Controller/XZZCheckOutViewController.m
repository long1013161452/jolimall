//
//  XZZCheckOutViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutViewController.h"

#import "XZZPayPalViewController.h"
#import "XZZCreditCardViewController.h"
#import "XZZAddressListViewController.h"
#import "XZZPayResultsViewController.h"
#import "XZZOrderDetailsViewController.h"
#import "XZZCouponListViewController.h"

#import "XZZAsibill3PayViewController.h"

#import "XZZCheckOutContactInforView.h"
#import "XZZCheckOutAddressView.h"
#import "XZZCheckOutOptionsView.h"
#import "XZZCheckOutPaymentView.h"
#import "XZZCheckOutOrderGoodsView.h"
#import "XZZCheckOutPromoCodeView.h"
#import "XZZCheckOutPriceButtonView.h"
#import "XZZCheckOutProfitInformationView.h"
#import "XZZCheckOutChooseCouponsView.h"
#import "XZZOrderGoodsView.h"
#import "XZZCheckOutSecureCheckOutView.h"
#import "XZZCartPromptSoldOutGoodsInforView.h"

#import "XZZRequestCalculatePrice.h"

#import "XZZOrderPostageInfor.h"

#import "XZZAsiaBillPay.h"



@interface XZZCheckOutViewController ()

/**
 * 滚动视图
 */
@property (nonatomic, strong)UIScrollView * scrollView;
/**
 * 展示价格信息等
 */
@property (nonatomic, strong)XZZCheckOutPriceButtonView * priceButtonView;
/**
 * 联系方式
 */
@property (nonatomic, strong)XZZCheckOutContactInforView * contactInforView;
/**
 * 展示地址信息
 */
@property (nonatomic, strong)XZZCheckOutAddressView * addressView;
/**
 * 展示运费方式
 */
@property (nonatomic, strong)XZZCheckOutOptionsView * optionsView;
/**
 * 支付方式
 */
@property (nonatomic, strong)XZZCheckOutPaymentView * paymentView;
/**
 * 商品背景视图
 */
@property (nonatomic, strong)UIView * goodsBackView;
/**
 * 优惠码
 */
@property (nonatomic, strong)XZZCheckOutChooseCouponsView * promoCodeView;
/**
 * 利润信息提示
 */
@property (nonatomic, strong)XZZCheckOutProfitInformationView * profitInformationView;
/**
 * 赠送商品view
 */
//@property (nonatomic, strong)XZZCheckOutOrderGoodsView * couponGoodsView;
@property (nonatomic, strong)XZZOrderGoodsView * couponGoodsView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * skuNumArray;
/**
 * 购物车商品视图数组
 */
@property (nonatomic, strong)NSMutableArray * cartViewList;
/**
 * 优惠券  赠送的商品信息
 */
@property (nonatomic, strong)XZZCartInfor * couponGoods;
/**
 * 优惠券赠送的商品是否计算邮费
 */
@property (nonatomic, assign)BOOL isCalPostage;
/**
 * 来源   配送方式
 */
@property (nonatomic, strong)XZZOrderPostageInfor * postageInfor;// (string, optional),

/**
 * 优惠券信息
 */
@property (nonatomic, strong)XZZCouponsInfor * couponsInfor;

/**
 * 支付类型0 payPal支付 1.stripe信用卡 2.iplinks支付 3 wordpay支付
 */
@property (nonatomic, assign)NSInteger payType;

/**
 * 支付方式
 */
@property (nonatomic, strong)XZZPaymentType * paymentType;
/**
 * 生成的订单id
 */
@property (nonatomic, strong)NSString * orderId;

/**
 * 利润
 */
@property (nonatomic, assign)CGFloat profit;

@end

@implementation XZZCheckOutViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self readPaymentTypeHttpBlock:nil];

    [self downloadBasicInformation];
    
}

- (void)downloadBasicInformation
{
    WS(wSelf)
    [XZZDataDownload userGetBasedInformationHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            my_AppDelegate.iskol = My_Basic_Infor.isKol;
            if (my_AppDelegate.iskol && My_Basic_Infor.kolProfit > 0) {
                if (wSelf.profitInformationView.selected) {
                    wSelf.profit = My_Basic_Infor.kolProfit;
                }else{
                    wSelf.profit = 0;
                }
                
                wSelf.profitInformationView.hidden = NO;
                [wSelf.profitInformationView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@55);
                }];
            }else{
                wSelf.profit = 0;
                wSelf.profitInformationView.hidden = YES;
                [wSelf.profitInformationView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@0);
                }];
            }
            [wSelf.profitInformationView editProfitInfor];
            wSelf.priceButtonView.priceInfor.profit = wSelf.profit;
            wSelf.priceButtonView.priceInfor = wSelf.priceButtonView.priceInfor;
            [wSelf dynamicChangesRefreshView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myiskol" object:nil];
        }
    }];
    
}

#pragma mark ----读取支付类型
/**
 *  读取支付类型
 */
- (void)readPaymentTypeHttpBlock:(HttpBlock)httpBlock
{
    WS(wSelf)
    [XZZDataDownload payGetPaymentTypeHttpBlock:^(id data, BOOL successful, NSError *error) {
        !httpBlock?:httpBlock(data, successful, error);
        if (successful) {
            wSelf.paymentView.paymentTypeArr = data;
        }else{
            SVProgressError(@"Payment closed")
            [wSelf back];
        }
    }];
}

#pragma mark ----获取所有的邮费信息
/**
 *  获取所有的邮费信息
 */
- (void)getPostageInforList
{
    WS(wSelf)
    int weight = 0;
    int goodsNum = 0;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        weight += (cartInfor.weight * cartInfor.skuNum);
        goodsNum += cartInfor.skuNum;
    }
    if (self.couponGoods && self.isCalPostage) {
        weight += (self.couponGoods.weight * self.couponGoods.skuNum);
        goodsNum += self.couponGoods.skuNum;
    }
    [[XZZAllOrderPostageInfor shareAllOrderPostageInfor] getAllPostageInformationWeight:weight goodsNum:goodsNum httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf.optionsView addView];
            if (wSelf.priceButtonView.priceInfor) {
                wSelf.optionsView.goodsPrices = wSelf.priceButtonView.priceInfor.total;
            }
            [wSelf dynamicChangesRefreshView];
        }else{
            [wSelf back];
        }
    }];
}
#pragma mark ----*  计算运费信息
/**
 *  计算运费信息
 */
- (void)calculatedFreightInformation
{
    
    XZZOrderPostageInfor * postageInfor = [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray[0];
    if (postageInfor.fee >= 0) {
        [self.optionsView addView];
        [self dynamicChangesRefreshView];
    }else{
        int weight = 0;
        for (XZZCartInfor * cartInfor in self.cartInforArray) {
            weight += (cartInfor.weight * cartInfor.skuNum);
        }
        WS(wSelf)
        loadView(self.view)
        [XZZDataDownload orderGetShippingFee:weight httpBlock:^(id data, BOOL successful, NSError *error) {
            if (successful) {
                [wSelf.optionsView addView];
                [wSelf dynamicChangesRefreshView];
                loadViewStop
            }
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Check Out";
    self.nameVC = @"结算页下单";
    
    if (my_AppDelegate.iskol) {
        self.profit = My_Basic_Infor.kolProfit;
    }else{
        self.profit = 0;
    }
    
    if (User_Infor.isLogin) {
        [self.contactInforView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.contactInforView.hidden = YES;

    }else{
        [self.contactInforView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@140);
        }];
        self.contactInforView.hidden = NO;
    }
    
    self.payType = 0;
    self.postageInfor = [[XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray firstObject];
    
    [self addView];
    [self getPostageInforList];
    [self dynamicChangesRefreshView];
    self.addressView.address = [User_Infor getDefaultAddressInfor];
    [self calculatePrice:NO];
}

- (NSArray *)skuNumArray
{
    if (!_skuNumArray) {
        NSMutableArray * array = @[].mutableCopy;
        for (XZZCartInfor * cartInfor in self.cartInforArray) {
            XZZSkuNum * skuNum = [XZZSkuNum allocInit];
            skuNum.skuNum = cartInfor.skuNum;
            skuNum.skuId = cartInfor.ID;
            [array addObject:skuNum];
        }
        self.skuNumArray = array.copy;
    }
    return _skuNumArray;
}

#pragma mark ----*  计算价格
/**
 *  计算价格
 */
- (void)calculatePrice:(BOOL)sliding
{
    loadView(nil)
    WS(wSelf)
    XZZRequestCalculatePrice * calculatePrice = [XZZRequestCalculatePrice allocInit];
    calculatePrice.couponCode = self.couponsInfor.param;
    NSMutableArray * skuNumArray = self.skuNumArray.mutableCopy;

    if (self.couponGoods) {
        XZZSkuNum * skuNum = [XZZSkuNum allocInit];
        skuNum.skuNum = self.couponGoods.skuNum;
        skuNum.skuId = self.couponGoods.ID;
        skuNum.isGiftGoods = 1;
        [skuNumArray addObject:skuNum];
    }
    calculatePrice.skus = skuNumArray;
    [XZZDataDownload orderGetPrice:calculatePrice httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            XZZOrderPriceInfor * orderPriceInfor = data;
                if (orderPriceInfor.total >= wSelf.postageInfor.freeLimit && wSelf.postageInfor.freeLimit != -1) {
                    orderPriceInfor.postFeePrice = 0;
                }else{
                    orderPriceInfor.postFeePrice = wSelf.postageInfor.fee;
                }
            if (orderPriceInfor.discount <= 0) {
                if (wSelf.couponsInfor.param.length) {
                    if (wSelf.couponsInfor.goodsSku) {
                        SVProgressSuccess(@"Coupon applied successfully!");
                    }else{
                        wSelf.promoCodeView.couponCode = @"";
                        SVProgressError(@"This coupon is not valid.")
                    }
                }
            }else{
                if (wSelf.couponsInfor.param.length) {
                    SVProgressSuccess(@"Coupon applied successfully!");
                }
            }
            orderPriceInfor.profit = wSelf.profit;
            wSelf.optionsView.goodsPrices = orderPriceInfor.total;
            wSelf.priceButtonView.priceInfor = orderPriceInfor;
            [wSelf dynamicChangesRefreshView];
            if (sliding) {
                [wSelf leakageOfPriceInformation];
            }
        }else{
            if (wSelf.promoCodeView.couponCode.length) {
                wSelf.promoCodeView.couponCode = @"";
            }
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
                [wSelf back];
            }
        }
        loadViewStop
    }];
}
#pragma mark ----*  添加利润信息
/**
 *  添加利润信息
 */
- (void)addProfitInformation
{
    if (self.profitInformationView) {
        if (self.profitInformationView.selected) {
            self.profit = My_Basic_Infor.kolProfit;
        }else{
            self.profit = 0;
        }
        self.priceButtonView.priceInfor.profit = self.profit;
        self.priceButtonView.priceInfor = self.priceButtonView.priceInfor;
    }
    [self leakageOfPriceInformation];
}

#pragma mark ---- 展示出价格信息  用于计算价格后
- (void)leakageOfPriceInformation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        loadViewStop
        self.scrollView.contentSize = CGSizeMake(0, self.priceButtonView.bottom);
        [self.scrollView setContentOffset:CGPointMake(0, self.priceButtonView.bottom - self.scrollView.height) animated:YES];
    });
}


- (void)addView{
    
    WS(wSelf)
    
    XZZCheckOutSecureCheckOutView * secureCheckOutView = [XZZCheckOutSecureCheckOutView allocInit];
    [self.view addSubview: secureCheckOutView];
    [secureCheckOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
        make.height.equalTo(@40);
    }];
    weakView(weak_secureCheckOutView, secureCheckOutView)
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.top.equalTo(weak_secureCheckOutView.mas_bottom);
    }];
    
    self.addressView = [XZZCheckOutAddressView allocInit];
    [self.addressView setChooseAddress:^{//选择地址信息
        [wSelf chooesAddressInfor];
    }];
    [self.scrollView addSubview:self.addressView];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(@0);
        make.height.equalTo(@150);
    }];
    
    self.optionsView = [XZZCheckOutOptionsView allocInit];
    [self.optionsView setSelectFreight:^(XZZOrderPostageInfor * _Nonnull postageInfor) {
        wSelf.postageInfor = postageInfor;
            if (wSelf.priceButtonView.priceInfor.total >= wSelf.postageInfor.freeLimit && wSelf.postageInfor.freeLimit != -1) {
                wSelf.priceButtonView.priceInfor.postFeePrice = 0;
            }else{
                wSelf.priceButtonView.priceInfor.postFeePrice = wSelf.postageInfor.fee;
            }
        wSelf.priceButtonView.priceInfor = wSelf.priceButtonView.priceInfor;
    }];
    [self.scrollView addSubview:self.optionsView];
    [self.optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.addressView.mas_bottom);
    }];
    
    self.paymentView = [XZZCheckOutPaymentView allocInit];
    [self.paymentView setPaymentType:^(NSInteger payType) {
        wSelf.payType = payType;
    }];
    [self.paymentView setRefreshBlock:^{
        [wSelf dynamicChangesRefreshView];
    }];
    [self.scrollView addSubview:self.paymentView];
    [self.paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.optionsView.mas_bottom);
    }];
    
    XZZCheckOutTitleView * youOrderTitleView = [XZZCheckOutTitleView allocInit];
    youOrderTitleView.title = @"Your Order";
    youOrderTitleView.titleLabel.font = textFont_bold(13);
    [self.scrollView addSubview:youOrderTitleView];
    [youOrderTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.paymentView);
        make.top.equalTo(wSelf.paymentView.mas_bottom);
        make.height.equalTo(@35);
    }];
    weakView(weak_youOrderTitleView, youOrderTitleView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.scrollView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_youOrderTitleView);
        make.height.equalTo(@.5);
        make.top.equalTo(weak_youOrderTitleView.mas_baseline);
    }];
    
    
    weakView(weak_dividerView, dividerView)
    self.goodsBackView = [UIView allocInit];
    [self.scrollView addSubview:self.goodsBackView];
    [self.goodsBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_dividerView.mas_bottom);
    }];
    
    [self addItemInformation];
    
    UIView * topView = nil;

    
    weakView(weak_topView1, self.goodsBackView)
    self.couponGoodsView = [XZZOrderGoodsView allocInit];
    self.couponGoodsView.isFreeGoods = YES;
    [self.scrollView addSubview:self.couponGoodsView];
    [self.couponGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_topView1);
        make.top.equalTo(weak_topView1.mas_bottom);
        make.height.equalTo(@0);
    }];
    self.couponGoodsView.hidden = YES;
    topView = self.couponGoodsView;
    UIView * goodsDividerView = [UIView allocInit];
    goodsDividerView.backgroundColor = DIVIDER_COLOR;
    [self.scrollView addSubview:goodsDividerView];
    [goodsDividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.couponGoodsView.mas_bottom);
        make.height.equalTo(@.5);
    }];
    
    weakView(weak_topView2, topView)
    self.promoCodeView = [XZZCheckOutChooseCouponsView allocInit];
    [self.promoCodeView setChooseCouponBlock:^{
        [wSelf chooesCouponInfor];
    }];
    topView = self.promoCodeView;
    [self.scrollView addSubview:self.promoCodeView];
    [self.promoCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_topView2.mas_bottom).offset(10);
        make.height.equalTo(@55);
    }];
    
        weakView(weakTopView3, topView)

        self.profitInformationView = [XZZCheckOutProfitInformationView allocInit];
            [self.profitInformationView setGeneralBlock:^{
                [wSelf addProfitInformation];
            }];
            topView = self.profitInformationView;
            [self.scrollView addSubview:self.profitInformationView];
            [self.profitInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(wSelf.view);
                make.top.equalTo(weakTopView3.mas_bottom).offset(10);
                make.height.equalTo(@55);
            }];

    weakView(weak_topView3, topView)
    self.priceButtonView = [XZZCheckOutPriceButtonView allocInit];
    [self.priceButtonView setBlock:^{
        [wSelf getPaymentAgain];
    }];
    [self.scrollView addSubview:self.priceButtonView];
    [self.priceButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_topView3.mas_bottom).offset(10);
    }];
}

- (void)addItemInformation
{
    WS(wSelf)
    [ self.goodsBackView removeAllSubviews];
    UIView * topView = nil;
    self.cartViewList = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        weakView(weak_topView, topView)
        XZZOrderGoodsView * goodsView = [XZZOrderGoodsView allocInit];
        goodsView.cartInfor = cartInfor;
        [self.goodsBackView addSubview:goodsView];
        [self.cartViewList addObject:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            if (weak_topView) {
                make.top.equalTo(weak_topView.mas_bottom);
            }else{
                make.top.equalTo(@0);
            }
        }];
        topView = goodsView;
    }
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.goodsBackView);
    }];
}

#pragma mark ----重新获取支付方式
/**
 *  重新获取支付方式
 */
- (void)getPaymentAgain
{
    loadView(self.view)
    WS(wSelf)
    [self readPaymentTypeHttpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf determineWhetherPaymentMethodIsAvailable:data];
        }
        
    }];
}

#pragma mark ----判断支付方式是否可用
/**
 *  判断支付方式是否可用
 */
- (void)determineWhetherPaymentMethodIsAvailable:(NSArray *)typeArray
{
    if ([typeArray isKindOfClass:[NSArray class]]) {
        if (typeArray.count > 1) {
            if (self.payType != 0) {
                for (XZZPaymentType * type in typeArray) {
                    if (type.payType != 0) {
                        self.payType = type.payType;
                        self.paymentType = type;
                    }
                }
            }
            [self submitOrderPaymentOrderSettlementButtonView];
        }else if(typeArray.count){
            XZZPaymentType * type = typeArray[0];
            if (self.payType == 0) {
                if (type.payType == 0) {
                    [self submitOrderPaymentOrderSettlementButtonView];
                }else{
                    SVProgressError(@"PayPal payment has been turned off and credit card payment is automatically switched.");
                }
            }else{
                if (type.payType != 0) {
                    self.payType = type.payType;
                    self.paymentType = type;
                    [self submitOrderPaymentOrderSettlementButtonView];
                }else{
                    SVProgressError(@"Credit card payment has been turned off and automatically switched to PayPal payment.");
                }
            }
        }
    }
}




#pragma mark ----提交订单  支付
/**
 * 提交订单  支付
 */
- (void)submitOrderPaymentOrderSettlementButtonView
{
    if (self.addressView.address.ID.length <= 0 || self.addressView.address.ID.integerValue == 0) {
        SVProgressError(@"Please select address");
        return;
    }

    [self checkSeeItemHasBeenRemoved];
    return;
    
    
    if (self.payType == 0) {//paypal支付
        [self checkSeeItemHasBeenRemoved];
    }else{//信用卡支付
        XZZCreditCardViewController * cardVC = [XZZCreditCardViewController allocInit];
        cardVC.payType = self.payType;
        cardVC.requestCheckOut = self.assemblyRequestInformation;
        cardVC.addressInfor = self.addressView.address;
        cardVC.priceInfor = self.priceButtonView.priceInfor;
        [self pushViewController:cardVC animated:YES];
    }
}
#pragma mark ----*  生成下单数据信息
/**
 *  生成下单数据信息
 */
- (XZZRequestCheckOut *)assemblyRequestInformation
{
    XZZRequestCheckOut * checkOut = [XZZRequestCheckOut allocInit];
    checkOut.shippingId = self.addressView.address.ID;
    checkOut.email = User_Infor.email;
    checkOut.payType = self.payType;
    checkOut.couponCode = self.couponsInfor.param;
    checkOut.userCouponId = self.couponsInfor.ID;
    checkOut.postFeePrice =  [NSString stringWithFormat:@"%.2f", self.priceButtonView.priceInfor.postFeePrice];
    checkOut.transportId = self.postageInfor.transportId;
    checkOut.total = [NSString stringWithFormat:@"%.2f", self.priceButtonView.priceInfor.payTotal];
    if (!self.isBuyNow) {
        checkOut.sourceType = @"1";
    }else{
        checkOut.sourceType = @"0";
    }
    if (my_AppDelegate.iskol) {
        if (self.profit != 0) {
            checkOut.profit = [NSString stringWithFormat:@"%.2f", My_Basic_Infor.kolProfit];
            checkOut.profitChoose = 1;
        }else{
            checkOut.profit = @"0";
            checkOut.profitChoose = 0;
        }
    }else{
        checkOut.profitChoose = 0;
    }

//    checkOut.weight = 0;
    NSMutableArray * skuNums = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        XZZSkuNum * skuNum = [XZZSkuNum allocInit];
        skuNum.goodsCode = cartInfor.goodsCode;
        skuNum.skuId = cartInfor.ID;
        skuNum.skuNum = cartInfor.skuNum;
        [skuNums addObject:skuNum];
//        checkOut.weight += (cartInfor.weight * cartInfor.skuNum);
    }
    if (self.couponGoods) {
        XZZSkuNum * skuNum = [XZZSkuNum allocInit];
        skuNum.goodsCode = self.couponGoods.goodsCode;
        skuNum.skuId = self.couponGoods.ID;
        skuNum.skuNum = self.couponGoods.skuNum;
        skuNum.isGiftGoods = 1;
        [skuNums addObject:skuNum];
    }
    checkOut.skus = skuNums;
    return checkOut;
}
#pragma mark ---- 获取sku信息
/**
 * #pragma mark ---- 获取sku信息
 */
- (void)checkSeeItemHasBeenRemoved
{
    NSMutableArray * array = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        [array addObject:cartInfor.ID];
    }
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload cartGetSkuInforSkuIDs:array httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf processSkuInformation:data];
        }else{
            SVProgressError(@"Try again later");
        }
    }];
}

#pragma mark ---- 处理sku信息
/**
 * #pragma mark ---- 处理sku信息
 */
- (void)processSkuInformation:(NSArray *)skuList
{
//    NSArray * skus = [all_cart skuSorting:skuList];
    NSArray * skus = skuList;
    NSMutableArray * soldOutArray = @[].mutableCopy;
    NSMutableArray * cartArray = @[].mutableCopy;
    NSMutableArray * cartChangeArray = @[].mutableCopy;
    NSMutableDictionary * cartDic = @{}.mutableCopy;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        [cartDic setObject:cartInfor forKey:cartInfor.ID];
    }
    for (XZZSku * sku in skus) {
        if (sku.status == 0) {
            [soldOutArray addObject:sku];
        }else{
            XZZCartInfor * cartInfor = cartDic[sku.ID];
            XZZCartInfor * cartInforTwo = [XZZCartInfor cartInforWithSku:sku num:cartInfor.skuNum];
            [cartArray addObject:cartInforTwo];
            if (![[NSString stringWithFormat:@"%.2f", cartInfor.skuPrice] isEqualToString:[NSString stringWithFormat:@"%.2f",  cartInforTwo.skuPrice]]) {
                [cartChangeArray addObject:cartInforTwo];
            }
        }
    }
    
    if (soldOutArray.count == 0) {
        if (cartChangeArray.count) {
            [self refreshCartView:cartArray];
            SVProgressError(@"Please confirm your order before checkout as the price has changed.")
            [self calculatePrice:NO];
        }else{
            [self generateOrders];
        }
    }else{
        [self remindGodosSoldOut:soldOutArray];
    }
    
}

- (void)refreshCartView:(NSArray *)cartList
{
    self.cartInforArray = cartList;
    for (int i = 0; i < self.cartViewList.count; i++) {
        XZZOrderGoodsView * goodsView = self.cartViewList[i];
        if (i < cartList.count) {
            goodsView.cartInfor = cartList[i];
        }
    }
}

#pragma mark ---- 提醒商品下架
/**
 * #pragma mark ---- 提醒商品下架
 */
- (void)remindGodosSoldOut:(NSArray *)soldOutArray
{
    WS(wSelf)
    XZZCartPromptSoldOutGoodsInforView * view = [XZZCartPromptSoldOutGoodsInforView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.showButton = YES;
    [view setRemoveSoldOutSku:^(NSArray * _Nonnull list) {
        [wSelf removeSoldOutSkuList:list];
    }];
    [view setBlock:^{
        [wSelf back];
    }];
    view.showButton = self.cartViewList.count > soldOutArray.count;
    view.soldOutSkuArray = soldOutArray;
    [view addSuperviewView];
}

- (void)removeSoldOutSkuList:(NSArray *)lisk
{
    NSMutableDictionary * cartDic = @{}.mutableCopy;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        [cartDic setObject:cartInfor forKey:cartInfor.ID];
    }
    NSMutableArray * array = self.cartInforArray.mutableCopy;
    for (XZZSku * sku in lisk) {
        XZZCartInfor * cartInfor = cartDic[sku.ID];
        [array removeObject:cartInfor];
    }
    self.cartInforArray = array.copy;
    [self addItemInformation];
    [self leakageOfPriceInformation];
    self.skuNumArray = nil;
    [self calculatePrice:NO];
    [self getPostageInforList];
}

#pragma mark ----*  下单
/**
 *  下单
 */
- (void)generateOrders
{
    loadView(self.view)
    WS(wSelf)
    [XZZDataDownload orderCheckOut:[self assemblyRequestInformation] httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            wSelf.orderId = data;
            [wSelf orderPay:data];
        }else{
            
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
            }else{
                SVProgressError(@"Try again later");
            }
        }
        [all_cart getAllCartHttpBlock:nil];
    }];
}
#pragma mark ----*  支付请求
/**
 *  支付请求
 */
- (void)orderPay:(NSString *)orderId
{
    
    if (self.payType != 0) {//paypal支付
        
        [XZZBuriedPoint payOrderId:orderId payType:self.payType];
        if (self.payType == 7) {
            [self asiabill3Pay:orderId];
            return;
        }
        XZZCreditCardViewController * cardVC = [XZZCreditCardViewController allocInit];
        cardVC.orderId = orderId;
        cardVC.payType = self.payType;
        cardVC.requestCheckOut = self.assemblyRequestInformation;
        cardVC.addressInfor = self.addressView.address;
        cardVC.priceInfor = self.priceButtonView.priceInfor;
        [self pushViewController:cardVC animated:YES];
        return;
    }
    
    
    
    WS(wSelf)
    loadView(self.view)
    XZZRequestOrderPay * orderPay = [XZZRequestOrderPay allocInit];
    orderPay.orderId = orderId;
    orderPay.payType = self.payType;
    orderPay.payAmount = [NSString stringWithFormat:@"%.2f", self.priceButtonView.priceInfor.payTotal];
    [XZZDataDownload payGetOrderPay:orderPay httpCodeBlock:^(id data, int code, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            if (wSelf.payType == 0) {
                [wSelf paypalPay:data];
            }
        }else{
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
                if (code == 80011009 || code == 80011010) {
                    XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
                    orderDetailsVC.orderID = wSelf.orderId;
                    [wSelf pushViewController:orderDetailsVC animated:YES];
                    return ;
                }
            }else{
                SVProgressError(@"Try again later");
            }
            [wSelf payForResults:NO];
        }
    }];
}

- (void)asiabill3Pay:(NSString *)orderId
{
    loadView(self.view)
    XZZRequestOrderPay * orderPay = [XZZRequestOrderPay allocInit];
    orderPay.orderId = orderId;
    orderPay.payType = self.payType;
    orderPay.email = User_Infor.email;
    orderPay.currency = @"USD";
    orderPay.payAmount = [NSString stringWithFormat:@"%.2f", self.priceButtonView.priceInfor.payTotal];
    WS(wSelf)
    [XZZDataDownload payGetOrderPay:orderPay httpCodeBlock:^(id data, int code, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            XZZAsiaBillPay * asiaBillPay = data;
            
            XZZAsibill3PayViewController * vc = [XZZAsibill3PayViewController allocInit];
            vc.asiaBillPay = asiaBillPay;
            vc.orderId = orderId;
            [wSelf pushViewController:vc animated:YES];
        }else{
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
                if (code == 80011009 || code == 80011010) {
                    XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
                    orderDetailsVC.orderID = wSelf.orderId;
                    [wSelf pushViewController:orderDetailsVC animated:YES];
                    return ;
                }
            }else{
                SVProgressError(@"Try again later");
            }
        }


        
    }];
}

#pragma mark ----*  paypal支付  打开url
/**
 *  paypal支付  打开url
 */
- (void)paypalPay:(NSString *)url
{
    XZZPayPalViewController * paypalVC = [XZZPayPalViewController allocInit];
    paypalVC.orderId = self.orderId;
    paypalVC.payPalUrlStr = url;
    paypalVC.firstPayment = YES;
    paypalVC.numItems = self.numItems;
    [self pushViewController:paypalVC animated:YES];
}

#pragma mark ----*  进入支付结果页面
/**
 *  进入支付结果页面
 */
- (void)payForResults:(BOOL)successful
{
    loadViewStop
    XZZPayResultsViewController * payResultsVC = [XZZPayResultsViewController allocInit];
    payResultsVC.payResults = successful;
    payResultsVC.payType = 3;
    payResultsVC.orderId = self.orderId;
    [self pushViewController:payResultsVC animated:YES];
}

#pragma mark ----*  选择地址信息
/**
 *  选择地址信息
 */
- (void)chooesAddressInfor
{
    WS(wSelf)
    XZZAddressListViewController * addressListVC = [XZZAddressListViewController allocInit];
    addressListVC.address = self.addressView.address;
    addressListVC.isSelectAddress = YES;
    [addressListVC setSelectedAddress:^(XZZAddressInfor *address) {
        wSelf.addressView.address = address;
    }];
    [self pushViewController:addressListVC animated:YES];
}
#pragma mark ----*  选择优惠券信息
/**
 *  选择优惠券信息
 */
- (void)chooesCouponInfor
{
    NSMutableArray * array = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        [array addObject:@{@"num" : @(cartInfor.skuNum), @"skuId" : cartInfor.ID}];
    }
    
    WS(wSelf)
    XZZCouponListViewController * couponListVC = [XZZCouponListViewController allocInit];
    couponListVC.goodsArray = array;
    [couponListVC setChooseCoupons:^(XZZCouponsInfor *couponsInfor) {
        [wSelf processSelectCouponInformation:couponsInfor];
    }];
    [self pushViewController:couponListVC animated:YES];
}
#pragma mark ----*  处理选择的优惠券信息
/**
 *  处理选择的优惠券信息
 */
- (void)processSelectCouponInformation:(XZZCouponsInfor *)couponsInfor
{
    self.couponsInfor = couponsInfor;
    self.couponGoods = nil;
    if (couponsInfor.goodsSku) {
        self.couponGoods = [XZZCartInfor cartInforWithSku:couponsInfor.goodsSku num:1];
        self.isCalPostage = couponsInfor.isCalPostage;
        self.couponGoods.weight = couponsInfor.weight;
        self.couponGoodsView.cartInfor = self.couponGoods;
        
        self.couponGoodsView.hidden = NO;
        [self.couponGoodsView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@90);
            make.height.equalTo(@152);
        }];
    }else{
        self.couponGoodsView.hidden = YES;
        [self.couponGoodsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    if (couponsInfor.giftGoodsId) {
        self.promoCodeView.couponCode =  couponsInfor.giftCopyWriting;
    }else if (couponsInfor.discountPercent) {
        self.promoCodeView.couponCode =  couponsInfor.discountPercent;
    }else{
        self.promoCodeView.couponCode =  couponsInfor.discountMoney;
    }
//    self.promoCodeView.couponCode = couponsInfor.code;
    
    [self getPostageInforList];
    
    [self calculatePrice:YES];
    
    [self dynamicChangesRefreshView];
}

#pragma mark ----*  动态延时刷新视图
/**
 *  动态延时刷新视图
 */
- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.scrollView.contentSize = CGSizeMake(0, wSelf.priceButtonView.bottom);
    });
}

- (NSInteger)numItems
{
    NSInteger count = 0;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        count += cartInfor.skuNum;
    }
    return count;
}

- (void)addOrEditorAddressInforSuccessfully:(XZZAddressInfor *)address newAddressInfor:(XZZAddressInfor *)newAddress
{
    WS(wSelf)
    loadView(self.view)
    [User_Infor getAddressListHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.addressView.address = User_Infor.getDefaultAddressInfor;
        }else{
            loadViewStop
        }
    }];
}


@end

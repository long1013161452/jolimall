//
//  XZZCheckOutPaymentViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutPaymentViewController.h"

#import "XZZCheckOutGoodsAndPriceInforView.h"
#import "XZZCheckOutShowAddressInforView.h"
#import "XZZCheckOutEmailInforView.h"
#import "XZZCheckOutPaymentView.h"
#import "XZZCheckOutSelectedFreightView.h"

#import "XZZCheckOutProfitInformationView.h"
#import "XZZCheckOutChooseCouponsView.h"
#import "XZZCheckOutBouncedEditAddressView.h"
#import "XZZCheckOutBouncedSelectPostageView.h"

#import "XZZOrderDetailsViewController.h"
#import "XZZPayPalViewController.h"
#import "XZZPayResultsViewController.h"
#import "XZZCreditCardViewController.h"

@interface XZZCheckOutPaymentViewController ()

/**
 * 下单数据信息
 */
@property (nonatomic, strong)XZZRequestCheckOut * checkOut;

/**
 * sku num 数组
 */
@property (nonatomic, strong)NSArray * skuNumArray;
/**
 * 滚动视图
 */
@property (nonatomic, strong)UIScrollView * scrollView;
/**
 * 商品信息与价格信息
 */
@property (nonatomic, strong)XZZCheckOutGoodsAndPriceInforView * goodsAndPriceInforView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutShowAddressInforView * showAddressInforView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutSelectedFreightView * selectedFreightView;
/**
 * 优惠码
 */
@property (nonatomic, strong)XZZCheckOutChooseCouponsView * promoCodeView;
/**
 * 利润信息提示
 */
@property (nonatomic, strong)XZZCheckOutProfitInformationView * profitInformationView;
/**
 * 支付方式
 */
@property (nonatomic, strong)XZZCheckOutPaymentView * paymentView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutBouncedEditAddressView * bouncedEditAddressView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutBouncedSelectPostageView * bouncedSelectPostageView ;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * returnLabel;

/**
 * 支付类型0 payPal支付 1.stripe信用卡 2.iplinks支付 3 wordpay支付
 */
@property (nonatomic, assign)NSInteger payType;

/**
 * 生成的订单id
 */
@property (nonatomic, strong)NSString * orderId;

/**
 * 利润
 */
@property (nonatomic, assign)CGFloat profit;
@end

@implementation XZZCheckOutPaymentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.goodsAndPriceInforView.priceInfor = self.checkOutData.priceInfor;
    self.showAddressInforView.address = self.checkOutData.addressInfor;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.goodsAndPriceInforView shutDownProductInformation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTitle = @"Complete order";
    
    if (my_AppDelegate.iskol) {
        self.profit = My_Basic_Infor.kolProfit;
    }else{
        self.profit = 0;
    }
    
    WS(wSelf)
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    [self addView];
    [self readPaymentTypeHttpBlock:nil];
}

#pragma mark ----*  计算价格
/**
 *  计算价格
 */
- (void)calculatePrice
{
    XZZRequestCalculatePrice * calculatePrice = [XZZRequestCalculatePrice allocInit];
    calculatePrice.couponCode = self.checkOutData.couponsInfor.param;
    if (self.skuNumArray.count){
        calculatePrice.skus = self.skuNumArray;
    }
    WS(wSelf)
    [XZZDataDownload orderGetPrice:calculatePrice httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            XZZOrderPriceInfor * orderPriceInfor = data;
            if (orderPriceInfor.total >= wSelf.checkOutData.postageInfor.freeLimit && wSelf.checkOutData.postageInfor.freeLimit != -1) {
                orderPriceInfor.postFeePrice = 0;
            }else{
                orderPriceInfor.postFeePrice = wSelf.checkOutData.postageInfor.fee;
            }
            if (orderPriceInfor.discount <= 0) {
                if (wSelf.checkOutData.couponsInfor.param.length) {
                    SVProgressError(@"This coupon is not valid.")
                }
            }else{
                if (wSelf.checkOutData.couponsInfor.param.length) {
                    SVProgressSuccess(@"Coupon applied successfully!");
                }
            }
            wSelf.checkOutData.priceInfor = orderPriceInfor;
            wSelf.goodsAndPriceInforView.priceInfor = orderPriceInfor;
        }else{
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
    for (XZZCartInfor * cartInfor in self.checkOutData.cartInforArray) {
        weight += (cartInfor.weight * cartInfor.skuNum);
        goodsNum += cartInfor.skuNum;
    }
    loadView(self.view)
    [[XZZAllOrderPostageInfor shareAllOrderPostageInfor] getAllPostageInformationWeight:weight goodsNum:goodsNum httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            wSelf.bouncedSelectPostageView.postageInfor = wSelf.checkOutData.postageInfor;
            [wSelf.bouncedSelectPostageView addView];
            if (wSelf.goodsAndPriceInforView.priceInfor) {
                wSelf.bouncedSelectPostageView.goodsPrices = wSelf.goodsAndPriceInforView.priceInfor.total;
            }
            [wSelf.bouncedSelectPostageView addSuperviewView];
        }else{
            [wSelf back];
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

- (NSArray *)skuNumArray
{
    if (!_skuNumArray) {
        NSMutableArray * array = @[].mutableCopy;
        for (XZZCartInfor * cartInfor in self.checkOutData.cartInforArray) {
            XZZSkuNum * skuNum = [XZZSkuNum allocInit];
            skuNum.skuNum = cartInfor.skuNum;
            skuNum.skuId = cartInfor.ID;
            [array addObject:skuNum];
        }
        self.skuNumArray = array.copy;
    }
    return _skuNumArray;
}

- (XZZCheckOutBouncedEditAddressView *)bouncedEditAddressView
{
    if (!_bouncedEditAddressView) {
        XZZSelectCountryInforViewModel * selectCountryInforViewModel = [XZZSelectCountryInforViewModel allocInit];
        selectCountryInforViewModel.VC = self;
        
        WS(wSelf)
        self.bouncedEditAddressView = [XZZCheckOutBouncedEditAddressView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bouncedEditAddressView.VC = self;
        _bouncedEditAddressView.selectCountryInforViewModel = selectCountryInforViewModel;
        [_bouncedEditAddressView setEditAddressInforBlock:^{
            [wSelf editAddressInfor];
        }];
    }
    return _bouncedEditAddressView;
}

- (XZZCheckOutBouncedSelectPostageView *)bouncedSelectPostageView
{
    if (!_bouncedSelectPostageView) {
        WS(wSelf)
        self.bouncedSelectPostageView = [XZZCheckOutBouncedSelectPostageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bouncedSelectPostageView.VC = self;
        _bouncedSelectPostageView.goodsPrices = self.goodsAndPriceInforView.priceInfor.total;
        [_bouncedSelectPostageView setSelectFreight:^(XZZOrderPostageInfor * _Nonnull postageInfor) {
            wSelf.checkOutData.postageInfor = postageInfor;
            if (wSelf.goodsAndPriceInforView.priceInfor.total >= wSelf.checkOutData.postageInfor.freeLimit && wSelf.checkOutData.postageInfor.freeLimit != -1) {
                wSelf.goodsAndPriceInforView.priceInfor.postFeePrice = 0;
            }else{
                wSelf.goodsAndPriceInforView.priceInfor.postFeePrice = wSelf.checkOutData.postageInfor.fee;
            }
            wSelf.goodsAndPriceInforView.priceInfor = wSelf.goodsAndPriceInforView.priceInfor;
            [wSelf.selectedFreightView setPostage:wSelf.checkOutData.priceInfor.postFeePrice name:wSelf.checkOutData.postageInfor.name];
        }];
        _bouncedSelectPostageView.postageInfor = self.checkOutData.postageInfor;
    }
    return _bouncedSelectPostageView;
}

- (void)editAddressInfor
{
    XZZCheckOutEditAddressInforView * editAddressInforView = self.bouncedEditAddressView.editAddressInforView;
    if (editAddressInforView.firstNameView.textField.text.length <= 0) {
        [editAddressInforView.firstNameView inputUnfilledContent];
        return;
    }
    if (editAddressInforView.lastNameView.textField.text.length <= 0) {
        [editAddressInforView.lastNameView inputUnfilledContent];
        return;
    }
    if (editAddressInforView.address1View.textField.text.length <= 0) {
        [editAddressInforView.address1View inputUnfilledContent];
        return;
    }
    if (editAddressInforView.countryView.textField.text.length <= 0) {
        [editAddressInforView.countryView inputUnfilledContent];
        return;
    }
    if (editAddressInforView.provinceView.textField.text.length <= 0) {
        [editAddressInforView.provinceView inputUnfilledContent];
        return;
    }
    if (editAddressInforView.cityView.textField.text.length <= 0) {
        [editAddressInforView.cityView inputUnfilledContent];
        return;
    }
    if (editAddressInforView.zipView.textField.text.length <= 0) {
        [editAddressInforView.zipView inputUnfilledContent];
        return;
    }
    XZZAddressInfor * addressInfor = [XZZAddressInfor allocInit];
    
    addressInfor.firstName = editAddressInforView.firstNameView.textField.text;
    addressInfor.lastName = editAddressInforView.lastNameView.textField.text;
    addressInfor.detailAddress1 = editAddressInforView.address1View.textField.text;
    addressInfor.detailAddress2 = editAddressInforView.address2View.textField.text;
    addressInfor.countryName = editAddressInforView.countryView.textField.text;
    addressInfor.countryId = editAddressInforView.selectCountryInforViewModel.countryInfor.ID;
    addressInfor.countryCode = editAddressInforView.selectCountryInforViewModel.countryInfor.countryCode;
    addressInfor.provinceName = editAddressInforView.provinceView.textField.text;
    addressInfor.provinceId = editAddressInforView.selectCountryInforViewModel.provinceInfor.ID;
    addressInfor.provinceCode = editAddressInforView.selectCountryInforViewModel.provinceInfor.provinceCode;
    addressInfor.cityName = editAddressInforView.cityView.textField.text;
    addressInfor.cityId = editAddressInforView.selectCountryInforViewModel.cityInfor.ID;
    addressInfor.zipCode = editAddressInforView.zipView.textField.text;
    addressInfor.phone = editAddressInforView.phoneView.textField.text;
    
    loadView(self.view)
    WS(wSelf)
    if ([self.checkOutData.addressInfor isContrastSame:addressInfor]) {
        loadViewStop
        [self.bouncedEditAddressView removeView];
    }else{
        [User_Infor modifyAddress:self.checkOutData.addressInfor newAddress:addressInfor httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                wSelf.addressInfor = data;
                [wSelf.bouncedEditAddressView removeView];
            }else{
                SVProgressError(@"Shipping address modified failed")
            }
        }];
    }
}

- (void)setAddressInfor:(XZZAddressInfor *)addressInfor
{
    
    self.checkOutData.addressInfor = addressInfor;
    self.showAddressInforView.address = addressInfor;
}

#pragma mark ----*  创建视图信息
/**
 *  创建视图信息
 */
- (void)addView
{
    WS(wSelf)
    self.goodsAndPriceInforView = [XZZCheckOutGoodsAndPriceInforView allocInit];
    self.goodsAndPriceInforView.isShowShipping = YES;
    self.goodsAndPriceInforView.cartInforArray = self.checkOutData.cartInforArray;
    self.goodsAndPriceInforView.priceInfor = self.checkOutData.priceInfor;
    [self.goodsAndPriceInforView setChooseCouponsInfor:^{
        [wSelf chooesCouponInfor];
    }];
    [self.goodsAndPriceInforView setReloadView:^{
        [wSelf dynamicChangesRefreshView];
    }];
    self.goodsAndPriceInforView.isHiddenCoupon = my_AppDelegate.iskol;
    [self.scrollView addSubview:self.goodsAndPriceInforView];
    [self.goodsAndPriceInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(wSelf.view);
    }];
    
    XZZCheckOutEmailInforView * emailInforView = [XZZCheckOutEmailInforView allocInit];
    [self.scrollView addSubview:emailInforView];
    [emailInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.goodsAndPriceInforView.mas_bottom);
    }];
    
    weakView(weak_emailInforView, emailInforView)
    self.showAddressInforView = [XZZCheckOutShowAddressInforView allocInit];
    self.showAddressInforView.address = self.checkOutData.addressInfor;
    [self.showAddressInforView setChangeAddress:^{
        wSelf.bouncedEditAddressView.addressInfor = wSelf.checkOutData.addressInfor;
        [wSelf.bouncedEditAddressView addSuperviewView];
    }];
    [self.scrollView addSubview:self.showAddressInforView];
    [self.showAddressInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_emailInforView.mas_bottom);
        make.height.equalTo(@150);
    }];
    
    self.selectedFreightView = [XZZCheckOutSelectedFreightView allocInit];
    [self.selectedFreightView setPostage:self.checkOutData.priceInfor.postFeePrice name:self.checkOutData.postageInfor.name];
    [self.selectedFreightView setChangePostage:^{
        
        [wSelf getPostageInforList];
    }];
    [self.scrollView addSubview:self.selectedFreightView];
    [self.selectedFreightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.showAddressInforView.mas_bottom);
    }];
    UIView * topView = self.selectedFreightView;
    if (my_AppDelegate.iskol) {
        if (My_Basic_Infor.kolProfit > 0) {
            
            UILabel * profitLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
            profitLabel.text = @"Method";
            profitLabel.font = textFont_bold(13);
            [self.scrollView addSubview:profitLabel];
            [profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@11);
                make.top.equalTo(wSelf.selectedFreightView.mas_bottom);
                make.height.equalTo(@35);
            }];
            weakView(weak_profitLabel, profitLabel)
            self.profitInformationView = [XZZCheckOutProfitInformationView allocInit];
            [self.profitInformationView setGeneralBlock:^{
                [wSelf addProfitInformation];
            }];
            topView = self.profitInformationView;
            [self.scrollView addSubview:self.profitInformationView];
            self.profitInformationView.selected = self.checkOutData.selectedProfit.boolValue;
            [self.profitInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(wSelf.view);
                make.top.equalTo(weak_profitLabel.mas_bottom);
            }];
        }
        
    }else{
        UILabel * discountLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
        discountLabel.font = textFont_bold(13);
        discountLabel.text = @"Discount";
        [self.scrollView addSubview:discountLabel];
        [discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@11);
            make.top.equalTo(wSelf.selectedFreightView.mas_bottom);
            make.height.equalTo(@35);
        }];
        weakView(weak_discountLabel, discountLabel)
        self.promoCodeView = [XZZCheckOutChooseCouponsView allocInit];
        [self.promoCodeView setChooseCouponBlock:^{
            [wSelf chooesCouponInfor];
        }];
        topView = self.promoCodeView;
        [self.scrollView addSubview:self.promoCodeView];
        [self.promoCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.top.equalTo(weak_discountLabel.mas_bottom);
            make.height.equalTo(@55);
        }];
    }
    weakView(weak_topView, topView)
    self.paymentView = [XZZCheckOutPaymentView allocInit];
    [self.paymentView setPaymentType:^(NSInteger payType) {
        wSelf.payType = payType;
    }];
    [self.scrollView addSubview:self.paymentView];
    [self.paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_topView.mas_bottom);
        make.height.equalTo(@115);
    }];
    
    UIButton * button = [UIButton allocInitWithTitle:@"Complete order" color:kColor(0xffffff) selectedTitle:@"Complete order" selectedColor:kColor(0xffffff) font:18];
    [button addTarget:self action:@selector(checkOutCompleteOrderButton) forControlEvents:(UIControlEventTouchUpInside)];
    button.titleLabel.font = textFont_bold(18);
    button.backgroundColor = button_back_color;
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    [self.scrollView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(wSelf.paymentView.mas_bottom).offset(10);
        make.centerX.equalTo(wSelf.view);
        make.height.equalTo(@45);
    }];
    
    weakView(weak_button, button)
    UILabel * returnLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentCenter) tag:1];
    returnLabel.text = @"Return";
    [returnLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    returnLabel.userInteractionEnabled = YES;
    [self.scrollView addSubview:returnLabel];
    self.returnLabel = returnLabel;
    [returnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(weak_button.mas_bottom).offset(30);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = kColor(0x000000);
    [self.scrollView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.bottom.equalTo(wSelf.returnLabel);
        make.height.equalTo(@.5);
    }];
    
    [self dynamicChangesRefreshView];
}

- (void)checkOutCompleteOrderButton
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
    if (self.checkOutData.addressInfor.ID.length <= 0 || self.checkOutData.addressInfor.ID.integerValue == 0) {
        SVProgressError(@"Please select address");
        return;
    }
    loadView(self.view)
    WS(wSelf)
    [XZZDataDownload orderCheckOut:[self assemblyRequestInformation] httpBlock:^(id data, BOOL successful, NSError *error) {
        [all_cart getAllCartHttpBlock:nil];
        if (successful) {
            wSelf.orderId = data;
            [wSelf orderPay:data];
        }else{
            
            loadViewStop
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
            }else{
                SVProgressError(@"Try again later");
            }
            
            
            [wSelf backFirstPage];
        }
        
    }];
}

- (void)backFirstPage
{
    for (NSInteger i = self.navigationController.viewControllers.count - 1; i >= 0; i--) {
        UIViewController * VC = self.navigationController.viewControllers[i];
        if ([VC isKindOfClass:NSClassFromString(@"XZZCheckOutAddressViewController")]) {
            self.checkOutData.postageInfor = nil;
            self.checkOutData.priceInfor.postFeePrice = 0;
            self.checkOutData.couponsInfor = nil;
            self.checkOutData.priceInfor.profit = 0;
            self.checkOutData.selectedProfit = nil;
            
            [self popToViewController:VC animated:YES];
            return;
        }
    }
    [self back];
}

#pragma mark ----*  支付请求
/**
 *  支付请求
 */
- (void)orderPay:(NSString *)orderId
{
    WS(wSelf)
    self.orderId = orderId;
    if (self.payType != 0) {
        loadView(self.view)
        [XZZDataDownload orderGetOrderDetailsOrderId:orderId httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                XZZCreditCardViewController * cardVC = [XZZCreditCardViewController allocInit];
                cardVC.orderDetail = data;
                cardVC.orderId = wSelf.orderId;
                cardVC.payType = wSelf.payType;
                cardVC.addressInfor = wSelf.checkOutData.addressInfor;
                [self pushViewController:cardVC animated:YES];
            }else{
                XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
                orderDetailsVC.orderID = wSelf.orderId;
                [wSelf pushViewController:orderDetailsVC animated:YES];
            }
        }];
        return;
    }
    
    
    loadView(self.view)
    XZZRequestOrderPay * orderPay = [XZZRequestOrderPay allocInit];
    orderPay.orderId = orderId;
    orderPay.payType = self.payType;
    orderPay.payAmount = [NSString stringWithFormat:@"%.2f", self.goodsAndPriceInforView.priceInfor.payTotal];
    [XZZDataDownload payGetOrderPay:orderPay httpCodeBlock:^(id data, int code, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            if (wSelf.payType == 0) {
                [wSelf paypalPay:data];
            }
        }else{
            XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
            orderDetailsVC.orderID = wSelf.orderId;
            [wSelf pushViewController:orderDetailsVC animated:YES];
        }
    }];
}

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




- (XZZRequestCheckOut *)assemblyRequestInformation
{
    XZZRequestCheckOut * checkOut = [XZZRequestCheckOut allocInit];
    checkOut.shippingId = self.checkOutData.addressInfor.ID;
    checkOut.email = User_Infor.email;
    checkOut.payType = self.payType;
    checkOut.couponCode = self.checkOutData.couponsInfor.param;
    checkOut.userCouponId = self.checkOutData.couponsInfor.ID;
    checkOut.postFeePrice =  [NSString stringWithFormat:@"%.2f", self.goodsAndPriceInforView.priceInfor.postFeePrice];
    checkOut.transportId = self.checkOutData.postageInfor.transportId;
    checkOut.total = [NSString stringWithFormat:@"%.2f", self.goodsAndPriceInforView.priceInfor.payTotal];
    if (!self.checkOutData.isBuyNow) {
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
    for (XZZCartInfor * cartInfor in self.checkOutData.cartInforArray) {
        XZZSkuNum * skuNum = [XZZSkuNum allocInit];
        skuNum.goodsCode = cartInfor.goodsCode;
        skuNum.skuId = cartInfor.ID;
        skuNum.skuNum = cartInfor.skuNum;
        [skuNums addObject:skuNum];
        //        checkOut.weight += (cartInfor.weight * cartInfor.skuNum);
    }
    checkOut.skus = skuNums;
    return checkOut;
}

#pragma mark ----*  添加利润信息
/**
 *  添加利润信息
 */
- (void)addProfitInformation
{
    if (self.profitInformationView) {
        if (self.profitInformationView.selected) {
            self.checkOutData.selectedProfit = @"1";
            self.profit = My_Basic_Infor.kolProfit;
        }else{
            self.profit = 0;
            self.checkOutData.selectedProfit = @"0";
        }
        self.goodsAndPriceInforView.priceInfor.profit = self.profit;
        self.goodsAndPriceInforView.priceInfor = self.goodsAndPriceInforView.priceInfor;
    }
}

#pragma mark ----*  动态延时刷新视图
/**
 *  动态延时刷新视图
 */
- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.scrollView.contentSize = CGSizeMake(0, wSelf.returnLabel.bottom + 20);
    });
}

#pragma mark ----*  选择优惠券信息
/**
 *  选择优惠券信息
 */
- (void)chooesCouponInfor
{
    NSMutableArray * array = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.checkOutData.cartInforArray) {
        [array addObject:@{@"num" : @(cartInfor.skuNum), @"skuId" : cartInfor.ID}];
    }
    
    WS(wSelf)
    XZZCouponListViewController * couponListVC = [XZZCouponListViewController allocInit];
    couponListVC.goodsArray = array;
    [couponListVC setChooseCoupons:^(XZZCouponsInfor *couponsInfor) {
        wSelf.checkOutData.couponsInfor = couponsInfor;
        [wSelf calculatePrice];
    }];
    [self pushViewController:couponListVC animated:YES];
}

- (NSInteger)numItems
{
    NSInteger count = 0;
    for (XZZCartInfor * cartInfor in self.checkOutData.cartInforArray) {
        count += cartInfor.skuNum;
    }
    return count;
}

@end

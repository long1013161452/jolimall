//
//  XZZCheckOutPostageViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutPostageViewController.h"

#import "XZZCheckOutGoodsAndPriceInforView.h"
#import "XZZCheckOutEmailInforView.h"
#import "XZZCheckOutShowAddressInforView.h"
#import "XZZCheckOutOptionsView.h"
#import "XZZCheckOutBouncedEditAddressView.h"

#import "XZZCheckOutPaymentViewController.h"


@interface XZZCheckOutPostageViewController ()
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
 * 展示运费方式
 */
@property (nonatomic, strong)XZZCheckOutOptionsView * optionsView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * returnLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutBouncedEditAddressView * bouncedEditAddressView;




@end

@implementation XZZCheckOutPostageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.goodsAndPriceInforView.priceInfor = self.checkOutData.priceInfor;
    self.showAddressInforView.address = self.checkOutData.addressInfor;
    self.optionsView.postageInfor = self.checkOutData.postageInfor;
    
    [self getPostageInforList];
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
    WS(wSelf)
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    [self addView];
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
            [wSelf.optionsView addView];
            if (wSelf.goodsAndPriceInforView.priceInfor) {
                wSelf.optionsView.goodsPrices = wSelf.goodsAndPriceInforView.priceInfor.total;
            }
            
            [wSelf dynamicChangesRefreshView];
        }else{
            [wSelf back];
        }
    }];
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
    
    self.optionsView = [XZZCheckOutOptionsView allocInit];
    self.optionsView.postageInfor = self.checkOutData.postageInfor;
    [self.optionsView setSelectFreight:^(XZZOrderPostageInfor * _Nonnull postageInfor) {
        wSelf.checkOutData.postageInfor = postageInfor;
        if (wSelf.goodsAndPriceInforView.priceInfor.total >= wSelf.checkOutData.postageInfor.freeLimit && wSelf.checkOutData.postageInfor.freeLimit != -1) {
            wSelf.goodsAndPriceInforView.priceInfor.postFeePrice = 0;
        }else{
            wSelf.goodsAndPriceInforView.priceInfor.postFeePrice = wSelf.checkOutData.postageInfor.fee;
        }
        wSelf.goodsAndPriceInforView.priceInfor = wSelf.goodsAndPriceInforView.priceInfor;
    }];
    [self.scrollView addSubview:self.optionsView];
    [self.optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.showAddressInforView.mas_bottom);
    }];
    
    UIButton * button = [UIButton allocInitWithTitle:@"Continue to payment" color:kColor(0xffffff) selectedTitle:@"Continue to payment" selectedColor:kColor(0xffffff) font:18];
    [button addTarget:self action:@selector(checkOutContinuePaymentButton) forControlEvents:(UIControlEventTouchUpInside)];
    button.titleLabel.font = textFont_bold(18);
    button.backgroundColor = button_back_color;
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    [self.scrollView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(wSelf.optionsView.mas_bottom).offset(10);
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
    
}

- (void)checkOutContinuePaymentButton
{
    XZZCheckOutPaymentViewController * paymentVC = [XZZCheckOutPaymentViewController allocInit];
    paymentVC.checkOutData = self.checkOutData;
    [self pushViewController:paymentVC animated:YES];
}

- (void)setAddressInfor:(XZZAddressInfor *)addressInfor
{
    
    self.checkOutData.addressInfor = addressInfor;
    
    self.showAddressInforView.address = addressInfor;
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


@end

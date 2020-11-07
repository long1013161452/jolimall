//
//  XZZCheckOutAddressViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutAddressViewController.h"
#import "XZZCouponListViewController.h"
#import "XZZCheckOutPostageViewController.h"

#import "XZZCheckOutGoodsAndPriceInforView.h"
#import "XZZCheckOutUserInforView.h"
#import "XZZCheckOutEditAddressInforView.h"

#import "XZZSelectCountryInforViewModel.h"

@interface XZZCheckOutAddressViewController ()
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
 * 用户信息
 */
@property (nonatomic, strong)XZZCheckOutUserInforView * userInforView;
/**
 * 编辑地址信息
 */
@property (nonatomic, strong)XZZCheckOutEditAddressInforView * editAddressInforView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * returnLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutData * checkOutData;
@end

@implementation XZZCheckOutAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.checkOutData.postageInfor) {
        self.goodsAndPriceInforView.isShowShipping = YES;
    }else{
        self.goodsAndPriceInforView.isShowShipping = NO;
    }
    [self calculatePrice:NO];
    self.goodsAndPriceInforView.priceInfor = self.checkOutData.priceInfor;
    if (![self.checkOutData.addressInfor.ID isEqualToString:self.editAddressInforView.addressInfor.ID]) {
        self.editAddressInforView.addressInfor = self.checkOutData.addressInfor;
    }
    
    [self DownloadBasicInformation];
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
    
    loadView(self.view)
    [User_Infor getAddressListHttpBlock:^(id data, BOOL successful, NSError *error) {
        wSelf.addressInfor = [User_Infor getDefaultAddressInfor];
        loadViewStop
    }];
    
    
    
    [self calculatePrice:NO];
    [self dynamicChangesRefreshView];
    
}

- (XZZCheckOutData *)checkOutData{
    if (!_checkOutData) {
        self.checkOutData = [XZZCheckOutData allocInit];
        _checkOutData.isBuyNow = self.isBuyNow;
        _checkOutData.cartInforArray = self.cartInforArray;
    }
    return _checkOutData;
}

- (void)DownloadBasicInformation
{
    WS(wSelf)
    [XZZDataDownload userGetBasedInformationHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (!successful) {
            wSelf.goodsAndPriceInforView.isHiddenCoupon = my_AppDelegate.iskol;
        }else{
            my_AppDelegate.iskol = My_Basic_Infor.isKol;
            if (my_AppDelegate.iskol) {
                wSelf.checkOutData.couponsInfor = nil;
                [wSelf calculatePrice:NO];
            }else{
                wSelf.checkOutData.priceInfor.profit = 0;
            }
            wSelf.goodsAndPriceInforView.isHiddenCoupon = my_AppDelegate.iskol;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myiskol" object:nil];
        }
    }];
    
}

#pragma mark ----*  计算价格
/**
 *  计算价格
 */
- (void)calculatePrice:(BOOL)isChooseCoupon
{
    WS(wSelf)
    XZZRequestCalculatePrice * calculatePrice = [XZZRequestCalculatePrice allocInit];
    calculatePrice.couponCode = self.checkOutData.couponsInfor.param;
    if (self.skuNumArray.count){
        calculatePrice.skus = self.skuNumArray;
    }
    loadView(self.view)
    [XZZDataDownload orderGetPrice:calculatePrice httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            XZZOrderPriceInfor * orderPriceInfor = data;
            if (wSelf.checkOutData.postageInfor) {
                if (orderPriceInfor.total >= wSelf.checkOutData.postageInfor.freeLimit && wSelf.checkOutData.postageInfor.freeLimit != -1) {
                    orderPriceInfor.postFeePrice = 0;
                }else{
                    orderPriceInfor.postFeePrice = wSelf.checkOutData.postageInfor.fee;
                }
            }
            if (isChooseCoupon) {
                if (orderPriceInfor.discount <= 0) {
                    if (wSelf.checkOutData.couponsInfor.param.length) {
                        SVProgressError(@"This coupon is not valid.")
                    }
                }else{
                    if (wSelf.checkOutData.couponsInfor.param.length) {
                        SVProgressSuccess(@"Coupon applied successfully!");
                    }
                }
            }

            orderPriceInfor.profit = wSelf.checkOutData.priceInfor.profit;
            wSelf.checkOutData.priceInfor = orderPriceInfor;
            wSelf.goodsAndPriceInforView.priceInfor = orderPriceInfor;
        }else{
            [wSelf back];
        }
        loadViewStop
    }];
    
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

- (void)setAddressInfor:(XZZAddressInfor *)addressInfor
{
    
    self.checkOutData.addressInfor = addressInfor;
    
    if (addressInfor) {
        self.editAddressInforView.addressInfor = addressInfor;
    }
}
#pragma mark ----*  创建视图信息
/**
 *  创建视图信息
 */
- (void)addView
{
    WS(wSelf)
    self.goodsAndPriceInforView = [XZZCheckOutGoodsAndPriceInforView allocInit];
    self.goodsAndPriceInforView.cartInforArray = self.cartInforArray;
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
    
    self.userInforView = [XZZCheckOutUserInforView allocInit];
    [self.scrollView addSubview:self.userInforView];
    [self.userInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.goodsAndPriceInforView.mas_bottom);
    }];
    
    UILabel * shippingAddressLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    shippingAddressLabel.font = textFont_bold(13);
    shippingAddressLabel.text = @"Shipping Address";
    [self.scrollView addSubview:shippingAddressLabel];
    [shippingAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(wSelf.userInforView.mas_bottom);
        make.height.equalTo(@35);
    }];
    
    
    XZZSelectCountryInforViewModel * selectCountryInforViewModel = [XZZSelectCountryInforViewModel allocInit];
    selectCountryInforViewModel.VC = self;
    weakView(weak_shippingAddressLabel, shippingAddressLabel)
    self.editAddressInforView = [XZZCheckOutEditAddressInforView allocInit];
    self.editAddressInforView.selectCountryInforViewModel = selectCountryInforViewModel;
    [self.scrollView addSubview:self.editAddressInforView];
    [self.editAddressInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_shippingAddressLabel.mas_bottom);
    }];
    
    UIButton * button = [UIButton allocInitWithTitle:@"Continue to shipping" color:kColor(0xffffff) selectedTitle:@"Continue to shipping" selectedColor:kColor(0xffffff) font:18];
    [button addTarget:self action:@selector(checkOutContinueShippingButton) forControlEvents:(UIControlEventTouchUpInside)];
    button.titleLabel.font = textFont_bold(18);
    button.backgroundColor = button_back_color;
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    [self.scrollView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(wSelf.editAddressInforView.mas_bottom).offset(10);
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

- (void)checkOutContinueShippingButton
{
    if (self.editAddressInforView.firstNameView.textField.text.length <= 0) {
        [self.editAddressInforView.firstNameView inputUnfilledContent];
        return;
    }
    if (self.editAddressInforView.lastNameView.textField.text.length <= 0) {
        [self.editAddressInforView.lastNameView inputUnfilledContent];
        return;
    }
    if (self.editAddressInforView.address1View.textField.text.length <= 0) {
        [self.editAddressInforView.address1View inputUnfilledContent];
        return;
    }
    if (self.editAddressInforView.countryView.textField.text.length <= 0) {
        [self.editAddressInforView.countryView inputUnfilledContent];
        return;
    }
    if (self.editAddressInforView.provinceView.textField.text.length <= 0) {
        [self.editAddressInforView.provinceView inputUnfilledContent];
        return;
    }
    if (self.editAddressInforView.cityView.textField.text.length <= 0) {
        [self.editAddressInforView.cityView inputUnfilledContent];
        return;
    }
    if (self.editAddressInforView.zipView.textField.text.length <= 0) {
        [self.editAddressInforView.zipView inputUnfilledContent];
        return;
    }
    XZZAddressInfor * addressInfor = [XZZAddressInfor allocInit];
    
    addressInfor.firstName = self.editAddressInforView.firstNameView.textField.text;
    addressInfor.lastName = self.editAddressInforView.lastNameView.textField.text;
    addressInfor.detailAddress1 = self.editAddressInforView.address1View.textField.text;
    addressInfor.detailAddress2 = self.editAddressInforView.address2View.textField.text;
    addressInfor.countryName = self.editAddressInforView.countryView.textField.text;
    addressInfor.countryId = self.editAddressInforView.selectCountryInforViewModel.countryInfor.ID;
    addressInfor.countryCode = self.editAddressInforView.selectCountryInforViewModel.countryInfor.countryCode;
    addressInfor.provinceName = self.editAddressInforView.provinceView.textField.text;
    addressInfor.provinceId = self.editAddressInforView.selectCountryInforViewModel.provinceInfor.ID;
    addressInfor.provinceCode = self.editAddressInforView.selectCountryInforViewModel.provinceInfor.provinceCode;
    addressInfor.cityName = self.editAddressInforView.cityView.textField.text;
    addressInfor.cityId = self.editAddressInforView.selectCountryInforViewModel.cityInfor.ID;
    addressInfor.zipCode = self.editAddressInforView.zipView.textField.text;
    addressInfor.phone = self.editAddressInforView.phoneView.textField.text;

    loadView(self.view)
    WS(wSelf)
    if (!self.checkOutData.addressInfor) {
        addressInfor.status = 1;
        [XZZDataDownload userGetAddAddress:addressInfor httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                wSelf.addressInfor = data;
                [wSelf nextStep];
                [User_Infor getAddressListHttpBlock:nil];
            }else{
                if ([data isKindOfClass:[NSString class]]) {
                    SVProgressError(data)
                }else{
                    SVProgressError(@"Try again later")
                }
            }
        }];
    }else{
        if (self.checkOutData.addressInfor.status == 0) {
            [User_Infor setDefaultAddress:self.checkOutData.addressInfor httpBlock:^(id data, BOOL successful, NSError *error) {
                loadViewStop
                if (successful) {
                    [wSelf nextStep];
                }else{
                    SVProgressError(@"Shipping address modified failed")
                }
            }];
        }else if ([self.checkOutData.addressInfor isContrastSame:addressInfor]) {
            loadViewStop
            [self nextStep];
        }else{
            
            [User_Infor modifyAddress:self.checkOutData.addressInfor newAddress:addressInfor httpBlock:^(id data, BOOL successful, NSError *error) {
                loadViewStop
                if (successful) {
                    wSelf.addressInfor = data;
                    [wSelf nextStep];
                }else{
                    SVProgressError(@"Shipping address modified failed")
                }
            }];
        }
    }
}

- (void)nextStep
{
    WS(wSelf)
    XZZCheckOutPostageViewController * postageVC = [XZZCheckOutPostageViewController allocInit];
    postageVC.checkOutData = self.checkOutData;
    [self pushViewController:postageVC animated:YES];
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
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        [array addObject:@{@"num" : @(cartInfor.skuNum), @"skuId" : cartInfor.ID}];
    }
    
    WS(wSelf)
    XZZCouponListViewController * couponListVC = [XZZCouponListViewController allocInit];
    couponListVC.goodsArray = array;
    [couponListVC setChooseCoupons:^(XZZCouponsInfor *couponsInfor) {
        wSelf.checkOutData.couponsInfor = couponsInfor;
        [wSelf calculatePrice:YES];
    }];
    [self pushViewController:couponListVC animated:YES];
}





@end

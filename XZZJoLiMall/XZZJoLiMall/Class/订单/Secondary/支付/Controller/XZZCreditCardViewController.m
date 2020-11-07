//
//  XZZCreditCardViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCreditCardViewController.h"
#import "XZZAddressListViewController.h"
#import "XZZPaymentAddCardView.h"
#import "XZZCheckOutAddressView.h"
#import "XZZOrderDetailsPaymentView.h"
#import "XZZCheckOutPriceButtonView.h"
#import "XZZCheckOutSecureCheckOutView.h"

#import "XZZOrderDetailsViewController.h"
#import "XZZPayResultsViewController.h"
#import "XZZDisplayWebStrViewController.h"

#import "XZZPaymentType.h"

#import "XZZAsiaBillPay.h"

@interface XZZCreditCardViewController ()
{
    int count;
}

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZPaymentAddCardView * cardView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutAddressView * addresView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * stripe 公钥
 */
@property (nonatomic, strong)NSString * stripeKey;
/**
 * 信用卡  tokenID
 */
@property (nonatomic, strong)NSString * tokenId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutPriceButtonView * priceButtonView;

@end

@implementation XZZCreditCardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self readPaymentTypeHttpBlock:nil];
    self.navigationController.navigationBar.hidden = NO;
    self.fd_interactivePopDisabled = YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)back
{
    if(self.orderId){
        XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
        orderDetailsVC.orderID = self.orderId;
        [self pushViewController:orderDetailsVC animated:YES];
        
    }else if (self.orderDetail) {
        [super back];
    }else {
        [super back];
    }
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

        }else{
            SVProgressError(@"Payment closed")
            [wSelf back];
        }
    }];
}

- (NSString *)stripeKey
{
    if (!_stripeKey) {
        NSString * stripeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"stripeKey"];
        if (stripeKey.length > 0) {
            self.stripeKey = stripeKey;
        }
    }
    return _stripeKey;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Payment";
    
    if (self.orderDetail) {
        self.nameVC = @"信用卡支付-重新支付";
    }else{
        self.nameVC = @"信用卡支付";
    }
    
    [self addView];
}

- (XZZAddressInfor *)addressInfor
{
    if (!_addressInfor) {
        self.addressInfor = [User_Infor getDefaultAddressInfor];
    }
    return _addressInfor;
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
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_secureCheckOutView.mas_bottom);
    }];
    
    if (self.priceInfor) {
        XZZCheckOutPriceButtonView * priceButtonView = [XZZCheckOutPriceButtonView allocInit];
        priceButtonView.priceInfor = self.priceInfor;
        priceButtonView.buttonStr = @"Check Out";
        [priceButtonView setBlock:^{
            [wSelf getPaymentAgain];
        }];
        self.priceButtonView = priceButtonView;
        [self.view addSubview:priceButtonView];
        [priceButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(wSelf.view);
            make.top.equalTo(wSelf.scrollView.mas_bottom);
        }];
    }else{
        XZZOrderDetailsPaymentView * paymentView = [XZZOrderDetailsPaymentView allocInit];
        paymentView.buttonType = XZZMethodPaymentTypeCard;
        paymentView.hideButton = self.orderDetail.status != 0;
        paymentView.orderDetail = self.orderDetail;
        [paymentView setCardPay:^{
            NSLog(@"%s %d 行", __func__, __LINE__);
            [wSelf getPaymentAgain];
        }];
        [self.view addSubview:paymentView];
        [paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(wSelf.view);
            make.top.equalTo(wSelf.scrollView.mas_bottom);
        }];
    }
    
    
    self.cardView = [XZZPaymentAddCardView allocInit];
    self.cardView.hideNameInfor = (self.payType != 3 && self.payType != 6);
    [self.scrollView addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(@11);
        make.centerX.equalTo(wSelf.view);
    }];
    
//    if (!self.orderDetail) {
        self.addresView = [XZZCheckOutAddressView allocInit];
        self.addresView.titleView.title = @"Billing Address";
        self.addresView.address = self.addressInfor;
        [self.addresView setChooseAddress:^{
            [wSelf chooesAddressInfor];
        }];
        [self.scrollView addSubview:self.addresView];
        [self.addresView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.top.equalTo(wSelf.cardView.mas_bottom);
            make.height.equalTo(@145);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            wSelf.scrollView.contentSize = CGSizeMake(0, wSelf.addresView.bottom + 20);
        });
        
//    }

    
}

#pragma mark ----*  读取stripe公钥
/**
 *  读取stripe公钥
 */
- (void)readPublicKey
{
    WS(wSelf)
    [XZZDataDownload payGetStripeKeyHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf storageStripeKey:data];
        }else{
            NSString * stripeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"stripeKey"];
            if (stripeKey.length > 0) {
                wSelf.stripeKey = stripeKey;
            }
        }
        [wSelf generateCreditCardInformation];
    }];
}
#pragma mark ----*  对stripe公钥进行赋值病存储
/**
 *  对stripe公钥进行赋值病存储
 */
- (void)storageStripeKey:(NSString *)stripeKey
{
    self.stripeKey = stripeKey;
    [[NSUserDefaults standardUserDefaults] setObject:stripeKey forKey:@"stripeKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark ----重新获取支付方式
/**
 *  重新获取支付方式
 */
- (void)getPaymentAgain
{
    if (![self determineCreditCardInformation]) {
        return;
    }
    WS(wSelf)
    loadView(self.view);
    [self readPaymentTypeHttpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf determineWhetherPaymentMethodIsAvailable:data];
        }else{
            
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
        for (XZZPaymentType * type in typeArray) {
            if (type.payType != 0 && type.payType != 7) {
                self.payType = type.payType;
                if (self.payType == 3 && self.cardView.hideNameInfor == YES) {
                 
                    self.cardView.hideNameInfor = NO;
                    self.cardView.cvvTextField.text = @"";
                    self.cardView.cardTextField.text = @"";
                    self.cardView.dateTextField.text = @"";
                    SVProgressError(@"Abnormal parameter")
                    return;
                }
                [self payCart];
                return;
            }
        }
        SVProgressError(@"Credit card payment has been closed. Please choose another method of payment.")
    }
}


- (void)payCart
{

    if (!self.orderDetail && self.orderId.length == 0) {
        loadView(self.view)
        self.requestCheckOut.billingId = self.addresView.address.ID;
        WS(wSelf)
        [XZZDataDownload orderCheckOut:self.requestCheckOut httpBlock:^(id data, BOOL successful, NSError *error) {
            if (successful) {
                [wSelf orderPay:data];
            }else{
                if ([data isKindOfClass:[NSString class]]) {
                    SVProgressError(data)
                }else{
                    SVProgressError(@"Try again later");
                }
                loadViewStop
            }
            [all_cart getAllCartHttpBlock:nil];
        }];
    }else{
        [self orderPay:self.orderDetail ? self.orderDetail.orderId : self.orderId];
    }
}

- (void)orderPay:(NSString *)orderId
{
    self.orderId = orderId;
    loadView(self.view)
    if (self.payType == 1) {
        [self readPublicKey];
       
    }else{
        [self pay];
    }
}

#pragma mark ----*  生成信用卡支付信息  stripe
/**
 *  生成信用卡支付信息  stripe
 */
- (void)generateCreditCardInformation
{
    if ([self determineCreditCardInformation]) {
        
        [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:self.stripeKey];
        
        NSLog(@"%s %d 行", __func__, __LINE__);
        loadView(self.view)
        WS(wSelf)
        
        NSArray * array = [self.cardView.dateTextField.text componentsSeparatedByString:@"/"];
        
        STPCardParams *cardParams = [[STPCardParams alloc] init];
        cardParams.number = [self.cardView.cardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        cardParams.expMonth = [[array firstObject] intValue];
        cardParams.expYear = [[array lastObject] intValue] + 2000;
        cardParams.cvc = self.cardView.cvvTextField.text;
        cardParams.currency = @"USD";
        
        //1、获取一个全局串行队列
        dispatch_queue_t queueorder = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2、把任务添加到队列中执行
        dispatch_async(queueorder, ^{
            
            [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
                loadViewStop
                NSLog(@"token=%@  %@", token, token.created);
                if (token.tokenId) {
                    wSelf.tokenId = token.tokenId;
                    [wSelf pay];
                }else{
                    SVProgressError(@"Credit card not available")
                    
                }
            }];
            
        });
        
    }
}

- (void)pay{
    
    if (self.payType == 3) {
        if (self.cardView.firstNameTextField.text.length <= 0) {
            SVProgressError(@"Please enter first name");
            loadViewStop
            return;
        }
        if (self.cardView.lastNameTextField.text.length <= 0) {
            SVProgressError(@"Please enter last name");
            loadViewStop
            return;
        }
    }
    
    NSArray * array = [self.cardView.dateTextField.text componentsSeparatedByString:@"/"];
    loadView(self.view)
    XZZRequestOrderPay * orderPay = [XZZRequestOrderPay allocInit];
    orderPay.orderId = self.orderId;
    orderPay.payType = self.payType;
    orderPay.stripeToken = self.tokenId;
    orderPay.payAmount = self.orderDetail ? [NSString stringWithFormat:@"%.2f", self.orderDetail.total] : self.requestCheckOut.total;
    orderPay.cardNo = [self.cardView.cardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    orderPay.expirationMonth = [array firstObject];
    orderPay.expirationYear = [array lastObject];
    orderPay.cvv = self.cardView.cvvTextField.text;
    orderPay.currency = @"USD";
    if (self.payType == 3 || self.payType == 6) {
        orderPay.email = User_Infor.email;
        orderPay.contact = User_Infor.email;
        orderPay.firstName = self.cardView.firstNameTextField.text;
        orderPay.lastName = self.cardView.lastNameTextField.text;
        if (orderPay.expirationYear.length == 2) {
            orderPay.expirationYear = [NSString stringWithFormat:@"20%@", orderPay.expirationYear];
        }
    }
    
    WS(wSelf)
    [XZZDataDownload payGetOrderPay:orderPay httpCodeBlock:^(id data, int code, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            
            if (wSelf.payType == 6 && [data isKindOfClass:[NSString class]]) {
                [wSelf displayingWwebContent:data];
            }else{
                [wSelf verifyPaymentResults];
            }
        }else{
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
                if (code == 80011009 || code == 80011010) {
                    XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
                    orderDetailsVC.orderID = wSelf.orderId;
                    [wSelf pushViewController:orderDetailsVC animated:YES];
                }
            }else{
                SVProgressError(@"Try again later");
            }
        }
    }];
}

- (void)displayingWwebContent:(NSString *)webStr
{
    XZZDisplayWebStrViewController * VC = [XZZDisplayWebStrViewController allocInit];
    VC.webStr = webStr;
    VC.orderId = self.orderId;
    [self pushViewController:VC animated:YES];
}

#pragma mark ----*  验证支付结果
/**
 *  验证支付结果
 */
- (void)verifyPaymentResults
{
    
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    loadView(self.view)
    WS(wSelf)
    [XZZDataDownload orderGetOrderDetailsOrderId:self.orderId httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        XZZOrderDetail * orderDetail = data;
        if (orderDetail.status != 0) {
            [wSelf payForResults:YES];
        }else{
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data);
            }else{
                SVProgressError(@"Try again later");
            }
        }
    }];
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
    payResultsVC.payType = self.payType;
        payResultsVC.orderId = self.orderId;
    [self pushViewController:payResultsVC animated:YES];
}

#pragma mark ----*  判断银行卡信息
/**
 *  判断银行卡信息
 */
- (BOOL)determineCreditCardInformation
{
    if (!self.cardView.cardTextField.text.length) {
        SVProgressError(@"Please enter your card number");//输入银行卡号
        return NO;
    }
    if (self.cardView.dateTextField.text.length != 5) {
        SVProgressError(@"Please enter a valid period");//输入有效日期
        return NO;
    }
    if (self.cardView.cvvTextField.text.length != 3 && self.cardView.cvvTextField.text.length != 4) {
        SVProgressError(@"Please enter CVV");//密码
        return NO;
    }
    if (self.payType == 3) {
        if (self.cardView.firstNameTextField.text.length <= 0) {
            SVProgressError(@"Please enter first name");
            loadViewStop
            return NO;
        }
        if (self.cardView.lastNameTextField.text.length <= 0) {
            SVProgressError(@"Please enter last name");
            loadViewStop
            return NO;
        }
    }
    
    
    return YES;
}



#pragma mark ----*  选择地址信息
/**
 *  选择地址信息
 */
- (void)chooesAddressInfor
{
    WS(wSelf)
    XZZAddressListViewController * addressListVC = [XZZAddressListViewController allocInit];
    addressListVC.address = self.addresView.address;
    addressListVC.isSelectAddress = YES;
    [addressListVC setSelectedAddress:^(XZZAddressInfor *address) {
        wSelf.addresView.address = address;
    }];
    [self pushViewController:addressListVC animated:YES];
}


@end

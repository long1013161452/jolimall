//
//  XZZOrderDetailsViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderDetailsViewController.h"

#import "XZZPayPalViewController.h"
#import "XZZCreditCardViewController.h"
#import "XZZGoodsCommentsViewController.h"
#import "XZZOrderListViewController.h"
#import "XZZPayResultsViewController.h"
#import "XZZAsibill3PayViewController.h"

#import "XZZOrderDetailsCountdownView.h"
#import "XZZOrderDetailsCodeView.h"
#import "XZZOrderDetailsStateView.h"
#import "XZZCheckOutAddressView.h"
#import "XZZCheckOutOrderGoodsView.h"
#import "XZZOrderDetailsPaymentView.h"
#import "XZZCheckOutTitleView.h"
#import "XZZOrderGoodsView.h"
#import "XZZOrderDetailsAddressView.h"
#import "XZZOrderDetailsPriceView.h"
#import "XZZChoosePaymentMethodView.h"

#import "XZZPaymentType.h"

#import "XZZAsiaBillPay.h"



@interface XZZOrderDetailsViewController ()<XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderDetail * orderDetail;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * 滚动视图最下方
 */
@property (nonatomic, strong)UIView * bottomView;

/**
 * 再次支付按钮呢
 */
@property (nonatomic, strong)XZZOrderDetailsPaymentView * paymentView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderDetailsPriceView * priceView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZChoosePaymentMethodView * paymentMethodView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * paymentTypeArr;

/**
 * <#expression#>
 */
@property (nonatomic, assign)NSInteger status;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZPaymentType * paymentType;

@end

@implementation XZZOrderDetailsViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self dataDownload];
    self.navigationController.navigationBar.hidden = NO;
    self.fd_interactivePopDisabled = YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (XZZChoosePaymentMethodView *)paymentMethodView
{
    if (!_paymentMethodView) {
        WS(wSelf)
        self.paymentMethodView = [XZZChoosePaymentMethodView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_paymentMethodView setCardPay:^{
            [wSelf determineIfCardPaymentsAreAvailable];
        }];
        [_paymentMethodView setPayPalPay:^{
            [wSelf determineIfPaypalPaymentsAreAvailable];
        }];
    }
    return _paymentMethodView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTitle = @"Orders Detail";
    self.nameVC = @"订单详情";


    
//    [self dataDownload];
}

- (void)back
{
    for (UIViewController * VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZZOrderListViewController class]]) {
            [self popToViewController:VC animated:YES];
            return;
        }
    }
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark ----*  数据下载
/**
 *  数据下载
 */
- (void)dataDownload
{
    loadView(nil)
    WS(wSelf)
    [XZZDataDownload orderGetOrderDetailsOrderId:self.orderID httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            wSelf.orderDetail = data;
            wSelf.status = wSelf.orderDetail.status;
            [wSelf addView];
            [wSelf readPaymentTypeHttpBlock:nil];
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
        if (successful) {
            !httpBlock?:httpBlock(data, successful, error);
            wSelf.paymentTypeArr = data;
            NSLog(@"%s %d 行 =====================", __func__, __LINE__);
        }else{
            wSelf.paymentTypeArr = nil;
            if (wSelf.status == 0) {
                SVProgressError(@"Payment closed");
            }
            NSLog(@"%s %d 行 =====================", __func__, __LINE__);
        }
        NSLog(@"%s %d 行 =====================", __func__, __LINE__);
        wSelf.paymentView.typeArray = wSelf.paymentTypeArr;
    }];
}

- (void)addView{
    
    WS(wSelf)
    [self.view removeAllSubviews];
    self.scrollView = [UIScrollView allocInit];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    
    XZZOrderDetailsPriceView * picetView = [XZZOrderDetailsPriceView allocInit];
    NSLog(@"%s %d 行 =====================", __func__, __LINE__);
    picetView.hideButton = self.orderDetail.status != 0;
    picetView.orderDetail = self.orderDetail;
    [picetView setPayNow:^{
        [wSelf paymentInformation];
    }];
    self.priceView = picetView;
    [self.view addSubview:picetView];
    [picetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.top.equalTo(wSelf.scrollView.mas_bottom);
    }];
    
    UIView * topView = nil;
    if (self.orderDetail.status == 0) {
        XZZOrderDetailsCountdownView * countdownView = [XZZOrderDetailsCountdownView allocInit];
        countdownView.orderCancelTime = self.orderDetail.orderCancelTime;
        countdownView.currentTime = self.orderDetail.currentTime;
        [self.scrollView addSubview:countdownView];
        [countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.top.equalTo(@0);
            make.height.equalTo(@56);
        }];
        topView = countdownView;
    }
    
    
    
    weakView(weak_topView, topView)
    XZZOrderDetailsCodeView * codeView = [XZZOrderDetailsCodeView allocInit];
    codeView.orderNum = self.orderDetail.orderId;
    codeView.orderState = self.orderDetail.status;
    codeView.creationTime = self.orderDetail.createTime;
    if ((self.orderDetail.status == 3 || self.orderDetail.status == 4) && self.orderDetail.transportCode.length > 0) {
        codeView.transportCode = self.orderDetail.transportCode;
        codeView.delegate = self;
    }
    [self.scrollView addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (weak_topView) {
            make.left.right.equalTo(weak_topView);
            make.top.equalTo(weak_topView.mas_bottom);
        }else{
            make.left.right.equalTo(wSelf.view);
            make.top.equalTo(@0);
        }
    }];
    
    weakView(weak_codeView, codeView)
//    XZZOrderDetailsStateView * stateView = [XZZOrderDetailsStateView allocInit];
//    stateView.orderState = self.orderDetail.status;
//    stateView.creationTime = self.orderDetail.createTime;
//    if ((self.orderDetail.status == 3 || self.orderDetail.status == 4) && self.orderDetail.transportCode.length > 0) {
//        stateView.transportCode = self.orderDetail.transportCode;
//        stateView.delegate = self;
//    }
//    [self.scrollView addSubview:stateView];
//    [stateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weak_codeView);
//        make.top.equalTo(weak_codeView.mas_bottom).offset(8);
//    }];
    
//    weakView(weak_stateView, stateView)
    XZZOrderDetailsAddressView * addressView = [XZZOrderDetailsAddressView allocInit];
    addressView.address = self.orderDetail.shippingAddress;
    addressView.arrowImageView.hidden = YES;
    [self.scrollView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_codeView);
        make.top.equalTo(weak_codeView.mas_bottom);
    }];
    weakView(weak_addressView, addressView)
//    XZZCheckOutTitleView * youOrderTitleView = [XZZCheckOutTitleView allocInit];
//    youOrderTitleView.title = @"Your Order";
//    [self.scrollView addSubview:youOrderTitleView];
//    [youOrderTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(weak_addressView);
//        make.top.equalTo(weak_addressView.mas_bottom);
//        make.height.equalTo(@40);
//    }];
    
//    weakView(weak_youOrderTitleView, youOrderTitleView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = BACK_COLOR;
    [self.scrollView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.height.equalTo(@10);
        make.top.equalTo(weak_addressView.mas_bottom);
    }];
    
    topView = dividerView;
    BOOL orderComplete = self.orderDetail.status == 4;
    for (XZZOrderSku * orderSku in self.orderDetail.skus) {
        weakView(weak_topView, topView)
        XZZOrderGoodsView * goodsView = [XZZOrderGoodsView allocInit];
        goodsView.orderSku = orderSku;
        goodsView.hideCommentButton = !orderComplete;
        goodsView.delegate = self;
        [self.scrollView addSubview:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weak_topView);
            make.top.equalTo(weak_topView.mas_bottom);
        }];
        topView = goodsView;
    }
    
    self.bottomView = topView;
    
    [self dynamicChangesRefreshView];

    
    [self addChatAndActivityFloatWindow];
    
    
}

#pragma mark ----*  动态延时刷新视图
/**
 *  动态延时刷新视图
 */
- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.scrollView.contentSize = CGSizeMake(0, wSelf.bottomView.bottom);
    });
}
#pragma mark ---- *  打开web页面
/**
 *  打开web页面
 */
- (void)openWebPageUrl:(id)url
{
    XZZWebViewController * webVC = [XZZWebViewController allocInit];
    webVC.webUrl = url;
    webVC.nameVC = @"H5页面 物流";
    [self pushViewController:webVC animated:YES];
}
#pragma mark ----*  商品评论
/**
 *  商品评论
 */
- (void)productReviewOrderSku:(XZZOrderSku *)orderSku
{
    NSMutableArray * array = @[].mutableCopy;
    NSString * commentsId = nil;
    NSInteger index = 0;
    if (orderSku.commentId) {
        commentsId = orderSku.commentId;
       [array addObject:[XZZCanCommentSku canCommentSku:orderSku]];
    }else{
        int count = 0;
        for (XZZOrderSku * orderSkuTwo in self.orderDetail.skus) {
            if (orderSkuTwo.isComment == 0) {
                if ([orderSkuTwo.skuId isEqualToString:orderSku.skuId]) {
                    index = count;
                }
                count++;
                [array addObject:[XZZCanCommentSku canCommentSku:orderSkuTwo]];
            }
        }
    }
    
    
    XZZGoodsCommentsViewController * goodsCommentsVC = [XZZGoodsCommentsViewController allocInit];
    goodsCommentsVC.index = index;
    goodsCommentsVC.skuOrderList = array;
    goodsCommentsVC.commentId = commentsId;
    [self pushViewController:goodsCommentsVC animated:YES];
}
#pragma mark ----*  进入商品详情
/**
 *  进入商品详情
 */
- (void)clickOnGoodsAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    GoodsDetails(goodsId, self)
}

#pragma mark ----支付
/**
 *  支付
 */
- (void)paymentInformation
{
    WS(wSelf)
    loadView(self.view)
    [self readPaymentTypeHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            wSelf.paymentMethodView.paymentTypeArr = data;
            [wSelf.paymentMethodView addSuperviewView];
        }
        loadViewStop
    }];
}

#pragma mark ----判断信用卡支付是否可用
/**
 *  判断信用卡支付是否可用
 */
- (void)determineIfCardPaymentsAreAvailable
{
    WS(wSelf)
    loadView(self.view)
    [self readPaymentTypeHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
        [wSelf cardPay:data];
        }
        loadViewStop
    }];
}
#pragma mark ----*  信用卡支付
/**
 *  信用卡支付
 */
- (void)cardPay:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]]) {
        for (XZZPaymentType * type in array) {
            if (type.payType != 0) {
                if (type.payType == 7) {
                    
                    [self asiabill3Pay:self.orderID];
                    
                    
                    return;
                }
                XZZCreditCardViewController * cardVC = [XZZCreditCardViewController allocInit];
                cardVC.orderDetail = self.orderDetail;
                cardVC.payType = type.payType;
                [self pushViewController:cardVC animated:YES];
                return;
            }
        }
       SVProgressError(@"Credit card payments have been closed.")
    }
}

- (void)asiabill3Pay:(NSString *)orderId
{
    loadView(self.view)
    XZZRequestOrderPay * orderPay = [XZZRequestOrderPay allocInit];
    orderPay.orderId = orderId;
    orderPay.payType = 7;
    orderPay.email = User_Infor.email;
    orderPay.currency = @"USD";
    orderPay.payAmount = [NSString stringWithFormat:@"%.2f", self.orderDetail.total];
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
            SVProgressError(data)
            if (code == 80011009 || code == 80011010) {
                [wSelf dataDownload];
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
    payResultsVC.payType = 3;
    payResultsVC.orderId = self.orderID;
    [self pushViewController:payResultsVC animated:YES];
}

#pragma mark ----判断paypal支付是否可用
/**
 *  判断paypal支付是否可用
 */
- (void)determineIfPaypalPaymentsAreAvailable
{
    WS(wSelf)
    loadView(self.view);
    [self readPaymentTypeHttpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf payPalPay:data];
        }
        
    }];
}
#pragma mark ----*  PayPal支付
/**
 *  PayPal支付
 */
- (void)payPalPay:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]]) {
        for (XZZPaymentType * type in array) {
            if (type.payType == 0) {
                WS(wSelf)
                loadView(self.view)
                XZZRequestOrderPay * orderPay = [XZZRequestOrderPay allocInit];
                orderPay.orderId = self.orderID;
                orderPay.payType = 0;
                orderPay.payAmount = [NSString stringWithFormat:@"%.2f", self.orderDetail.total];
                [XZZDataDownload payGetOrderPay:orderPay httpCodeBlock:^(id data, int code, BOOL successful, NSError *error) {
                    loadViewStop
                    if (successful) {
                        XZZPayPalViewController * paypalVC = [XZZPayPalViewController allocInit];
                        paypalVC.orderId = self.orderID;
                        paypalVC.payPalUrlStr = data;
                        paypalVC.firstPayment = YES;
                        //            paypalVC.numItems = wSelf.numItems;
                        [wSelf pushViewController:paypalVC animated:YES];
                    }else{
                        SVProgressError(data)
                        if (code == 80011009 || code == 80011010) {
                            [wSelf dataDownload];
                        }
                    }
                }];
                return;
            }
        }
        SVProgressError(@"Paypal payments have been shut down")
    }
    
}



@end

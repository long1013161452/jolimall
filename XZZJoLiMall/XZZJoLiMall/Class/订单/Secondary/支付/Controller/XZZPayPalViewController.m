//
//  XZZPayPalViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZPayPalViewController.h"

#import "XZZOrderDetail.h"

#import "XZZPayResultsViewController.h"

#import "XZZOrderDetailsViewController.h"

@interface XZZPayPalViewController ()< WKNavigationDelegate, WKUIDelegate>

/**
 * 是否引导注册
 */
@property (nonatomic, assign)BOOL isGuide;

@end

@implementation XZZPayPalViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.fd_interactivePopDisabled = YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)back
{
    [self obtainOrderDetails];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"PayPal";
    
        self.nameVC = @"PayPal支付";
    WS(wSelf)
    
    NSURL *url = [NSURL URLWithString:self.payPalUrlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    WKWebView * wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    [wkWebView loadRequest:request];
    [self.view addSubview:wkWebView];
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.right.bottom.equalTo(wSelf.view);
    }];
    
    
    
   

    
}

// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *url = navigationAction.request.URL.absoluteString;
    if ([url hasPrefix:@"zbyb2celecricityfailure"] || [url hasPrefix:@"zbyb2celecricitysuccessful"]) {
        if ([url hasSuffix:@"isGuide=1"] || [url hasSuffix:@"isguide=1"]) {
            self.isGuide = YES;
        }
        [self obtainOrderDetails];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark ----*  获取订单详情
/**
 *  获取订单详情
 */
- (void)obtainOrderDetails
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload orderGetOrderDetailsOrderId:self.orderId httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        XZZOrderDetail * orderDetail = data;
        if (orderDetail.status != 0) {
            [wSelf payForResults:YES];
        }else{
            [wSelf payForResults:NO];
        }
    }];
}
#pragma mark ----*  进入支付结果页面
/**
 *  进入支付结果页面
 */
- (void)payForResults:(BOOL)successful
{
    if (successful) {
            XZZPayResultsViewController * payResultsVC = [XZZPayResultsViewController allocInit];
        payResultsVC.payResults = successful;
        payResultsVC.payType = 0;
        payResultsVC.orderId = self.orderId;
        [self pushViewController:payResultsVC animated:YES];
    }else{
        XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
        orderDetailsVC.orderID = self.orderId;
        [self pushViewController:orderDetailsVC animated:YES];
    }

}


@end

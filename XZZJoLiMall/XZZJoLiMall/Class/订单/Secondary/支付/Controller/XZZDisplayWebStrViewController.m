//
//  XZZDisplayWebStrViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZDisplayWebStrViewController.h"

#import "XZZOrderDetailsViewController.h"
#import "XZZPayResultsViewController.h"

@interface XZZDisplayWebStrViewController ()< WKNavigationDelegate, WKUIDelegate>

@end

@implementation XZZDisplayWebStrViewController

- (void)back
{
    [self obtainOrderDetails];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.myTitle = @"Pay";
    
    
    WS(wSelf)
    
    WKWebView * wkwebView = [WKWebView allocInit];
    [wkwebView loadHTMLString:self.webStr baseURL:nil];
    wkwebView.navigationDelegate = self;
    wkwebView.UIDelegate = self;
    [self.view addSubview:wkwebView];
    [wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
    

    
}





// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *url = navigationAction.request.URL.absoluteString;
    NSLog(@"~~~~~~~~~~~~~%@", url);
    if ([url rangeOfString:@"payResult"].location !=NSNotFound) {
        [self obtainOrderDetails];
        decisionHandler(WKNavigationActionPolicyCancel);
        return ;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
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
        payResultsVC.payType = 3;
        payResultsVC.orderId = self.orderId;
        [self pushViewController:payResultsVC animated:YES];
    }else{
        XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
        orderDetailsVC.orderID = self.orderId;
        [self pushViewController:orderDetailsVC animated:YES];
    }

}


@end

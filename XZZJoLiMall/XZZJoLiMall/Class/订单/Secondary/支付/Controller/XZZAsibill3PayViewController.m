//
//  XZZAsibill3PayViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZAsibill3PayViewController.h"

#import "XZZPayResultsViewController.h"
#import "XZZOrderDetailsViewController.h"

@interface XZZAsibill3PayViewController ()<WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate>

@end

@implementation XZZAsibill3PayViewController

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
    WS(wSelf)
    
    self.myTitle = @"Check Out";
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.asiaBillPay.requestUrl]];//https://mclient.asiabill.com/pay/test_mobile_wap_pay
    //    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://mclient.asiabill.com/pay/test_mobile_wap_pay"]];//
    
    [request setHTTPMethod:@"POST"];
    //    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSString * orderStr = [self.asiaBillPay description];
    NSLog(@"%@", orderStr);
    [request setHTTPBody:[orderStr dataUsingEncoding:NSUTF8StringEncoding]];
    
//    //以下代码适配大小
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
    webConfig.userContentController = wkUController;
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 11.0) {
        WKWebView * wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];//configuration:webConfig];
        wkWebView.navigationDelegate = self;
        wkWebView.UIDelegate = self;
        [wkWebView loadRequest:request];
        [self.view addSubview:wkWebView];
        [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(wSelf.view);
        }];
    } else {
        UIWebView * webView = [UIWebView allocInit];
        webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(wSelf.view);
        }];
    }
    
}


// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *url = navigationAction.request.URL.absoluteString;
    NSLog(@"~~~~~~~~~%@", url);
    
    NSLog(@"~~~~~~~~~%@", [[NSString alloc] initWithData:navigationAction.request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    if ([url containsString:@"cancelTrade"] || [url containsString:@"order/"]) {
        [self payForResults:NO];
        [self readErrorMessage:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    if ([url containsString:@"payFail"] || [url containsString:@"kolSuccess"] || [url containsString:@"Success"]) {
        loadView(self.view)
        [self obtainOrderDetails];
        [self readErrorMessage:url];
//        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString  * url = request.URL.absoluteString;
    NSLog(@"~~~~~~~~~~~~~%@", url);
    
    if ([url containsString:@"cancelTrade"] || [url containsString:@"order/"]) {
        [self readErrorMessage:url];
        [self payForResults:NO];
        return NO;
    }
    if ([url containsString:@"payFail"] || [url containsString:@"kolSuccess"] || [url containsString:@"Success"]) {
        loadView(self.view)
        [self readErrorMessage:url];
        [self obtainOrderDetails];
        return NO;
    }
    
    return YES;
    
}

- (void)readErrorMessage:(NSString *)url
{
    if ([url containsString:@"errorMessage"]) {
        NSArray * array = [url componentsSeparatedByString:@"="];
        if (array.count > 1) {
            NSString * str = [[array lastObject] stringByRemovingPercentEncoding];
            [SVProgressHUD setMaximumDismissTimeInterval:2];
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            SVProgressError(str);
            [SVProgressHUD setMaximumDismissTimeInterval:1];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
        }
    }
}



/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 确认框
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
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
        payResultsVC.payType = 7;
        payResultsVC.orderId = self.orderId;
        [self pushViewController:payResultsVC animated:YES];
    }else{
        XZZOrderDetailsViewController * orderDetailsVC = [XZZOrderDetailsViewController allocInit];
        orderDetailsVC.orderID = self.orderId;
        [self pushViewController:orderDetailsVC animated:YES];
    }
    
}




@end

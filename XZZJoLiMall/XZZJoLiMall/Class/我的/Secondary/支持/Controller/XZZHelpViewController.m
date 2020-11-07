//
//  XZZHelpViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHelpViewController.h"

@interface XZZHelpViewController ()<WKUIDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)WKWebView * webView;

@end

@implementation XZZHelpViewController


- (void)back
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [super back];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"FAQ";
    self.nameVC = @"FAQ";
    [XZZBuriedPoint SupportPerson:1];
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:User_Infor.email email:User_Infor.email];
    //    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCJwt alloc] initWithToken:User_Infor.email];
    [[ZDKZendesk instance] setIdentity:userIdentity];

    WS(wSelf)
    WKWebView * webView = [[WKWebView alloc] init];
//        webView.delegate = self;
    webView.UIDelegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    [self OpenWebPage:@"https://faq.jolimall.com/hc/en-us"];
    return;
        ZDKHelpCenterProvider * provider = [[ZDKHelpCenterProvider alloc] init];
    [provider getCategoriesWithCallback:^(NSArray *items, NSError *error) {
        NSLog(@"%@", items);
        for (ZDKHelpCenterCategory * help in items) {
            NSLog(@"identifier    %@", help.identifier);
            NSLog(@"name    %@", help.name);
            NSLog(@"categoryDescription    %@", help.categoryDescription);
            NSLog(@"locale    %@", help.locale);
            NSLog(@"sourceLocale   %@", help.sourceLocale);
            NSLog(@"url      %@", help.url);
            NSLog(@"html_url    %@", help.html_url);
            NSLog(@"updatedAt   %@", help.updatedAt);
            NSLog(@"createdAt   %@", help.createdAt);
            
            
        }
        ZDKHelpCenterCategory * help = [items firstObject];
        [wSelf OpenWebPage:help.html_url];
    }];
    
    
}

- (void)OpenWebPage:(NSString *)urlStr
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];


}


// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}





@end

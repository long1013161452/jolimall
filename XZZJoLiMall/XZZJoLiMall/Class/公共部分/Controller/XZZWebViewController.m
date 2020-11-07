//
//  XZZWebViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/18.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZWebViewController.h"

@interface XZZWebViewController ()<WKNavigationDelegate, WKUIDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)WKWebView * webView;

@end

@implementation XZZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSURL * url = nil;
    
    if (self.urlStr) {
        if (![self.urlStr hasPrefix:@"http"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", self.urlStr]];
        }else{
            url = [NSURL URLWithString:self.urlStr];
        }
    }else if ([self.webUrl isKindOfClass:[NSString class]]){
        if (![self.webUrl hasPrefix:@"http"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@", self.webUrl]];
        }else{
            url = [NSURL URLWithString:self.webUrl];
        }
        
    }else if ([self.webUrl isKindOfClass:[NSURL class]]){
        url = self.webUrl;
    }
    
    
    
    WS(wSelf)
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    

    
    
}

// 根据监听 实时修改title
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView)
        {
            if (!self.myTitle) {
                self.myTitle = self.webView.title;
            }
            
            NSLog(@"~~~~~~~~~~%@", self.webView.title);
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }
    
}

//移除监听
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title" context:nil];
}

// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

@end

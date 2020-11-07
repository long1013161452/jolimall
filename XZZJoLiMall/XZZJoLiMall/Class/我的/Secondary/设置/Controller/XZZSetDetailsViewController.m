//
//  XZZSetDetailsViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSetDetailsViewController.h"

@interface XZZSetDetailsViewController ()<WKUIDelegate>

@end

@implementation XZZSetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = self.setUpInfor.title;
    self.nameVC = [NSString stringWithFormat:@"设置-%@", self.setUpInfor.title];
    NSString * htmlStr = [NSString stringWithFormat:@"<div style=\"word-wrap: break-word; white-space: pre-wrap;\"><div class=\"ql-container ql-snow\"><div class=\"ql-editor\">%@</div></div></div>", self.setUpInfor.content];
//    NSString * htmlStr = [NSString stringWithFormat:@"<div style=\"word-wrap: break-word; white-space: pre-wrap;\">%@</div>", self.setUpInfor.content];

       htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<img src" withString: @"<img style=\"max-width:100%;height:auto\" src"];

    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"quill" ofType:@"css"];

//    filePath = @"quill.css";
    
    htmlStr = [NSString stringWithFormat:@"<html>\n<head>\n<meta data-vue-meta=\"true\" data-vmid=\"viewport\" name=\"viewport\" content=\"initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui, width=device-width\">\n<link rel=\"stylesheet\" type=\"text/css\" href=\"file:%@\">\n<style>.page{overflow-x: hidden;white-space: pre-wrap;}.page   .ql-container.ql-snow{border: none;}</style>\n</head>\n<body><div class=\"page\">%@</div></body>\n</html>", filePath, htmlStr];


    WS(wSelf)
    
    WKWebView * wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [wkwebView loadHTMLString:htmlStr baseURL:nil];
    wkwebView.UIDelegate = self;
    [self.view addSubview:wkwebView];
    [wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
    

    
    
    
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


@end

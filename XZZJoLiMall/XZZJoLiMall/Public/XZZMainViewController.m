//
//  XZZMainViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

@interface XZZMainViewController ()

@end

@implementation XZZMainViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    [self setNavUI];
    [self setNavigationUI];
}

#pragma mark ----   设置导航栏
- (void)setNavigationUI{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:kColor(0x010101)}];
    
}

- (void)setNavUI{
    UIButton * leftButton = [UIButton allocInitWithFrame:CGRectMake(0, 0, 50, 40)];
    [leftButton setImage:imageName(@"nav_back") forState:(UIControlStateNormal)];
    [leftButton setImage:imageName(@"nav_back") forState:(UIControlStateHighlighted)];
    [leftButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [leftButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    leftButton.titleLabel.font = textFont(14);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);//
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BACK_COLOR;
}



@end

//
//  XZZEmailSentViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZEmailSentViewController.h"

@interface XZZEmailSentViewController ()

@end

@implementation XZZEmailSentViewController
- (void)back
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"Forgotten Password:Email Sent";
    
    WS(wSelf)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    
    
    weakView(WV, backView)
    
    UILabel * label = [UILabel allocInit];
    label.text = @"An email has been sent to the provided email address.\nIf you requested a new password but didn't receive your password-reset email:\n1. Check the spam or junk mail folder in your email account.\n2. Try to reset your password again.\n3. If you still don't receive the email, please try again after 5 minutes.";
    label.textColor = kColor(0x999999);
    label.numberOfLines = 0;
    label.font = textFont(12);
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@50);
        make.centerX.equalTo(wSelf.view);
        make.centerY.equalTo(WV);
    }];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

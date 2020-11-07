//
//  XZZBindingEmailViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZBindingEmailViewController.h"

@interface XZZBindingEmailViewController ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITextField * textField;

@end

@implementation XZZBindingEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Fill In The Mailbox";
    self.nameVC = @"绑定邮箱";

    WS(wSelf)
    
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    
    weakView(weakBackView, backView)
    UIView * textFieldBackview = [UIView allocInit];
    textFieldBackview.backgroundColor = BACK_COLOR;
    [backView addSubview:textFieldBackview];
    [textFieldBackview cutRounded:5];
    [textFieldBackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@60);
        make.centerX.equalTo(weakBackView);
        make.height.equalTo(@40);
    }];
    weakView(weakTextFieldBackview, textFieldBackview)
    UITextField * textField = [UITextField allocInit];
    textField.placeholder = @"Email";
    [textFieldBackview addSubview:textField];
    self.textField = textField;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.bottom.centerX.equalTo(weakTextFieldBackview);
    }];
    
    UIButton * logInButton = [UIButton allocInit];
    [logInButton setTitle:@"SUMBIT" forState:(UIControlStateNormal)];
    [logInButton setTitle:@"SUMBIT" forState:(UIControlStateSelected)];
    [logInButton setTitleColor:kColor(0xffffff) forState:(UIControlStateNormal)];
    [logInButton setTitleColor:kColor(0xffffff) forState:(UIControlStateSelected)];
    logInButton.titleLabel.font = textFont(16);
    logInButton.backgroundColor = button_back_color;
    [logInButton addTarget:self action:@selector(clickOnSumbitButton) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:logInButton];
    [logInButton cutRounded:5];
    [logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakTextFieldBackview);
        make.height.equalTo(@45);
        make.top.equalTo(weakTextFieldBackview.mas_bottom).offset(15);
        make.bottom.equalTo(weakBackView).offset(-40);
    }];
    
}

- (void)clickOnSumbitButton
{
    [self.view endEditing:YES];
    if (!email_Format(self.textField.text)) {
        SVProgressError(@"Incorrect mailbox format")
        return;
    }
    loadView(self.view)
    WS(wSelf);
    
    if (self.appleID) {
        [XZZDataDownload logInGetIOSIdLogInEmail:self.textField.text appleId:self.appleID appleName:self.appleName httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (error) {//接口请求错误
                SVProgressError(@"Try again later")
            }else if (successful){//接口数据返回成功
                SVProgressSuccess(@"Log in successfully")
                [wSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{//接口通信正常    数据错误
                if ([data isKindOfClass:[NSString class]]) {
                    SVProgressError(data)
                }
            }
        }];
    }else{
        [XZZDataDownload logInGetFacebookIdLogInEmail:self.textField.text facebookId:self.FBUserID facebookName:self.FBName httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (error) {//接口请求错误
                SVProgressError(@"Try again later")
            }else if (successful){//接口数据返回成功
                SVProgressSuccess(@"Log in successfully")
                [wSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{//接口通信正常    数据错误
                if ([data isKindOfClass:[NSString class]]) {
                    SVProgressError(data)
                }
            }
        }];
    }
}



@end

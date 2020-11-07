//
//  XZZChangePasswordViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZChangePasswordViewController.h"

#import "XZZEmailSentViewController.h"

@interface XZZChangePasswordViewController ()
@property (nonatomic, strong)UITextField * textField;


@end

@implementation XZZChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WS(wSelf)
    
    self.myTitle = @"Forgot Password";
    self.nameVC = @"找回密码";

    
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    
    weakView(WV, backView)
    
    UILabel * label = [UILabel allocInit];
    label.text = @"If you’ ve forgotten your password, please enter your registeredemail address. We’ll send you a link to reset your password.";
    label.textColor = kColor(0x999999);
    label.numberOfLines = 0;
    label.font = textFont(12);
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@50);
        make.centerX.equalTo(wSelf.view);
    }];
    weakView(weakLabel, label)
    UIView * textFieldBackview = [UIView allocInit];
    textFieldBackview.backgroundColor = BACK_COLOR;
    [backView addSubview:textFieldBackview];
    [textFieldBackview cutRounded:5];
    [textFieldBackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(weakLabel.mas_bottom).offset(20);
        make.centerX.equalTo(WV);
        make.height.equalTo(@40);
    }];
    weakView(weakView, textFieldBackview)
    UITextField * textField = [UITextField allocInit];
    textField.placeholder = @"Email";
    [textFieldBackview addSubview:textField];
    self.textField = textField;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.bottom.centerX.equalTo(weakView);
    }];
    
    weakView(weakBackView, textFieldBackview)
    UIButton * SUMBITButton = [UIButton allocInit];
    [SUMBITButton setTitle:@"SUMBIT" forState:(UIControlStateNormal)];
    [SUMBITButton setTitle:@"SUMBIT" forState:(UIControlStateSelected)];
    [SUMBITButton setTitleColor:kColor(0xffffff) forState:(UIControlStateNormal)];
    [SUMBITButton setTitleColor:kColor(0xffffff) forState:(UIControlStateSelected)];
    SUMBITButton.titleLabel.font = textFont(16);
    SUMBITButton.backgroundColor = button_back_color;
    [SUMBITButton addTarget:self action:@selector(clickOnSumbit) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:SUMBITButton];
    [SUMBITButton cutRounded:5];
    [SUMBITButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakBackView);
        make.height.equalTo(@45);
        make.top.equalTo(weakBackView.mas_bottom).offset(15);
        make.bottom.equalTo(WV).offset(-20);
    }];
    
}

- (void)clickOnSumbit
{
    
    [self.view endEditing:YES];
    if (!email_Format(self.textField.text)) {
        SVProgressError(@"Incorrect mailbox format")
        return;
    }
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload logInGetForgotPasswordEmail:self.textField.text httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(@"Send a success")
            XZZEmailSentViewController * emailSentVC = [XZZEmailSentViewController allocInit];
            [wSelf pushViewController:emailSentVC animated:YES];
        }else if(error){
            SVProgressError(@"Try again later")
        }else{
            SVProgressError(data)
            
        }
    }];
    
    

}




@end

//
//  XZZSubmitRepairOrderViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSubmitRepairOrderViewController.h"

@interface XZZSubmitRepairOrderViewController ()<UITextViewDelegate>

/**
 * <#expression#>
 */
//@property (nonatomic, strong)UITextField * textField;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITextView * textView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * placeholderLabel;

@end

@implementation XZZSubmitRepairOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Submit a Ticket";
    self.nameVC = @"提交工单";
    
    [XZZBuriedPoint SupportPerson:3];
    
    [self addView];
}

- (void)addView{
    
    WS(wSelf)
    
//    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 00, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
//    titleLabel.text = @"Contact us";
//    [self.view addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@15);
//        make.top.equalTo(@30);
//    }];
//
//    weakView(weak_titleLabel, titleLabel)
//    self.textField = [UITextField allocInit];
//    self.textField.borderStyle = UITextBorderStyleRoundedRect;
//    [self.view addSubview:self.textField];
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weak_titleLabel);
//        make.top.equalTo(weak_titleLabel.mas_bottom).offset(20);
//        make.height.equalTo(@45);
//        make.centerX.equalTo(wSelf.view);
//    }];
    
    UILabel * helpLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    helpLabel.text = @"How can we help you?";
    [self.view addSubview:helpLabel];
    [helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@40);
    }];
    
    weakView(weak_helpLabel, helpLabel)
    UIView * textBackView = [UIView allocInit];
    textBackView.backgroundColor = [UIColor whiteColor];
    textBackView.layer.borderColor = DIVIDER_COLOR.CGColor;
    textBackView.layer.borderWidth = .5;
    [self.view addSubview:textBackView];
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_helpLabel);
        make.top.equalTo(weak_helpLabel.mas_bottom).offset(20);
        make.centerX.equalTo(wSelf.view);
        make.height.equalTo(@200);
    }];
    
    weakView(weak_textBackView, textBackView)
    self.textView = [UITextView allocInit];
    self.textView.font = textFont(14);
    self.textView.delegate = self;
    [textBackView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@5);
        make.center.equalTo(weak_textBackView);
    }];
    
    self.placeholderLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x919191) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.placeholderLabel.text = @"Leave a message...";
    [textBackView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.textView).offset(8);
        make.left.equalTo(wSelf.textView).offset(3);
    }];
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? bottomHeight : 0;
    UIButton * button = [UIButton allocInitWithTitle:@"SUBMIT" color:kColor(0xffffff) selectedTitle:@"SUBMIT" selectedColor:kColor(0xffffff) font:18];
    button.backgroundColor = button_back_color;
    [button addTarget:self action:@selector(clickOnSubmitRepairOrder) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.left.right.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.view).offset(-buttonBottom);
    }];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden = textView.text.length;
}



- (void)clickOnSubmitRepairOrder
{
    
//    if (![XZZFormatValidation emailFormatValidation:self.textField.text]) {
//        SVProgressError(@"Please enter the correct email information");
//        return;
//    }
    if (self.textView.text.length == 0) {
        SVProgressError(@"Please enter a question");
        return;
    }
    WS(wSelf)
    
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:User_Infor.email email:User_Infor.email];
//    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCJwt alloc] initWithToken:User_Infor.email];
    [[ZDKZendesk instance] setIdentity:userIdentity];
    
    ZDKRequestProvider *provider = [ZDKRequestProvider new];
    ZDKCreateRequest *request = [ZDKCreateRequest new];
    
    request.subject = User_Infor.email;
    request.requestDescription = self.textView.text;
    loadView(self.view);
    [provider createRequest:request withCallback:^(id result, NSError *error) {
        
        NSLog(@"%@", result);
        if (result) {
            
            ZDKDispatcherResponse * dispatchResponse = result;
            id responseObject = [NSJSONSerialization JSONObjectWithData:dispatchResponse.data options:NSJSONReadingMutableContainers error:nil];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary * dic = responseObject;
                NSDictionary * requestDic = dic[@"request"];
                [wSelf storeWorkOrderInformationID:requestDic[@"id"]];
            }

            
           
        }else{
            SVProgressError(@"Feedback failed");
            loadViewStop
        }
        
    }];
    
    
}

- (void)storeWorkOrderInformationID:(NSString *)requestID
{
    NSDictionary * dic = nil;
    if (requestID) {
        dic = @{@"tokenId" : requestID, @"email" : User_Infor.email, @"title" : User_Infor.email, @"content" : self.textView.text};
    }else{
        return;
    }
    WS(wSelf)
    [XZZDataDownload userGetAddFeedbackDic:dic httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(@"Feedback successfully")
            [wSelf back];
        }else{
            SVProgressError(@"Feedback failed");
        }
        
    }];
}

@end

//
//  XZZSupportViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSupportViewController.h"
#import "XZZChatViewController.h"
#import "XZZRepairOrderListViewController.h"
#import "XZZSubmitRepairOrderViewController.h"
#import "XZZHelpViewController.h"
#import "XZZFillEmailInforView.h"

@interface XZZSupportViewController ()

@end

@implementation XZZSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.myTitle = @"Support";
    
    [self addView];
}


- (void)addView{
    
    WS(wSelf)
    
    UIView * view = [self crteateViewText:@"FAQ" iconName:@"support_FAQ"];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(helpInformation)]];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(@10);
        make.height.equalTo(@45);
    }];
    weakView(weak_view1, view)
    view = [self crteateViewText:@"My Tickets" iconName:@"support_my_tickets"];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(repairOrderList)]];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_view1.mas_bottom);
        make.height.equalTo(@45);
    }];
    weakView(weak_view2, view)
    view = [self crteateViewText:@"Submit a Ticket" iconName:@"support_submit_ticket"];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addProcessingSingle)]];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_view2.mas_bottom);
        make.height.equalTo(@45);
    }];
    weakView(weak_view3, view)
    view = [self crteateViewText:@"Online Chat" iconName:@"support_online_chat"];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beganChat)]];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(weak_view3.mas_bottom);
        make.height.equalTo(@45);
    }];
    
    
    
}
#pragma mark ----*  添加工单
/**
 *  添加工单
 */
- (void)addProcessingSingle
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (!User_Infor.isLogin) {
        logInVC(self)
        return;
    }
//    ZDKRequestUiConfiguration * config = [[ZDKRequestUiConfiguration alloc] init];
//    config.tags = @[@"Create Request"];
//    config.subject = @"Test from create request";
    //Present the SDK
//    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:User_Infor.email email:User_Infor.email];
//    [[ZDKZendesk instance] setIdentity:userIdentity];
//    UIViewController *requestScreen = [ZDKRequestUi buildRequestUiWith:@[]];
//    [self.navigationController pushViewController:requestScreen animated:YES];
//    return;
    
    XZZSubmitRepairOrderViewController * submitVC = [XZZSubmitRepairOrderViewController allocInit];
    [self pushViewController:submitVC animated:YES];
    
}
#pragma mark ----*  开始聊天
/**
 *  开始聊天
 */
- (void)beganChat
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    if (User_Infor.isLogin) {
        [self setChatMessagesEmail:User_Infor.email];
        return;
    }
    
    [self setChatMessagesEmail:nil];
    return;
    
    NSString * key = @"Save_chat_email";
    NSString * email = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (email.length) {
        [self setChatMessagesEmail:email];
        return;
    }
    
    WS(wSelf)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please enter email information." message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil]];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if (email_Format(userNameTextField.text)) {
            NSString * emailTwo = userNameTextField.text;
            [wSelf setChatMessagesEmail:emailTwo];
            [[NSUserDefaults standardUserDefaults] setValue:emailTwo forKey:key];
        }else{
            SVProgressError(@"Incorrect mailbox format")
        }
    }]];
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please enter email address";
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}
#pragma mark ---- *  设置聊天信息
/**
 *  设置聊天信息
 */
- (void)setChatMessagesEmail:(NSString *)email
{
    ZDCVisitorInfo * infor = [[ZDCVisitorInfo alloc] init];
    infor.email = email;
    infor.name = email;
    
    
    
//
    [ZDCChatAPI instance].visitorInfo = infor;
//
//        ZDCAPIConfig * config = [[ZDCAPIConfig alloc] init];
//        config.department = @"Jolimall";
//        config.tags = @[@"sdk", @"iOS"];
//        [[ZDCChatAPI instance] startChatWithAccountKey:@"7mystxxrnxaJHXsq0wMAQ2apchPXxW0S" config:config];
    
    
//    [ZDCChat startChatIn:self.navigationController withConfig:^(ZDCConfig *config) {
//        config.department = @"Jolimall";
//        config.tags = @[@"Jolimall", @"ios"];
//        config.preChatDataRequirements.email = ZDCPreChatDataRequired;
//        config.emailTranscriptAction = ZDCEmailTranscriptActionNeverSend;
//    }];
//    return;
    
    XZZChatViewController * chatVC = [XZZChatViewController allocInit];
    chatVC.email = email;
    [self pushViewController:chatVC animated:YES];
}
#pragma mark ----*  工单列表
/**
 *  工单列表
 */
- (void)repairOrderList
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (!User_Infor.isLogin) {
        logInVC(self)
        return;
    }
//    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:User_Infor.email email:User_Infor.email];
//    [[ZDKZendesk instance] setIdentity:userIdentity];
//
//    UIViewController *requestListController = [ZDKRequestUi buildRequestList];
//    [self.navigationController pushViewController:requestListController animated:YES];
//    return;
    NSLog(@"%s %d 行", __func__, __LINE__);
    XZZRepairOrderListViewController * repairListVC = [XZZRepairOrderListViewController allocInit];
    [self pushViewController:repairListVC animated:YES];
}
#pragma mark ----*  帮助信息
/**
 *  帮助信息
 */
- (void)helpInformation
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    XZZHelpViewController * helpVC = [XZZHelpViewController allocInit];
//    UIViewController *helpCenter = [ZDKHelpCenterUi buildHelpCenterOverviewUiWithConfigs:@[]];
    [self.navigationController pushViewController:helpVC animated:YES];
}



- (UIView *)crteateViewText:(NSString *)text iconName:(NSString *)iconName
{
    UIView * view = [UIView allocInit];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    weakView(weak_view, view)
    UIImageView * iconImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:iconName];
    [view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_view);
        make.left.equalTo(@15);
    }];
    weakView(weak_iconImageView, iconImageView)
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x323232) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.text = text;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_iconImageView.mas_right).offset(10);
        make.top.bottom.equalTo(weak_view);
    }];
    
    
    UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_view).offset(-15);
        make.centerY.equalTo(weak_view);
    }];
    
    weakView(weak_label, label)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [view addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_label);
        make.bottom.centerX.equalTo(weak_view);
        make.height.equalTo(@.5);
    }];
    
    return view;
}





@end

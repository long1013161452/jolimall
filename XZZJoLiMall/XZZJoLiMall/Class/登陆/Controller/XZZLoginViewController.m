//
//  XZZLoginViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZLoginViewController.h"

#import "XZZLogInView.h"
#import "XZZRegisteredView.h"
#import "XZZThirdPartyView.h"
#import "XZZChangePasswordViewController.h"
#import "XZZBindingEmailViewController.h"

#import "XZZSetUpInforModel.h"
#import "XZZSetDetailsViewController.h"

@interface XZZLoginViewController ()<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>


/**
 * 登陆
 */
@property (nonatomic, strong)XZZLogInView * loginView;

/**
 * 注册
 */
@property (nonatomic, strong)XZZRegisteredView * registeredView;

/**
 * 按钮下划线
 */
@property (nonatomic, strong)UIView * dividerView;

/**
 * 背景视图
 */
@property (nonatomic, strong)UIView * loginBackView;

@end

@implementation XZZLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameVC = @"登陆注册";
    
    FBSDKLoginManager * login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WS(wSelf)
    UIButton * backButton = [UIButton allocInit];
    [backButton setImage:imageName(@"login_back") forState:(UIControlStateNormal)];
    [backButton setImage:imageName(@"login_back") forState:(UIControlStateHighlighted)];
    [backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (StatusRect.size.height == 44) {
            make.top.equalTo(@50);
        }else{
            make.top.equalTo(@30);
        }
        make.left.equalTo(wSelf.view).offset(10);
        make.width.height.equalTo(@40);
    }];
    
    [self addView];
}

- (void)addView{
    
    WS(wSelf)
    
    CGFloat logoBackTop = ScreenWidth > 320 ? 120 : 80;
    
    UIView * logoBackView = [UIView allocInit];
    [self.view addSubview:logoBackView];
    [logoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(@(logoBackTop));
    }];
    
    FLAnimatedImageView * logoImageView = [FLAnimatedImageView allocInit];
    logoImageView.image = imageName(@"login_logo");
    [logoBackView addSubview:logoImageView];
    weakView(weakLogoBackView, logoBackView)
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakLogoBackView);
    }];
    
    UILabel * logoLabel = [UILabel allocInit];
    logoLabel.text = @"Jolimall";
    logoLabel.font = textFont(25);
    logoLabel.textColor = button_back_color;
    [logoBackView addSubview:logoLabel];
    weakView(weakLogoImageView, logoImageView)
    [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(weakLogoBackView);
        make.left.equalTo(weakLogoImageView.mas_right).offset(3);
    }];
    
    CGFloat logInAndLogoBackSpacing = ScreenWidth > 320 ? 30 : 10;
    /***  切换至登陆按钮 */
    UIButton * logInButton = [UIButton allocInit];
    [logInButton setTitle:@"LOG IN" forState:(UIControlStateNormal)];
    [logInButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    logInButton.titleLabel.font = textFont_bold(20);
    [logInButton addTarget:self action:@selector(selectLoginMode:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:logInButton];
    [logInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view).offset(-wSelf.view.width / 4.0);
        make.top.equalTo(weakLogoBackView.mas_bottom).offset(logInAndLogoBackSpacing);
    }];
    weakView(weakLogInButton, logInButton)
    /***  切换注册按钮 */
    UIButton * singUPButton = [UIButton allocInit];
    [singUPButton setTitle:@"SIGN UP" forState:(UIControlStateNormal)];
    [singUPButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    singUPButton.titleLabel.font = textFont_bold(20);
    [singUPButton addTarget:self action:@selector(selectRegisterMode:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:singUPButton];
    [singUPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view).offset(wSelf.view.width / 4.0);
        make.top.equalTo(weakLogInButton);
    }];
    
    weakView(weakSingUPButton, singUPButton)
    self.dividerView = [UIView allocInit];
    self.dividerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.dividerView];
    [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSingUPButton);
        make.height.equalTo(@1);
        make.centerX.equalTo(wSelf.view).offset(wSelf.view.width / 4.0);
        make.width.equalTo(@70);
    }];
    
    CGFloat loginBackAndDividerSpacing = ScreenWidth > 320 ? 15 : 10;
    
    /***  登陆注册背景视图 */
    self.loginBackView = [UIView allocInit];
    [self.view addSubview:self.loginBackView];
    [self.loginBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.dividerView.mas_bottom).offset(loginBackAndDividerSpacing);
        make.width.equalTo(@(ScreenWidth * 2));
        make.left.equalTo(@(-ScreenWidth));
    }];
    NSString * email =  [[NSUserDefaults standardUserDefaults] objectForKey:@"my_email"];

    /***  登陆视图 */
    self.loginView = [XZZLogInView allocInit];
    self.loginView.emailTextField.text = email.length ? email : @"";
    [self.loginView setLogIn:^{
        [wSelf logIn];
    }];
    [self.loginView setChangePassword:^{
        [wSelf changePassword];
    }];
    [self.loginBackView addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wSelf.loginBackView);
        make.width.equalTo(@(ScreenWidth));
    }];
    /***  注册视图 */
    self.registeredView = [XZZRegisteredView allocInit];
    [self.registeredView setSingUp:^{
        [wSelf singUp];
    }];
    [self.registeredView setViewRegistrationTerms:^{
        [wSelf viewSingUpAgreement];
    }];
    [self.loginBackView addSubview:self.registeredView];
    [self.registeredView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(wSelf.loginBackView);
        make.left.equalTo(wSelf.loginView.mas_right);
    }];
    
    /***  第三方登陆 */
    XZZThirdPartyView * thirdPartyView = [XZZThirdPartyView allocInit];
    [thirdPartyView setFbThirdPartyLogin:^{
        [wSelf fbThirdParty];
    }];
    [thirdPartyView setAppleThirdPartyLogin:^{
        [wSelf appleThirdParty];
    }];
    [thirdPartyView setViewPrivacyPolicy:^{
        [wSelf privacyPolicy];
    }];
    [self.view addSubview:thirdPartyView];
    [thirdPartyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        if (StatusRect.size.height > 20) {
            make.bottom.equalTo(wSelf.view).offset(-30);
        }else{
            make.bottom.equalTo(wSelf.view);
        }
    }];
    
}

- (void)selectLoginMode:(UIButton *)button
{
    WS(wSelf)
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3 animations:^{
        [self.dividerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.view).offset(-wSelf.view.width / 4.0);
        }];
        [self.loginBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
        }];

    [self.dividerView.superview layoutIfNeeded];//强制绘制
        [self.loginBackView.superview layoutIfNeeded];
    }];

}

- (void)selectRegisterMode:(UIButton *)button
{
    WS(wSelf)
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3 animations:^{
        [self.dividerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.view).offset(wSelf.view.width / 4.0);
        }];

        [self.loginBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(-ScreenWidth));
        }];
    [self.dividerView.superview layoutIfNeeded];//强制绘制
    
    }];
}
#pragma mark ----*  登陆
/**
 *  登陆
 */
- (void)logIn
{
    [self.view endEditing:YES];
    if (!email_Format(self.loginView.emailTextField.text)) {
        SVProgressError(@"Incorrect mailbox format")
        return;
    }
    
    if (self.loginView.passwordTextField.text.length == 0) {
        SVProgressError(@"Wrong password format")
        return;
    }
    
    loadView(self.view)
    WS(wSelf)
    [XZZDataDownload logInGetLogInName:self.loginView.emailTextField.text password:self.loginView.passwordTextField.text httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (error) {
            SVProgressError(@"Try again later")
        }else if (successful){
            SVProgressSuccess(@"Log in successfully")
            [[NSUserDefaults standardUserDefaults] setObject:wSelf.loginView.emailTextField.text forKey:@"my_email"];
            [wSelf back];
        }else{
            if ([data isKindOfClass:[NSString class]]) {
                SVProgressError(data)
            }
        }
    }];
    
}
#pragma mark ----*  修改密码
/**
 *  修改密码
 */
- (void)changePassword
{
    XZZChangePasswordViewController * changePasswordVC = [XZZChangePasswordViewController allocInit];
    [self pushViewController:changePasswordVC animated:YES];
}
#pragma mark ----*  注册
/**
 *  注册
 */
- (void)singUp
{
    [self.view endEditing:YES];
    if (!email_Format(self.registeredView.emailTextField.text)) {
        SVProgressError(@"Incorrect mailbox format")
        return;
    }
    if (self.registeredView.passwordTextField.text.length == 0) {
        SVProgressError(@"Wrong password format")
        return;
    }
    if (![self.registeredView.passwordTextField.text isEqualToString:self.registeredView.twoPasswordTextField.text]) {
        SVProgressError(@"Different password from the last one")
        return;
    }
    if (!self.registeredView.selectionState) {
        SVProgressError(@"Please agree to the registration agreement")
        return;
    }
    loadView(nil)
    WS(wSelf)
    [XZZDataDownload logInGetRegisteredName:self.registeredView.emailTextField.text password:self.registeredView.passwordTextField.text httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(@"Registered successfully")
            [[NSUserDefaults standardUserDefaults] setObject:wSelf.registeredView.emailTextField.text forKey:@"my_email"];
            [wSelf back];
        }else if (error){
            SVProgressError(@"Try again later")
        }else{
            SVProgressError(data);
        }
    }];
}
#pragma mark ----*  查看注册协议
/**
 *  查看注册协议
 */
- (void)viewSingUpAgreement
{
    if ([XZZALLSetUpInfor shareAllSetUpInfor].setUpInforArray.count > 4) {
        XZZSetUpInforModel * setUpInfor = [XZZALLSetUpInfor shareAllSetUpInfor].setUpInforArray[4];
        XZZSetDetailsViewController * setDetailsVC = [XZZSetDetailsViewController allocInit];
        setDetailsVC.setUpInfor = setUpInfor;
        [self pushViewController:setDetailsVC animated:YES];
    }
}
#pragma mark ----*  第三方登陆
/**
 *  第三方登陆
 */
- (void)fbThirdParty
{
    WS(wSelf)
    FBSDKLoginManager * login = [[FBSDKLoginManager alloc] init];
//    [login logOut];
    [login logInWithPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (result) {
            FBSDKAccessToken * token = result.token;
            if (token.userID) {
                [wSelf FBID:token.userID name:@"" email:@""];
                loadView(wSelf.view)
            }
        }
    }];
//    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if (result) {
//            FBSDKAccessToken * token = result.token;
//            if (token.userID) {
//                [wSelf FBID:token.userID name:@"" email:@""];
//                loadView(wSelf.view)
//            }
//        }
//    }];
}

#pragma mark ---- * 苹果登陆
/**
 * 苹果登陆
 */
- (void)appleThirdParty
{
    [self handleAuthorizationAppleIDButtonPress];
}

// 处理授权
- (void)handleAuthorizationAppleIDButtonPress{
    NSLog(@"////////");
    
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }
}

#pragma mark - delegate
//@optional 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    NSLog(@"授权完成:::%@", authorization.credential);
    // 测试配置UI显示
    NSMutableString *mStr = [NSMutableString string];
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *user = appleIDCredential.user;//000436.41461e9b09d14f928d29dcf673eb79be.0202
        NSString *familyName = appleIDCredential.fullName.familyName;
        NSString *givenName = appleIDCredential.fullName.givenName;
        NSString *email = appleIDCredential.email;
        NSData *identityToken = appleIDCredential.identityToken;
        NSData *authorizationCode = appleIDCredential.authorizationCode;

        [self appleLogIn:user name:[NSString stringWithFormat:@"%@%@", familyName.length ? familyName : @"", givenName.length ? givenName : @""] email:email];

    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        [self appleLogIn:user name:@"" email:@""];

        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;
        if (user.length) {
            [mStr appendString:user];
            [mStr appendString:@"\n"];
        }
        
        if (password.length) {
            [mStr appendString:password];
            [mStr appendString:@"\n"];
        }
        NSLog(@"mStr:::%@", mStr);

    }else{
        NSLog(@"授权信息均不符");
        mStr = [@"授权信息均不符" copy];
    }
}

// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {

    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            SVProgressError(@"Cancel the authorization");
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            SVProgressError(@"Authorization failure");
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            SVProgressError(@"Authorization is invalid");
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            SVProgressError(@"Authorization not processed");
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            SVProgressError(@"Authorization failure");
            break;
            
        default:
            break;
    }
}

// 告诉代理应该在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    // 返回window
    return self.view.window;
}


/**
 * apple  login
 */
- (void)appleLogIn:(NSString *)code name:(NSString *)name email:(NSString *)email
{
    if (name.length <= 0) {
        name = nil;
    }
    if (email.length <= 0) {
        email = nil;
    }
    WS(wSelf);
    loadView(self.view);
    [XZZDataDownload logInGetIOSIdLogInEmail:nil appleId:code appleName:nil httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(@"Log in successfully")
            [wSelf back];
        }else if (!error){
            if (data) {
                [wSelf appleRegistered:code name:name email:email];
            }else{
                SVProgressError(@"Try again later")
            }
        }else{
        }
    }];
}

- (void)appleRegistered:(NSString *)code name:(NSString *)name email:(NSString *)email
{
    if (name.length <= 0) {
        name = nil;
        [self bindingEmailWithIOSID:code name:name];
        return;
    }
    if (email.length <= 0) {
        email = nil;
        [self bindingEmailWithIOSID:code name:name];
        return;
    }
    
    WS(wSelf);
    loadView(self.view);
    [XZZDataDownload logInGetIOSIdLogInEmail:email appleId:code appleName:name httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(@"Log in successfully")
            [wSelf back];
        }else if (!error){
            if (data) {
                    [wSelf bindingEmailWithIOSID:code name:name];
            }else{
                SVProgressError(@"Try again later")
            }
        }else{
        }
    }];
}


#pragma mark ----*  第三方登陆
/**
 *  第三方登陆
 */
- (void)FBID:(NSString *)userId name:(NSString *)name email:(NSString *)email
{
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload logInGetFacebookIdLogInEmail:email facebookId:userId facebookName:name httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(@"Log in successfully")
            [wSelf back];
        }else if (!error){
            if (data) {
                if (email.length) {
                    [wSelf bindingEmailWithFBID:userId name:name];
                }else{
                    [wSelf getUserInforWithFBUserId:userId];
                }
            }else{
                SVProgressError(@"Try again later")
            }
        }else{
        }
    }];
}
#pragma mark ----*  获取fb的用户信息
/**
 *  获取fb的用户信息
 */
- (void)getUserInforWithFBUserId:(NSString *)userId
{
    NSDictionary * params = @{ @"fields" : @"id,name,email,age_range,first_name,last_name,link,gender,locale,picture,timezone,updated_time,verified"};
    WS(wSelf)
    FBSDKGraphRequest  * request = [[FBSDKGraphRequest  alloc ]
                                    initWithGraphPath : userId
                                    parameters : params
                                    HTTPMethod : @"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        NSLog(@"%@   %@   %@", result[@"first_name"], result[@"last_name"], result[@"name"]);
        NSString * email = result[@"email"];
        NSString * name = result[@"name"];
        NSString * ID = result[@"id"];
        if (email.length) {
            [wSelf FBID:ID name:name.length ? name : @"" email:email];
        }else{
            [wSelf bindingEmailWithFBID:ID name:name.length ? name : @""];
        }
    }];
}

#pragma mark ----*  绑定邮箱
/**
 *  绑定邮箱
 */
- (void)bindingEmailWithFBID:(NSString *)userID name:(NSString *)name
{
    XZZBindingEmailViewController * bingEmailVC = [XZZBindingEmailViewController allocInit];
    bingEmailVC.FBName = name;
    bingEmailVC.FBUserID = userID;
    [self pushViewController:bingEmailVC animated:YES];
}


#pragma mark ----*  绑定邮箱  apple 登陆
/**
 *  绑定邮箱    apple 登陆
 */
- (void)bindingEmailWithIOSID:(NSString *)userID name:(NSString *)name
{
    XZZBindingEmailViewController * bingEmailVC = [XZZBindingEmailViewController allocInit];
    bingEmailVC.appleID = userID;
    bingEmailVC.appleName = name;
    [self pushViewController:bingEmailVC animated:YES];
}

#pragma mark ----*  隐私条款
/**
 *  隐私条款
 */
- (void)privacyPolicy
{
    XZZWebViewController * webVC = [XZZWebViewController allocInit];
    webVC.urlStr = @"https://m.jolimall.com/ios";
    webVC.myTitle = @"Private Policy";
    [self pushViewController:webVC animated:YES];
    
}

@end

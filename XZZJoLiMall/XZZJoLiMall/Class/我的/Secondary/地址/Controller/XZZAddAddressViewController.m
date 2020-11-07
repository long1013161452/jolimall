//
//  XZZAddAddressViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddAddressViewController.h"
#import "XZZSelectGeographicInforViewController.h"
#import "XZZAddressEditorView.h"
#import "XZZCountryInfor.h"

@interface XZZAddAddressViewController ()<UITextFieldDelegate>

/**
 * firstNameView
 */
@property (nonatomic, strong)XZZAddressEditorView * firstNameView;

/**
 * lastNameView
 */
@property (nonatomic, strong)XZZAddressEditorView * lastNameView;

/**
 * 地址1
 */
@property (nonatomic, strong)XZZAddressEditorView * address1View;

/**
 * 地址2
 */
@property (nonatomic, strong)XZZAddressEditorView * address2View;

/**
 * 国家
 */
@property (nonatomic, strong)XZZAddressEditorView * countryView;

/**
 * 省
 */
@property (nonatomic, strong)XZZAddressEditorView * provinceView;

/**
 * 城市
 */
@property (nonatomic, strong)XZZAddressEditorView * cityView;

/**
 * zip
 */
@property (nonatomic, strong)XZZAddressEditorView * zipView;

/**
 * 电话
 */
@property (nonatomic, strong)XZZAddressEditorView * phoneView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * defaultAddressButton;

/**
 * 国家信息
 */
@property (nonatomic, strong)XZZCountryInfor * countryInfor;

/**
 * 省的信息
 */
@property (nonatomic, strong)XZZProvinceInfor * provinceInfor;

/**
 * 城市信息
 */
@property (nonatomic, strong)XZZCityInfor * cityInfor;

@end

@implementation XZZAddAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.fd_interactivePopDisabled = YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)back
{
    for (NSInteger i = self.navigationController.viewControllers.count - 1; i >= 0; i--) {
        UIViewController * vc = self.navigationController.viewControllers[i];
        if ([vc isKindOfClass:NSClassFromString(@"XZZAddressListViewController")]) {
            if (User_Infor.addressArray.count > 0) {
                [self popToViewController:vc animated:YES];
                return;
            }
        }
        if ([vc isKindOfClass:NSClassFromString(@"XZZCreditCardViewController")]) {
            [self popToViewController:vc animated:YES];
            return;
        }
        if ([vc isKindOfClass:NSClassFromString(@"XZZCheckOutViewController")]) {
            if (User_Infor.addressArray.count == 0) {
                NSInteger count = i - 1;
                count = count > 0 ? count : 0;
                vc = self.navigationController.viewControllers[count];
                [self popToViewController:vc animated:YES];
                return;
            }
        }
        if ([vc isKindOfClass:NSClassFromString(@"XZZCartViewController")]) {
            [self popToViewController:vc animated:YES];
            return;
        }
    }
    [self popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.myTitle = @"ADDRESS";
    
    if (self.addressInfor) {
        self.nameVC = @"修改地址";
    }else{
        self.nameVC = @"添加地址";
    }
    [self addView];
}

- (void)addView{
    
    WS(wSelf)
    
    UIScrollView * scrollView = [UIScrollView allocInit];
    scrollView.backgroundColor = kColor(0xffffff);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf.view);
    }];
    weakView(weak_scrollView, scrollView)
    UIButton * addAddressButton = [UIButton allocInitWithTitle:@"SUBMIT" color:kColor(0xffffff) selectedTitle:@"SUBMIT" selectedColor:kColor(0xffffff) font:18];
    addAddressButton.backgroundColor = button_back_color;
    [addAddressButton addTarget:self action:@selector(clickOnAddOrEditAddressesButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addAddressButton];
    CGFloat buttonBottom = StatusRect.size.height > 20 ? -bottomHeight : 0;
    [addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.height.equalTo(@(50));
        make.top.equalTo(weak_scrollView.mas_bottom);
        make.bottom.equalTo(wSelf.view).offset(buttonBottom);
    }];
    
    
    CGFloat height = 50;
    UIView * topView = nil;
    for (int i = 0; i < 9; i++) {
        XZZAddressEditorView * addressEditorView = [XZZAddressEditorView allocInit];
        [scrollView addSubview:addressEditorView];
        weakView(weak_topView, topView)
        [addressEditorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.view);
            make.height.equalTo(@(height));
            if (weak_topView) {
                make.top.equalTo(weak_topView.mas_bottom);
            }else{
                make.top.equalTo(@0);
            }
        }];
        topView = addressEditorView;
        switch (i) {
            case 0:{
                self.firstNameView = addressEditorView;
                addressEditorView.title = @"First Name*";
            }
                break;
            case 1:{
                self.lastNameView = addressEditorView;
                addressEditorView.title = @"Last Name*";
            }
                break;
            case 2:{
                self.address1View = addressEditorView;
                addressEditorView.title = @"Address 1*";
                addressEditorView.textField.delegate = self;
                addressEditorView.textField.placeholder = @"(address 1&2) character limit: 5-40";
            }
                break;
            case 3:{
                self.address2View = addressEditorView;
                addressEditorView.title = @"Address 2";
                addressEditorView.textField.delegate = self;
                addressEditorView.textField.placeholder = @"(address 1&2) character limit: 5-40";
            }
                break;
            case 4:{
                self.countryView = addressEditorView;
                addressEditorView.title = @"Country/Region*";
                addressEditorView.input = NO;
                [addressEditorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCountry)]];
            }
                break;
            case 5:{
                self.provinceView = addressEditorView;
                addressEditorView.title = @"State/Province/Region*";
                addressEditorView.input = NO;
                [addressEditorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseProvince)]];
            }
                break;
            case 6:{
                self.cityView = addressEditorView;
                addressEditorView.title = @"City*";
                addressEditorView.input = NO;
                [addressEditorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCity)]];
            }
                break;
            case 7:{
                self.zipView = addressEditorView;
                addressEditorView.title = @"ZIP/Postal Code*";
            }
                break;
            case 8:{
                self.phoneView = addressEditorView;
                addressEditorView.title = @"Phone Number";
            }
                break;
            default:
                break;
        }
        
    }
    
    if (User_Infor.isLogin) {
        UILabel * defaultAddressLabel = [UILabel allocInit];
        defaultAddressLabel.text = @"  Set as default shipping address";
        defaultAddressLabel.textColor = kColor(0x2e2e2e);
        defaultAddressLabel.font = textFont(12);
        [scrollView addSubview:defaultAddressLabel];
        defaultAddressLabel.userInteractionEnabled = YES;
        [defaultAddressLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnSetTheDefault)]];
        [defaultAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom);
            make.height.equalTo(@40);
        }];
        weakView(weak_defaultAddressLabel, defaultAddressLabel)
        UIButton * defaultAddressButton = [UIButton allocInit];
        [defaultAddressButton setImage:imageName(@"cart_goods_no_selected") forState:(UIControlStateNormal)];
        [defaultAddressButton setImage:imageName(@"cart_goods_selected") forState:(UIControlStateSelected)];
        [defaultAddressButton addTarget:self action:@selector(clickOnSetTheDefault) forControlEvents:(UIControlEventTouchUpInside)];
        [scrollView addSubview:defaultAddressButton];
        self.defaultAddressButton = defaultAddressButton;
        [defaultAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(weak_defaultAddressLabel.mas_left);
            make.centerY.equalTo(weak_defaultAddressLabel);
            make.width.height.equalTo(@20);
        }];
    }
    
    
    scrollView.contentSize = CGSizeMake(0, height * 9 + 80);
    
    if (self.addressInfor) {//视图赋值
        self.countryInfor = [XZZCountryInfor allocInit];
        self.countryInfor.ID = self.addressInfor.countryId;
        self.countryInfor.countryEnName = self.addressInfor.countryName;
        self.countryInfor.countryCode = self.addressInfor.countryCode;
        self.provinceInfor = [XZZProvinceInfor allocInit];
        self.provinceInfor.ID = self.addressInfor.provinceId;
        self.provinceInfor.provinceName = self.addressInfor.provinceName;
        self.provinceInfor.provinceCode = self.addressInfor.provinceCode;
        
        self.cityInfor = [XZZCityInfor allocInit];
        self.cityInfor.ID = self.addressInfor.cityId;
        self.cityInfor.cityName = self.addressInfor.cityName;
        
        
        self.firstNameView.textField.text = self.addressInfor.firstName;
        self.lastNameView.textField.text = self.addressInfor.lastName;
        self.address1View.textField.text = self.addressInfor.detailAddress1;
        self.address2View.textField.text = self.addressInfor.detailAddress2;
        self.countryView.textField.text = self.addressInfor.countryName;
        self.provinceView.textField.text = self.addressInfor.provinceName;
        self.cityView.textField.text = self.addressInfor.cityName;
        self.zipView.textField.text = self.addressInfor.zipCode;
        self.phoneView.textField.text = self.addressInfor.phone;
        self.defaultAddressButton.selected = self.addressInfor.status;
        [addAddressButton setTitle:@"MODIFY ADDRESS" forState:(UIControlStateNormal)];
    }
    
}
#pragma mark ----设置默认
/**
 *  设置默认
 */
- (void)clickOnSetTheDefault{
    self.defaultAddressButton.selected = !self.defaultAddressButton.selected;
}
#pragma mark ----*  点击添加或者编辑l地址
/**
 *  点击添加或者编辑l地址
 */
- (void)clickOnAddOrEditAddressesButton
{
    if (self.firstNameView.textField.text.length <= 0) {
        [self.firstNameView inputUnfilledContent];
        return;
    }
    if (self.lastNameView.textField.text.length <= 0) {
        [self.lastNameView inputUnfilledContent];
        return;
    }
    if (self.address1View.textField.text.length <= 0) {
        [self.address1View inputUnfilledContent];
        return;
    }
    if (self.address1View.textField.text.length + self.address2View.textField.text.length < 5) {
        SVProgressError(self.address1View.textField.placeholder)
        return;
    }
    if (self.countryView.textField.text.length <= 0) {
        [self.countryView inputUnfilledContent];
        return;
    }
    if (self.provinceView.textField.text.length <= 0) {
        [self.provinceView inputUnfilledContent];
        return;
    }
    if (self.cityView.textField.text.length <= 0) {
        [self.cityView inputUnfilledContent];
        return;
    }
    if (self.zipView.textField.text.length <= 0) {
        [self.zipView inputUnfilledContent];
        return;
    }
    XZZAddressInfor * addressInfor = self.addressInfor;
    if (!addressInfor) {
        addressInfor = [XZZAddressInfor allocInit];
    }
    addressInfor.firstName = self.firstNameView.textField.text;
    addressInfor.lastName = self.lastNameView.textField.text;
    addressInfor.detailAddress1 = self.address1View.textField.text;
    addressInfor.detailAddress2 = self.address2View.textField.text;
    addressInfor.countryName = self.countryView.textField.text;
    addressInfor.countryId = self.countryInfor.ID;
    addressInfor.countryCode = self.countryInfor.countryCode;
    addressInfor.provinceName = self.provinceView.textField.text;
    addressInfor.provinceId = self.provinceInfor.ID;
    addressInfor.provinceCode = self.provinceInfor.provinceCode;
    addressInfor.cityName = self.cityView.textField.text;
    addressInfor.cityId = self.cityInfor.ID;
    addressInfor.zipCode = self.zipView.textField.text;
    addressInfor.phone = self.phoneView.textField.text;
    addressInfor.status = self.defaultAddressButton.selected;
    WS(wSelf)
    loadView(self.view)
    if (self.addressInfor) {
        
        [User_Infor modifyAddress:self.addressInfor newAddress:addressInfor httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                SVProgressSuccess(@"Shipping address modified successfully")
                if ([wSelf.delegate respondsToSelector:@selector(addOrEditorAddressInforSuccessfully:newAddressInfor:)]) {
                    [wSelf.delegate addOrEditorAddressInforSuccessfully:wSelf.addressInfor newAddressInfor:data];
                }
                [wSelf popViewControllerAnimated:YES];
            }else{
                SVProgressError(@"Shipping address modified failed")
            }
        }];
        
        return;
    }
    [User_Infor addAddress:addressInfor httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(data)
            if ([wSelf.delegate respondsToSelector:@selector(addOrEditorAddressInforSuccessfully:newAddressInfor:)]) {
                [wSelf.delegate addOrEditorAddressInforSuccessfully:nil newAddressInfor:nil];
            }
            [wSelf popViewControllerAnimated:YES];
        }else{
            SVProgressError(data)
        }
    }];
    
    
    
    
}


#pragma mark ----*  选择国家
/**
 *  选择国家
 */
- (void)chooseCountry
{
    [self.view endEditing:YES];
    if (User_Infor.allCountriesArray.count) {
        [self selectGeographicInfor:User_Infor.allCountriesArray];
    }else{
        [self downloadCountryInfor];
    }
}

#pragma mark ----*  下载国家信息
/**
 *  下载国家信息
 */
- (void)downloadCountryInfor
{
    WS(wSelf)
    [XZZDataDownload userGetCountryHttpBlock:^(id data, BOOL successful, NSError *error) {
        User_Infor.allCountriesArray = data;
        [wSelf chooseCountry];
    }];
}


#pragma mark ----*  选择z省
/**
 *  选择z省
 */
- (void)chooseProvince
{
    [self.view endEditing:YES];
    if (!self.countryInfor) {
        [self chooseCountry];
    }else{
        [self downloadProvinceInfor];
    }
}
#pragma mark ----*  下载州信息
/**
 *  下载州信息
 */
- (void)downloadProvinceInfor
{
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload userGetProvinceFameCountry:self.countryInfor httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf selectGeographicInfor:data];
        }else{
            wSelf.provinceView.input = YES;
            wSelf.cityView.input = YES;
            [wSelf.provinceView.textField becomeFirstResponder];
        }
    }];
}
#pragma mark ----*  选择城市
/**
 *  选择城市
 */
- (void)chooseCity
{
    [self.view endEditing:YES];
    if (!self.provinceInfor){
        [self chooseProvince];
    }else{
        [self downloadCityInfor];
    }
}
#pragma mark ----*  下载城市信息
/**
 *  下载城市信息
 */
- (void)downloadCityInfor
{
    WS(wSelf)
    loadView(self.view)
    [XZZDataDownload userGetCityFameProvince:self.provinceInfor httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            [wSelf selectGeographicInfor:data];
        }else{
            wSelf.cityView.input = YES;
            [wSelf.cityView.textField becomeFirstResponder];
        }
    }];
}
#pragma mark ----*  选择地理位置信息  国家、州、城市
/**
 *  选择地理位置信息  国家、州、城市
 */
- (void)selectGeographicInfor:(NSArray *)array
{
    WS(wSelf)
    XZZSelectGeographicInforViewController * vc = [XZZSelectGeographicInforViewController allocInit];
    vc.inforArray = array;
    [vc setSelectInfor:^(id  _Nonnull data) {
        if ([data isKindOfClass:[XZZCountryInfor class]]) {
            wSelf.countryInfor = data;
            wSelf.countryView.textField.text = ((XZZCountryInfor *)data).countryEnName;
            [wSelf.countryView textFieldDidChange:wSelf.countryView.textField];
            wSelf.provinceView.input = NO;
            wSelf.provinceView.textField.text = @"";
            wSelf.cityView.input = NO;
            wSelf.cityView.textField.text = @"";
        }else if ([data isKindOfClass:[XZZProvinceInfor class]]){
            wSelf.provinceInfor = data;
            wSelf.provinceView.textField.text = ((XZZProvinceInfor *)data).provinceName;
            [wSelf.provinceView textFieldDidChange:wSelf.provinceView.textField];
            wSelf.cityView.input = NO;
            wSelf.cityView.textField.text = @"";
        }else if ([data isKindOfClass:[XZZCityInfor class]]){
            wSelf.cityInfor = data;
            wSelf.cityView.textField.text = ((XZZCityInfor *)data).cityName;
            [wSelf.cityView textFieldDidChange:wSelf.cityView.textField];
        }
    }];
    [self pushViewController:vc animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) {
        return YES;
    }
    NSInteger length = 0;
    if ([textField isEqual:self.address1View.textField]) {
        length = 40 - self.address2View.textField.text.length;
    }else{
        length = 40 - self.address1View.textField.text.length;
    }
    
    if (textField.text.length + string.length <= length) {
        return YES;
    }
    return NO;
}


@end

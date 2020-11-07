//
//  XZZCheckOutEditAddressInforView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutEditAddressInforView.h"

@implementation XZZCheckOutEditAddressInforView

+ (instancetype)allocInit
{
    XZZCheckOutEditAddressInforView * view = [super allocInit];
    [view addView];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)addView{
    WS(wSelf)
    UIView * topView = nil;
    CGFloat height = 50;
    for (int i = 0; i < 9; i++) {
        XZZAddressEditorView * addressEditorView = [XZZAddressEditorView allocInit];
        [self addSubview:addressEditorView];
        weakView(weak_topView, topView)
        [addressEditorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf);
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
                addressEditorView.textField.placeholder = @"(address 1&2) character limit: 5-40";
                addressEditorView.textField.delegate = self;
            }
                break;
            case 3:{
                self.address2View = addressEditorView;
                addressEditorView.title = @"Address 2";
                addressEditorView.textField.placeholder = @"(address 1&2) character limit: 5-40";
                addressEditorView.textField.delegate = self;
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
    
    [topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf);
    }];
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

#pragma mark ----*  选择国家
/**
 *  选择国家
 */
- (void)chooseCountry
{
    [self.selectCountryInforViewModel chooseCountry];
}


#pragma mark ----*  选择z省
/**
 *  选择z省
 */
- (void)chooseProvince
{
    [self.selectCountryInforViewModel chooseProvince];
}

#pragma mark ----*  选择城市
/**
 *  选择城市
 */
- (void)chooseCity
{
    [self.selectCountryInforViewModel chooseCity];
}


- (void)setSelectCountryInforViewModel:(XZZSelectCountryInforViewModel *)selectCountryInforViewModel
{
        _selectCountryInforViewModel = selectCountryInforViewModel;
        _selectCountryInforViewModel.countryView = self.countryView;
        _selectCountryInforViewModel.provinceView = self.provinceView;
        _selectCountryInforViewModel.cityView = self.cityView;
}

- (void)setAddressInfor:(XZZAddressInfor *)addressInfor
{
    _addressInfor = addressInfor;
        self.selectCountryInforViewModel.countryInfor = [XZZCountryInfor allocInit];
        self.selectCountryInforViewModel.countryInfor.ID = self.addressInfor.countryId;
        self.selectCountryInforViewModel.countryInfor.countryEnName = self.addressInfor.countryName;
        self.selectCountryInforViewModel.countryInfor.countryCode = self.addressInfor.countryCode;
    
        self.selectCountryInforViewModel.provinceInfor = [XZZProvinceInfor allocInit];
        self.selectCountryInforViewModel.provinceInfor.ID = self.addressInfor.provinceId;
        self.selectCountryInforViewModel.provinceInfor.provinceName = self.addressInfor.provinceName;
        self.selectCountryInforViewModel.provinceInfor.provinceCode = self.addressInfor.provinceCode;
        
        self.selectCountryInforViewModel.cityInfor = [XZZCityInfor allocInit];
        self.selectCountryInforViewModel.cityInfor.ID = self.addressInfor.cityId;
        self.selectCountryInforViewModel.cityInfor.cityName = self.addressInfor.cityName;
        
        
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
    
    
    if (self.address1View.textField.text.length + self.address2View.textField.text.length > 40) {
        self.address1View.textField.text = @"";
    }
    
}

@end

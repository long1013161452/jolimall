//
//  XZZSelectCountryInforViewModel.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSelectCountryInforViewModel.h"

#import "XZZSelectGeographicInforViewController.h"

@implementation XZZSelectCountryInforViewModel


#pragma mark ----*  选择国家
/**
 *  选择国家
 */
- (void)chooseCountry
{
    [self.VC.view endEditing:YES];
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
    [self.VC.view endEditing:YES];
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
    loadView(self.VC.view)
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
    [self.VC.view endEditing:YES];
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
    loadView(self.VC.view)
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
    [self.VC pushViewController:vc animated:YES];
}

@end

//
//  XZZSelectCountryInforViewModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZAddressEditorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZZSelectCountryInforViewModel : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, weak)UIViewController * VC;

/**
 * 国家
 */
@property (nonatomic, weak)XZZAddressEditorView * countryView;

/**
 * 省
 */
@property (nonatomic, weak)XZZAddressEditorView * provinceView;

/**
 * 城市
 */
@property (nonatomic, weak)XZZAddressEditorView * cityView;

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

/**
 *  选择国家
 */
- (void)chooseCountry;
/**
 *  选择z省
 */
- (void)chooseProvince;
/**
 *  选择城市
 */
- (void)chooseCity;

@end

NS_ASSUME_NONNULL_END

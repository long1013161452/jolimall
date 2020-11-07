//
//  XZZCheckOutEditAddressInforView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZAddressEditorView.h"

#import "XZZSelectCountryInforViewModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示可编辑地址信息
 */
@interface XZZCheckOutEditAddressInforView : UIView<UITextFieldDelegate>

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
 * <#expression#>
 */
@property (nonatomic, strong)XZZSelectCountryInforViewModel * selectCountryInforViewModel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddressInfor * addressInfor;

@end

NS_ASSUME_NONNULL_END

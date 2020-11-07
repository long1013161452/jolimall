//
//  XZZCheckOutBouncedEditAddressView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCheckOutEditAddressInforView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  编辑地址   弹框
 */
@interface XZZCheckOutBouncedEditAddressView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddressInfor * addressInfor;
/**
 * 编辑地址信息
 */
@property (nonatomic, strong)XZZCheckOutEditAddressInforView * editAddressInforView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSelectCountryInforViewModel * selectCountryInforViewModel;
/**
 * <#expression#>
 */
@property (nonatomic, weak)UIViewController * VC;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock editAddressInforBlock;

/**
 * 加载到父视图  
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;

@end

NS_ASSUME_NONNULL_END

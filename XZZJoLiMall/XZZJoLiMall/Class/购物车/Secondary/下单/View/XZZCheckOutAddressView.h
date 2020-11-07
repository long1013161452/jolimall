//
//  XZZCheckOutAddressView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCheckOutTitleView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示地址信息
 */
@interface XZZCheckOutAddressView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddressInfor * address;


/**
 * 选择地址
 */
@property (nonatomic, strong)GeneralBlock chooseAddress;

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * arrowImageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutTitleView * titleView;


@end

NS_ASSUME_NONNULL_END

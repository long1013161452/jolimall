//
//  XZZCheckOutShowAddressInforView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZCheckOutTitleView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示选中的地址信息
 */
@interface XZZCheckOutShowAddressInforView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddressInfor * address;


/**
 * 选择地址
 */
@property (nonatomic, strong)GeneralBlock changeAddress;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutTitleView * titleView;

@end

NS_ASSUME_NONNULL_END

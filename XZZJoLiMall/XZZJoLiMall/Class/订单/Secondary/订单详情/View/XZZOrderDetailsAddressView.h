//
//  XZZOrderDetailsAddressView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  d订单详情   地址信息
 */
@interface XZZOrderDetailsAddressView : UIView
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
@end

NS_ASSUME_NONNULL_END

//
//  XZZAddressTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZAddressTableViewCell : UITableViewCell


/**
 * 选择
 */
@property (nonatomic, assign)BOOL chooseAddress;

/**
 * 地址信息
 */
@property (nonatomic, strong)XZZAddressInfor * addressInfor;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL isSelected;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

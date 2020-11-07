//
//  XZZOrderListTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZOrderList.h"


NS_ASSUME_NONNULL_BEGIN

/**
 *  订单
 */
@interface XZZOrderListTableViewCell : UITableViewCell

+ (CGFloat)calculateHeight:(XZZOrderList *)orderList;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZOrderList * orderList;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

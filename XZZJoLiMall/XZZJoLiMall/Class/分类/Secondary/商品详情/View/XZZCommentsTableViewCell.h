//
//  XZZCommentsTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/27.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZGoodsScore.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  评论的cell
 */
@interface XZZCommentsTableViewCell : UITableViewCell

/**
 *  计算高度
 */
+ (CGFloat)calculateHeightCell:(XZZGoodsComments *)comments;



/**
 * 评论信息
 */
@property (nonatomic, strong)XZZGoodsComments * goodsComments;



/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

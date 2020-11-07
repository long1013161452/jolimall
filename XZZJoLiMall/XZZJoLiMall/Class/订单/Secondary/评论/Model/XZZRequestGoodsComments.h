//
//  XZZRequestGoodsComments.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  对商品评论
 */
@interface XZZRequestGoodsComments : NSObject


/**
 * 商品id信息
 */
@property (nonatomic, strong)NSString * goodsId;
/**
 * skuid信息
 */
@property (nonatomic, strong)NSString * skuId;
/**
 * 用户email
 */
@property (nonatomic, strong)NSString * username;
/**
 * 评论内容
 */
@property (nonatomic, strong)NSString * content;
/**
 * 合身程度  0 小； 1正好； 2 大
 */
@property (nonatomic, assign)int fit;
/**
 * 评分
 */
@property (nonatomic, assign)int score;



@end

NS_ASSUME_NONNULL_END

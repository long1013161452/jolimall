//
//  XZZGoodsCommentsViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RemoveCanCommentSku)(XZZCanCommentSku * canCommentSku);
/**
 *  商品评论
 */
@interface XZZGoodsCommentsViewController : XZZMainViewController

/**
 * 评论id信息
 */
@property (nonatomic, strong)NSString * commentId;
/**
 * sku评论信息   list
 */
@property (nonatomic, strong)NSArray * skuOrderList;
/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;
/**
 * 展示的第几个
 */
@property (nonatomic, assign)NSInteger index;

/**
 * 移除评论信息
 */
@property (nonatomic, strong)RemoveCanCommentSku removeCanCommentSku;

@end

NS_ASSUME_NONNULL_END

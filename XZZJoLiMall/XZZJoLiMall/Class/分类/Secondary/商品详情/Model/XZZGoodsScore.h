//
//  XZZGoodsScore.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZOrderSku.h"

NS_ASSUME_NONNULL_BEGIN

@class XZZCanCommentSku;

/**
 *  商品评分
 */
@interface XZZGoodsScore : NSObject

/**
 * 合适的数量  比例 * 100之后的
 */
@property (nonatomic, assign)CGFloat rightPercent;// "rightPercent": 0,
/**
 * 平均分
 */
@property (nonatomic, assign)CGFloat averageScore;// "avgScore": 10,
/**
 * 总人数
 */
@property (nonatomic, assign)int totalCommentCount;// "totalRows": 3,
/**
 * 大的人数  比例 * 100之后的
 */
@property (nonatomic, assign)CGFloat bigPercent;// "bigPercent": 0,
/**
 * 小的人数  比例  *  100之后的
 */
@property (nonatomic, assign)CGFloat smallPercent;// "smallPercent": 0

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray<XZZCanCommentSku *> * canCommentList;

@end

/**
 *  商品评论
 */
@interface XZZGoodsComments : NSObject
/**
 * id
 */
@property (nonatomic, assign)int ID;
/**
 * 名字
 */
@property (nonatomic, strong)NSString * username;// "username": "string",
/**
 * 时间
 */
@property (nonatomic, strong)NSString * commentTime;// "commentDate": 1537394500000,
/**
 * 评论内容
 */
@property (nonatomic, strong)NSString * content;// "content": "string",
/**
 * 分数
 */
@property (nonatomic, assign)int score;// "score": 0,
/**
 * 合身  0 Small    1 Ture to Size    2 Big
 */
@property (nonatomic, assign)int suitability;// "fit": 1,
/**
 * 图片信息
 */
@property (nonatomic, strong)NSString * pictureUrls;
/**
 * 评论图片信息
 */
@property (nonatomic, strong)NSArray<NSString *> * pictureList;

/**
 * 修改过么
 */
@property (nonatomic, assign)int isModified;

@end


@interface XZZCanCommentSku : NSObject
/**
 * 订单id
 */
@property (nonatomic, strong)NSString * orderId;
/**
 * skuid
 */
@property (nonatomic, strong)NSString * skuId;
/**
 * sku code
 */
@property (nonatomic, strong)NSString * skuCode;
/**
 * 商品标题
 */
@property (nonatomic, strong)NSString * goodsTitle;
/**
 * goodsCode
 */
@property (nonatomic, strong)NSString * goodsCode;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsId;
/**
 * ssku 图片
 */
@property (nonatomic, strong)NSString * image;
/**
 * sku 颜色
 */
@property (nonatomic, strong)NSString * color;
/**
 * sku 尺码
 */
@property (nonatomic, strong)NSString * size;
/**
 * 数量
 */
@property (nonatomic, strong)NSString * quantity;

/**
 * 价格
 */
@property (nonatomic, assign)CGFloat price;



+ (XZZCanCommentSku *)canCommentSku:(XZZOrderSku *)orderSku ;


@end



NS_ASSUME_NONNULL_END

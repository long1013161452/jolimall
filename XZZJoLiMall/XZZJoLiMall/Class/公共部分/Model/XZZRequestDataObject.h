//
//  XZZRequestDataObject.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/17.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  请求信息  分类获取商品
 */
@interface XZZRequestCategoryGoods : NSObject


/**
 * 颜色id
 */
@property (nonatomic, strong)NSArray * colorCodeList;

/**
 * 一级分类id
 */
@property (nonatomic, strong)NSString * categoryId;

/**
 * 尺码id
 */
@property (nonatomic, strong)NSArray * sizeCodeList;

/**
 * 页码
 */
@property (nonatomic, assign)int pageNum;

/**
 * 一页多少
 */
@property (nonatomic, assign)int pageSize;

/**
 * 排序
 */
@property (nonatomic, assign)int orderBy;

/**
 * 推荐商品id集合
 */
@property (nonatomic, strong)NSArray * toppingGoodsIdList;


@end


/**
 *  请求信息  活动获取商品
 */
@interface XZZRequestActivityGoods : NSObject

/**
 * id
 */
@property (nonatomic, strong)NSArray * goodsIdList;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * activityId;

/**
 * 页码
 */
@property (nonatomic, assign)int pageNum;

/**
 * 排序
 */
@property (nonatomic, assign)int orderBy;

/**
 * 一页数量
 */
@property (nonatomic, assign)int pageSize;
/**
 * 推荐商品id集合
 */
@property (nonatomic, strong)NSArray * toppingGoodsIdList;

@end
/**
 * 优惠券商品
 */
@interface XZZRequestCouponGoods : NSObject
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * couponId;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * goodsIdList;
/**
 * <#expression#>
 */
@property (nonatomic, assign)int pageNum;
/**
 * <#expression#>
 */
@property (nonatomic, assign)int pageSize;
/**
 * 排除商品id
 */
@property (nonatomic, strong)NSString * recommendExcludeGoodsId;
/**
 * 查询类型  推荐x  y  可不传
 */
@property (nonatomic, strong)NSString * recommendType;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * toppingGoodsIdList;
/**
 * 排序
 */
@property (nonatomic, assign)int orderBy;

@end

/**
 * 关键字查询商品
 */
@interface XZZRequestRecommendedGoods : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, assign)int orderBy;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * goodsIdList;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int page;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * keywords;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int pageSize;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * toppingGoodsIdList;


@end


@interface XZZRequestSeckillGoods : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, assign)int orderBy;
/**
 * <#expression#>
 */
@property (nonatomic, assign)int pageNum;
/**
 * <#expression#>
 */
@property (nonatomic, assign)int pageSize;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * seckillId;

@end

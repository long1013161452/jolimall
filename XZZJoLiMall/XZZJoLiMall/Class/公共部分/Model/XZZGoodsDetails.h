//
//  XZZGoodsDetails.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZCouponsInfor.h"

#import "XZZActivityInfor.h"

NS_ASSUME_NONNULL_BEGIN

@class XZZGoods, XZZSku, XZZColor, XZZSize, XZZCategoryMap, XZZGoodsDescribe, XZZSecKillVo;


@interface XZZGoodsDetails : NSObject
/**
 * 活动信息
 */
@property (nonatomic, strong)XZZActivityInfor * activityVo;
/**
 * 秒杀
 */
@property (nonatomic, strong)XZZSecKillVo * secKillVo;
/**
 * 商品信息
 */
@property (nonatomic, strong)XZZGoods * goods;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<XZZCouponsInfor *> * couponList;
/**
 * sku list
 */
@property (nonatomic, strong)NSArray<XZZSku *> * skuList;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<XZZCategoryMap *> * categoryMap;
/**
 * 颜色信息
 */
@property (nonatomic, strong)NSArray<XZZColor *> * colorInforArray;

/**
 * 存储colorcode查找size信息
 */
@property (nonatomic, strong)NSMutableDictionary * colorCodeDictionary;

/**
 * 存储sizecode查找color信息
 */
@property (nonatomic, strong)NSMutableDictionary * sizeCodeDictionary;

/**
 * size信息
 */
@property (nonatomic, strong)NSArray<XZZSize *> * sizeInforArray;

/**
 * 所有的图片信息
 */
@property (nonatomic, strong)NSArray * picArray;

/**
 *  根据颜色  尺寸获取sku信息
 */
- (XZZSku *)accordingColor:(XZZColor *) color size:(XZZSize *)size;




@end

@interface XZZGoods : NSObject


/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * attribute;//    string
/**
 * 商品code
 */
@property (nonatomic, strong)NSString * code;//    string
/**
 * 售价
 */
@property (nonatomic, assign)CGFloat currentPrice;//    number
/**
 * 打折率
 */
@property (nonatomic, assign)CGFloat discountPercent;
/**
 * 折后价
 */
@property (nonatomic, assign)CGFloat discountPrice;
/**
 * <#expression#>
 */
@property (nonatomic, assign)int delFlag;//    integer($int32)
/**
 * 描述
 */
@property (nonatomic, strong)NSArray<XZZGoodsDescribe *> * descriptionJson;//    string
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * descriptionJsonStr;
/**
 * 描述
 */
@property (nonatomic, strong)NSString * descriptionStr;//    string
/**
 * id信息
 */
@property (nonatomic, strong)NSString * ID;//    integer($int64)
/**
 * 简介
 */
@property (nonatomic, strong)NSString * introduction;
/**
 * 关键词
 */
@property (nonatomic, strong)NSString * keywords;//    string
/**
 * 原价
 */
@property (nonatomic, assign)CGFloat nominalPrice;//    number
/**
 * 主图
 */
@property (nonatomic, strong)NSString * pictureUrl;//    string
/**
 * 商品附图
 */
@property (nonatomic, strong)NSArray<NSString *> * subPicturesList;
/**
 * 主图
 */
@property (nonatomic, strong)NSString * smallPictureUrl;//    string
/**
 * 销售数量
 */
@property (nonatomic, assign)NSInteger salesNum ;//   integer($int32)
/**
 * size type
 */
@property (nonatomic, strong)NSString * sizeTypeCode ;//   string
/**
 * type 图片链接
 */
@property (nonatomic, strong)NSString * sizeTypeCodePicture;
/**
 * 状态
 */
@property (nonatomic, assign)NSInteger status  ;//  integer($int32)
/**
 * 标题
 */
@property (nonatomic, strong)NSString * title  ;//  string

/**
 * 重量
 */
@property (nonatomic, assign)int weight;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * youSave;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<NSNumber *> * associatedGoods;


@end

@interface XZZSku : NSObject

/**
 * 活动信息
 */
@property (nonatomic, strong)XZZActivityInfor * activityVo;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecKillVo * secKillVo;
/**
 * 商品code
 */
@property (nonatomic, strong)NSString * goodsCode;
/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;

/**
 * sku code
 */
@property (nonatomic, strong)NSString * code;//    string sku code
/**
 * 颜色code
 */
@property (nonatomic, strong)NSString * colorCode;//    string 颜色code

/**
 * string 颜色名称
 */
@property (nonatomic, strong)NSString * colorName ;//   string 颜色名称

/**
 * integer($int64) sku主键Id
 */
@property (nonatomic, strong)NSString * ID;//    integer($int64) sku主键Id

/**
 * string sku颜色主图
 */
@property (nonatomic, strong)NSString * mainPicture ;//   string sku颜色主图
/**
 * shortSizeCode  展示的缩减尺码
 */
@property (nonatomic, strong)NSString * shortSizeCode;
/**
 * string 尺码code，即前台展示尺码
 */
@property (nonatomic, strong)NSString * sizeCode ;//   string 尺码code，即前台展示尺码

/**
 * string 尺码名称，即后台展示尺码
 */
@property (nonatomic, strong)NSString * sizeName  ;//  string 尺码名称，即后台展示尺码

/**
 *  number sku价格
 */
@property (nonatomic, assign)CGFloat  skuPrice  ;//  number sku价格
/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat skuNominalPrice;
/**
 * integer($int32) sku上下架状态 0:下架 1：上架
 */
@property (nonatomic, assign)NSInteger status ;//   integer($int32) sku上下架状态 0:下架 1：上架
/**
 * 库存
 */
@property (nonatomic, strong)NSNumber * stock;
/**
 * string sku颜色副图，用英文的 ; 分开
 */
@property (nonatomic, strong)NSString * subPictures;//    string sku颜色副图，用英文的 ; 分开

/**
 * 商品图片
 */
@property (nonatomic, strong)NSArray * picturesArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsTitle;
/**
 * 重量
 */
@property (nonatomic, assign)int weight;

@end


@interface XZZColor : NSObject


/**
 * 颜色code
 */
@property (nonatomic, strong)NSString * colorCode;//    string 颜色code
/**
 * string sku颜色主图
 */
@property (nonatomic, strong)NSString * mainPicture;//   string sku颜色主图

/**
 * string sku颜色主图   小的     90*120的
 */
@property (nonatomic, strong)NSString * smallMainPicture;

/**
 * string 颜色名称
 */
@property (nonatomic, strong)NSString * colorName ;//   string 颜色名称
/**
 * 商品图片
 */
@property (nonatomic, strong)NSArray * picturesArray;

+ (instancetype)allocInitFrame:(XZZSku *)sku;

@end

@interface XZZSize : NSObject


/**
 * shortSizeCode  展示的缩减尺码
 */
@property (nonatomic, strong)NSString * shortSizeCode;
/**
 * string 尺码code，即前台展示尺码
 */
@property (nonatomic, strong)NSString * sizeCode ;//   string 尺码code，即前台展示尺码

/**
 * string 尺码名称，即后台展示尺码
 */
@property (nonatomic, strong)NSString * sizeName  ;//  string 尺码名称，即后台展示尺码


+ (instancetype)allocInitFrame:(XZZSku *)sku;


@end




@interface XZZCategoryMap : NSObject

/**
 * 一级分类id
 */
@property (nonatomic, assign)NSInteger firstCatId;
/**
 * 一级分类名字
 */
@property (nonatomic, strong)NSString * firstName;

/**
 * 二级分类id
 */
@property (nonatomic, assign)NSInteger secondCatId;
/**
 * 二级分类名字
 */
@property (nonatomic, strong)NSString * secondName;

/**
 * 三级分类id
 */
@property (nonatomic, assign)NSInteger thirdCatId;
/**
 * 三级分类名字
 */
@property (nonatomic, strong)NSString * thirdName;

/**
 * 商品id
 */
@property (nonatomic, assign)NSInteger goodsId;

@end

/**
 *  商品描述
 */
@interface XZZGoodsDescribe : NSObject

/**
 * 描述内容
 */
@property (nonatomic, strong)NSString * desc;

/**
 * 描述标题
 */
@property (nonatomic, strong)NSString * title;

@end

/**
 *  商品描述
 */
@interface XZZSecKillVo : NSObject

/**
 * m结束时间
 */
@property (nonatomic, strong)NSString * endTime;

/**
 * 秒杀c名
 */
@property (nonatomic, strong)NSString * name;
/**
 * 秒杀价格
 */
@property (nonatomic, assign)CGFloat salePrice;

/**
 * 秒杀id
 */
@property (nonatomic, strong)NSString * secKillId;

@end




NS_ASSUME_NONNULL_END

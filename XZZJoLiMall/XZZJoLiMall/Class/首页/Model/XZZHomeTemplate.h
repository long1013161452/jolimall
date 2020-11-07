//
//  XZZHomeTemplate.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//推荐的定义枚举类型的方式
typedef NS_ENUM(NSInteger, XZZHomeTemplateType) {
    XZZHomeTemplateTypeHomeShufflingFigure = 2,//轮播图
    XZZHomeTemplateTypeClassificationChellysun = 3, // 分类 chellysun
    XZZHomeTemplateTypeTwoAdvertisingChellysunTwo = 4, //两个广告  chellysun  一排两个的
    XZZHomeTemplateTypeTwoAdvertisingChellysun = 5, //两个广告  chellysun  一排一个
    XZZHomeTemplateTypeThreeAdvertising = 6, //三个广告
    XZZHomeTemplateTypeCountdownChellysun = 7, //倒计时  chellysun上的样式
    XZZHomeTemplateTypeHomeRecommendedCategory = 8, //底部推荐分类信息

    XZZHomeTemplateTypeCountdown,//倒计时
    XZZHomeTemplateTypeTwoAdvertising, //两个广告
    XZZHomeTemplateTypeClassification, //分类
    XZZHomeTemplateTypeAdvertisingAndGoods, // 广告带商品的
};


/**
 *  首页模板信息
 */
@interface XZZHomeTemplate : NSObject

/**
 * (integer, optional): 楼层序号 ,
 */
@property (nonatomic, assign)int floorNum;// (integer, optional): 楼层序号 ,
/**
 * ): id ,
 */
@property (nonatomic, assign)int ID;// (integer, optional): id ,
/**
 * 对应的id信息
 */
//@property (nonatomic, strong)NSString * assoId;
/**
 *  (string, optional): 链接url ,  对应的id信息
 */
@property (nonatomic, strong)NSString * assoContent;// (string, optional): 链接url ,

/**
 * (integer, optional): 关联类型，1一级分类，2二级分类，3三级分类,4活动，5url ,
 */
@property (nonatomic, assign)int  assoType;// (integer, optional): 关联类型，1一级分类，2二级分类，3三级分类,4活动，5url ,

/**
 *  2：底部商品展示样式（分类、活动、全部）  3：倒计时样式（分类、活动）  4：轮播样式（分类、活动、url）（两端共有）5：促销海报（初版2张）（分类、活动、url） 6：促销海报  (初版3张)  （分类、活动、url） 7：促销横幅（初版1张）（分类、活动、url） 10：分类图标（初版8张）（分类、活动、url） 11：倒计时（大）（分类、活动） 12：海报1张（矮）（分类、活动、url） 13：海报1张（高）（分类、活动、url） 14：海报4张（分类、活动、url） 15：商品展示（分类、活动）
 */
@property (nonatomic, assign)int styleId;// (integer, optional): 样式id ,
/**
 * 2：底部商品展示样式（分类、活动、全部）  3：倒计时样式（分类、活动）  4：轮播样式（分类、活动、url）（两端共有）5：促销海报（初版2张）（分类、活动、url） 6：促销海报  (初版3张)  （分类、活动、url） 7：促销横幅（初版1张）（分类、活动、url） 10：分类图标（初版8张）（分类、活动、url） 11：倒计时（大）（分类、活动） 12：海报1张（矮）（分类、活动、url） 13：海报1张（高）（分类、活动、url） 14：海报4张（分类、活动、url） 15：商品展示（分类、活动）
 */
@property (nonatomic, assign)int styleType;
/**
 *  (string, optional): 卡片名称 ,
 */
@property (nonatomic, strong)NSString *  name;// (string, optional): 卡片名称 ,
/**
 *  图片地址1 ,
 */
@property (nonatomic, strong)NSString * picture;// (string, optional): 图片地址1 ,

/**
 * 样式名称 ,
 */
@property (nonatomic, strong)NSString * styleName;// (string, optional): 样式名称 ,

/**
 * 分类的   尺寸类型
 */
@property (nonatomic, assign)int sizeType;
/**
 * 排序字段
 */
@property (nonatomic, assign)int sortType;
/**
 * 展示的商品数量商品
 */
@property (nonatomic, assign)int showNum;

/**
 * 结束时间
 */
@property (nonatomic, strong)NSString * endTime;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<XZZHomeTemplate *> * cardList;

/**
 * 优惠券商品id集合
 */
@property (nonatomic, strong)NSArray<NSNumber *> * goodsIdList;

/**
 * 底部商品展示卡片中的置顶商品ID集合
 */
@property (nonatomic, strong)NSArray<NSNumber *> * toppingGoodsIdList;

@end

NS_ASSUME_NONNULL_END

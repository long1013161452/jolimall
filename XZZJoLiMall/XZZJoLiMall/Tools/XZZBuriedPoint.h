//
//  XZZBuriedPoint.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZZOrderDetail.h"


/**
 *  埋点信息
 */
@interface XZZBuriedPoint : NSObject



/**
 *  添加收藏 contentData 商品名 contentId 商品ID  contentType yes no   price 价格
 */
+ (void)logAddedToWishlistEvent:(NSString *)contentData
                      contentId:(NSString *)contentId
                    contentType:(NSString *)contentType
                       entrance:(NSString *)entrance;


/**
 *  注册埋点   登陆也埋进去
 */
+ (void)logCompletedRegistrationEvent:(NSString *)registrationMethod;
/**
 *  用户登陆
 */
+ (void)userLoginSource:(NSString *)source email:(NSString *)email;
/**
 *  搜索
 */
+ (void)search:(NSString *)search;

/**
 *  搜索
 */
+ (void)aws_search:(NSDictionary *)search ;
/**
 *  立即购买
 */
+ (void)aws_buyNow:(XZZCartInfor *)cart;
/**
 *  商品列表  分类
 */
+ (void)aws_ViewCategory:(NSDictionary *)ViewCategory;
/**
 *  商品列表  活动列表
 */
+ (void)aws_ViewActivity:(NSDictionary *)ViewActivity;

/**
 *  浏览商品
 */
+ (void)browseGoods:(XZZGoodsDetails *)goodsDetails entrance:(NSString *)entrance;
/**
 *  添加购物车
 */
+ (void)addToCart:(XZZGoodsDetails *)goodsDetails cart:(XZZCartInfor *)cart;
/**
 *  删除购物车
 */
+ (void)removalsFromCart:(XZZCartInfor *)cart;

/**
 *  点击购物车的Checkout
 */
+ (void)clickCheckout;

/**
 *  下单  埋点
 */
+ (void)placeOrderId:(NSString *)orderId Coupon:(NSString *)Coupon;
/**
 *  支付埋点  order订单信息  payType支付类型
 */
+ (void)payOrderId:(NSString *)orderId payType:(int)payType;
/**
 *  支付埋点  order订单信息  payType支付类型   
 */
+ (void)pay:(XZZOrderDetail *)order payType:(int)payType isFB:(BOOL)isFB;

/**
 *  分享   platform平台信息 1是facebook  2是messenger    3 是WhatsApp  4 是Pinterest
 */
+ (void)shareProductInfor:(XZZGoodsDetails *)goodsDetails platform:(int)platform;

+ (void)page:(NSString *)pageName className:(NSString *)className;

/**
 *  推送埋点
 */
+ (void)pushBuriedPointTitle:(NSString *)title;

/***  进入购物车 */
+ (void)cartPage;
/**
 *  用户寻求帮助的方式   type 1  帮助列表  2 工单列表  3 添加工单  4 聊天
 */
+ (void)SupportPerson:(int)type;



@end



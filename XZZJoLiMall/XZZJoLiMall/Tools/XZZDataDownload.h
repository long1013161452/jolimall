//
//  XZZDataDownload.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZZCategory.h"
#import "XZZRequestDataObject.h"
#import "XZZRequestSearch.h"
#import "XZZRequestOrder.h"
#import "XZZAddressInfor.h"
#import "XZZCountryInfor.h"
#import "XZZGoodsScore.h"
#import "XZZRequestSku.h"
#import "XZZRequestCalculatePrice.h"

@class XZZRequestCategoryGoods;

/**
 *  数据下载
 */
@interface XZZDataDownload : NSObject//2482.02

#pragma mark ---- *  商品模块
/**
 *  商品模块
 */
/***  获取首页模板 */
+ (void)goodsGetHomePageTemplateHttpBlock:(HttpBlock)httpBlock;
/***  获取活动商品信息 */
+ (void)goodsGetActivityGoods:(XZZRequestActivityGoods *)activityGoods httpBlock:(HttpBlock)httpBlock;
/***  获取分类商品信息 */
+ (void)goodsGetCategoryGoods:(XZZRequestCategoryGoods *)categoryGoods httpBlock:(HttpBlock)httpBlock;
/***  获取优惠券商品列表 */
+ (void)goodsGetCouponGoods:(XZZRequestCouponGoods *)couponGoods httpBlock:(HttpBlock)httpBlock;
/***  获取商品详情信息 */
+ (void)goodsGetGoodsDetails:(NSString *)goodsId entrance:(NSString *)entrance httpBlock:(HttpBlock)httpBlock;
/***  获取分类size信息 */
+ (void)goodsGetSizeLiostCategoryId:(NSString *)categoryId httpBlock:(HttpBlock)httpBlock;
/***  获取商品评分 */
+ (void)goodsGetGoodsScore:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock;
/***  获取商品评论 */
+ (void)goodsGetGoodsComments:(NSString *)goodsId page:(int)page httpBlock:(HttpBlock)httpBlock;
/***  新增评论 */
+ (void)goodsGetAddComments:(NSArray *)comments httpBlock:(HttpBlock)httpBlock;
/** 评论详情*/
+ (void)goodsGetCommentsId:(NSString *)commentId httpBlock:(HttpBlock)httpBlock;
/** 修改评论*/
+ (void)goodsGetModifyComments:(NSArray *)comments httpBlock:(HttpBlock)httpBlock;
/***  获取商品关联商品 */
+ (void)goodsGetGoodsRecommended:(XZZRequestRecommendedGoods *)recommendedGoods httpBlock:(HttpBlock)httpBlock;

#pragma mark ---- 活动

/** 获取活动信息*/
+ (void)activityGetActivityId:(NSString *)activityId httpBlock:(HttpBlock)httpBlock;
/** 获取秒杀活动商品*/
+ (void)activityGetSeckillGoods:(XZZRequestSeckillGoods *)seckillGoods httpBlock:(HttpBlock)httpBlock;
/** 获取秒杀场次*/
+ (void)activityGetSeckillInforHttpBlock:(HttpBlock)httpBlock;

#pragma mark ---- *  搜索
/**
 *  搜索
 */
/***  获取搜索热词 */
+ (void)searchGetHotSearchTermHttpBlock:(HttpBlock)httpBlock;
/***  获取搜索商品信息 */
+ (void)searchGetSearchGoods:(XZZRequestSearch *)search httpBlock:(HttpBlock)httpBlock;

#pragma mark ----*  分类模块
/**
*  分类模块
*/
/***  获取所有分类信息 */
+ (void)categoryGetAllInforHttpBlock:(HttpBlock)httpBlock;
#pragma mark ----*  购物车模块
/**
*  购物车模块
*/
/***  获取购物车信息 */
+ (void)cartGetShoppingCartInforHttpBlock:(HttpBlock)httpBlock;
/***  添加购物车信息   isPurchased yes为加购  no为同步*/
+ (void)cartAddShoppingCart:(NSArray<XZZCartInfor *> *)carts isPurchased:(BOOL)isPurchased httpBlock:(HttpBlock)httpBlock;
/***  修改购物车  count  true为加一；false为减一 */
+ (void)cartModifyShoppingCart:(XZZCartInfor *)cart count:(BOOL)count httpBlock:(HttpBlock)httpBlock;
/***  删除购物车 */
+ (void)cartDeleteShoppingCart:(XZZCartInfor *)cart httpBlock:(HttpBlock)httpBlock;
/***  获取sku信息 */
+ (void)cartGetSkuInforSkuIDs:(NSArray *)skuIds httpBlock:(HttpBlock)httpBlock;
#pragma mark ----*  订单
/**
*  订单
*/
/***  获取订单列表 */
+ (void)orderGetOrderListPage:(int)page httpBlock:(HttpBlock)httpBlock;
/***  获取订单详情 */
+ (void)orderGetOrderDetailsOrderId:(NSString *)orderId httpBlock:(HttpBlock)httpBlock;
/***  下单 */
+ (void)orderCheckOut:(XZZRequestCheckOut *)checkOut httpBlock:(HttpBlock)httpBlock;

/***  下单  计算价格信息 */
+ (void)orderGetPrice:(XZZRequestCalculatePrice *)calculatePrice httpBlock:(HttpBlock)httpBlock;
/***  获取邮费列表 */
+ (void)orderGetPostageHttpBlock:(HttpBlock)httpBlock;
/***  获取邮费列表 */
+ (void)orderGetPostageWeight:(int)weight goodsNum:(int)goodsNum httpBlock:(HttpBlock)httpBlock;
/***  计算运费信息 根据重量 */
+ (void)orderGetShippingFee:(int)weight httpBlock:(HttpBlock)httpBlock;
#pragma mark ---- *  支付模块
/**
 *  支付模块
 */
/***  支付 */
+ (void)payGetOrderPay:(XZZRequestOrderPay *)orderPay httpCodeBlock:(HttpCodeBlock)httpCodeBlock;
/***  获取支付类型 */
+ (void)payGetPaymentTypeHttpBlock:(HttpBlock)httpBlock;
/***  获取Stripe获取公钥 */
+ (void)payGetStripeKeyHttpBlock:(HttpBlock)httpBlock;
#pragma mark ----*  用户模块
/**
*  用户模块
*/
/***  获取IP地址 */
+ (void)userGetUserIpHttpBlock:(HttpBlock)httpBlock;
/***  获取用户反馈列表 */
+ (void)userGetFeedbackListPage:(int)page httpBlock:(HttpBlock)httpBlock;
/***  添加用户反馈 */
+ (void)userGetAddFeedbackDic:(NSDictionary *)dic httpBlock:(HttpBlock)httpBlock;
/***  基础信息 */
+ (void)userGetBasedInformationHttpBlock:(HttpBlock)httpBlock;
/***  获取设置信息列表 */
+ (void)userGetSetUpListInforHttpBlock:(HttpBlock)httpBlock;
/***  获取收藏列表 */
+ (void)userGetGoodsCollectionListHttpBlock:(HttpBlock)httpBlock;
/***  添加收藏 */
+ (void)userGetAddCollectionGoods:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock;
/***  删除收藏 */
+ (void)userGetDeleteCollectionGoods:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock;
/***  领取优惠券  根据code */
+ (void)userGetCouponsCode:(NSString *)code httpBlock:(HttpBlock)httpBlock;
/***  领取优惠券  根据params */
+ (void)userGetCouponsParams:(NSString *)params httpBlock:(HttpBlock)httpBlock;
/***  获取s下单时可用s的优惠券 */
+ (void)userGetCanUseCouponsSkuNum:(NSArray *)skuNumArray httpBlock:(HttpBlock)httpBlock;
/***  获取所有优惠券信息 */
+ (void)userGetCouponsListHttpBlock:(HttpBlock)httpBlock;
/***  获取商品优惠券 */
+ (void)userGetGoodsCoupons:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock;
/***  获取优惠券信息  根据id */
+ (void)userGetCouponsInforCouponsId:(NSString *)couponsId httpBlock:(HttpBlock)httpBlock;

#pragma mark ----地址信息
/***  获取地址列表 */
+ (void)userGetAddressListHttpBlock:(HttpBlock)httpBlock;
/***  添加地址信息 */
+ (void)userGetAddAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;
/***  删除地址信息 */
+ (void)userGetDeleteAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;
/***  修改地址信息 */
+ (void)userGetModifyAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;
/***  设置默认地址 */
+ (void)userGetSetDefaultAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;
/***  获取国家信息 */
+ (void)userGetCountryHttpBlock:(HttpBlock)httpBlock;
/***  获取省信息 */
+ (void)userGetProvinceFameCountry:(XZZCountryInfor *)country httpBlock:(HttpBlock)httpBlock;
/***  获取城市信息 */
+ (void)userGetCityFameProvince:(XZZProvinceInfor *)province httpBlock:(HttpBlock)httpBlock;


#pragma mark ----*  登陆注册
/**
*  登陆注册
*/
/***  登陆 */
+ (void)logInGetLogInName:(NSString *)name password:(NSString *)password httpBlock:(HttpBlock)httpBlock;
/***  注册 */
+ (void)logInGetRegisteredName:(NSString *)name password:(NSString *)password httpBlock:(HttpBlock)httpBlock;
/***  忘记密码 */
+ (void)logInGetForgotPasswordEmail:(NSString *)email httpBlock:(HttpBlock)httpBlock;
/***  facebook登陆 */
+ (void)logInGetFacebookIdLogInEmail:(NSString *)email facebookId:(NSString *)facebookId facebookName:(NSString *)facebookName httpBlock:(HttpBlock)httpBlock;
/***  Apple登陆 */
+ (void)logInGetIOSIdLogInEmail:(NSString *)email appleId:(NSString *)appleId appleName:(NSString *)appleName httpBlock:(HttpBlock)httpBlock;
/***  判断是否是新用户 */
+ (void)logInGetUserIsNewHttpBlock:(HttpBlock)httpBlock;

/***  获取基本授权 */
+ (void)logInGetAuthorizationHttpBlock:(HttpBlock)httpBlock;


#pragma mark ---- *  上传图片信息
/**
 *  上传图片信息
 */
+ (void)uploadPictureInformation:(UIImage *)image httpBlock:(HttpBlock)httpBlock;

@end



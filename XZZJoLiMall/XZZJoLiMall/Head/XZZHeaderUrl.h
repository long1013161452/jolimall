//
//  XZZHeaderUrl.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//


/**
 *  存储url链接信息
 */
#ifndef XZZHeaderUrl_h
#define XZZHeaderUrl_h


#ifdef CE_SHI_TEST//开发环境

///用于写http前缀
#define HTTP_MAIN my_AppDelegate.HTTPMAIN

/***  h5商品前缀 */
#define h5_goods_prefix my_AppDelegate.HTTPMAINGOODSH5

/***  h5 前缀 */
#define h5_prefix my_AppDelegate.HTTPMAINH5


#else //发布APP的时候使用
///用于写http前缀   线上环境的
#define HTTP_MAIN @"https://api-portal.greatmola.com/budgetmall/"

/***  h5商品前缀 */
#define h5_goods_prefix @"https://jolimall.com/goods/"

/***  h5 前缀 */
#define h5_prefix @"https://jolimall.com"

#endif



//
//#ifdef CE_SHI_DEV//开发环境
/////用于写http前缀   开发环境的
//
//#define HTTP_MAIN @"http://api-portal.dev.xzzcorp.com/jolimall/"
//
///***  h5商品前缀 */
//#define h5_goods_prefix @"https://m.jolimall.com/goods/"
//
///***  h5 前缀 */
//#define h5_prefix @"https://m.jolimall.com"
//
//#elif CE_SHI_TEST//测试环境
//
/////用于写http前缀   测试环境的
//#define HTTP_MAIN @"http://api-portal.test.xzzcorp.com/jolimall/"
//
///***  h5商品前缀 */
//#define h5_goods_prefix @"https://m.jolimall.com/goods/"
///***  h5 前缀 */
//#define h5_prefix @"http://m.jolimall.test.xzzcorp.com"
//
//#elif CE_SHI_YUFA//预发环境
//
/////用于写http前缀   测试环境的
//#define HTTP_MAIN @"https://api-portal.pre-release.greatmola.com/jolimall/"
//
///***  h5商品前缀 */
//#define h5_goods_prefix @"https://jolimall.pre-release.greatmola.com/goods/"
///***  h5 前缀 */
//#define h5_prefix @"https://jolimall.pre-release.greatmola.com"
//
//#elif CE_SHI_XS//线上环境
//
/////用于写http前缀   线上环境的
//#define HTTP_MAIN @"https://api-portal.greatmola.com/jolimall/"
//
///***  h5商品前缀 */
//#define h5_goods_prefix @"https://jolimall.com/goods/"
//
///***  h5 前缀 */
//#define h5_prefix @"https://jolimall.com"
//
//#else //发布APP的时候使用
/////用于写http前缀   线上环境的
//#define HTTP_MAIN @"https://api-portal.greatmola.com/jolimall/"
//
///***  h5商品前缀 */
//#define h5_goods_prefix @"https://jolimall.com/goods/"
//
///***  h5 前缀 */
//#define h5_prefix @"https://jolimall.com"
//
//#endif

/***  版本信息 */
#define user_version_get [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/version/get"]

/*** 公钥*/
#define key_pk [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"/key/pk"]

#pragma mark ----登陆模块
/**
 * 登录注册模块
 */

/*** 登录*/
#define user_login [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/login"]
/*** 注册*/
#define user_register [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/register"]
/*** fb绑定*/
#define user_facebook_register [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/facebook/register"]
/*** fb登录*/
#define user_facebook_login [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/facebook/login"]
/*** apple绑定*/
#define user_ios_register [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/ios/register"]
/*** apple登录*/
#define user_ios_login [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/ios/login"]
/*** 给用户发送邮件来重置密码 */
#define user_resetPwd_ [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/resetPwd/"]
/*** 判断新用户*/
#define order_firstPay [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/firstPay"]

/***  获取基本授权 */
#define user_authorization_basic [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/authorization/basic"]

#pragma mark ----用户模块
/**
 * 用户模块
 */
/*** 查询用户反馈*/
#define user_feedback [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/feedback"]
/*** 新增用户反馈*/
#define user_feedback_add [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/feedback/add"]
/*** 获取IP地址*/
#define user_ip [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/ip"]
/*** 获取基础信息*/
#define user_webSetting_get [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/webSetting/get"]
/*** 获取setup List*/
#define user_terms_get_APP [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/terms/get/APP"]
/*** code领取优惠卷*/
#define user_coupon_receiveByCode [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/coupon/receiveByCode"]
/*** params 领取优惠券*/
#define user_coupon_receiveByUrl [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/coupon/receiveByUrl"]
/*** 查找可用优惠券*/
#define user_coupon_login_canUse [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/coupon/login/canUse"]
/*** 优惠券列表*/
#define user_coupon_myCoupons [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/coupon/myCoupons"]
/*** 商品详情页获取优惠券列表*/
#define user_coupon_getCouponList [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/coupon/getCouponList"]
/*** 获取优惠券信息  根据优惠券id*/
#define user_coupon_getCouponRecommendVo [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/coupon/getCouponRecommendVo"]
#pragma mark ----地址信息
/*** 用户地址  列表*/
#define user_shipping_address_get [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/shipping/address/get"]
/*** 存储地址信息*/
#define user_shipping_address_add [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/shipping/address/add"]
/*** 删除地址信息*/
#define user_shipping_address_del [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/shipping/address/del"]
/*** 修改地址信息*/
#define user_shipping_address_update [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/shipping/address/update"]
/*** 设置成默认地址*/
#define user_shipping_address_setDefault [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/shipping/address/setDefault/"]

/*** 所有的国家信息*/
#define user_region_country_select [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/region/country/select"]
/*** 三级联动 获取省/州信息*/
#define user_region_province_select [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/region/province/select"]
/*** 三级联动  获取城市信息*/
#define user_region_city_select [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"user/region/city/select"]
/*** 用户反馈*/
#define feedBack_insert [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"/feedBack/insert"]
#pragma mark ----收藏信息
/*** 收藏列表*/
#define goods_favorite_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/favorite/list"]
/*** 处理收藏*/
#define goods_favorite [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/favorite"]
#pragma mark ----分类
/**
 * 分类模块
 */
/*** 分类*/
#define goods_category_all [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/category/all"]
#pragma mark ----订单
/**
 * 订单模块
 */
/*** 订单列表   新的*/
#define order_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/list"]
/*** 获取订单详情*/
#define order_detail [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/detail"]
/*** 获取邮费列表信息*/
#define order_postage_getList [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/postage/getList"]
/*** 获取邮费列表信息*/
#define order_v2_shippingFee [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/v2/shippingFee"]
/*** 计算运费  根据重量*/
#define order_shippingFee [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/shippingFee"]
/*** 计算价格   购物车   优惠码*/
#define order_couponDiscount [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/couponDiscount"]
/*** 下单*/
#define order_add [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/add"]
/*** 支付   信用卡支付*/
#define stripe_pay [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"/stripe/pay"]
/*** iPayLinks 支付*/
#define iPayLinks_pay [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"/iPayLinks/pay"]
/*** 支付   综合*/
#define payment_pay [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"payment/pay"]
/*** 查询支付配置*/
#define payment_payConfig_query [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"payment/payConfig/query"]
/*** asiaBill支付接口异步回调*/
#define payment_notify_asiaBill [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"payment/notify/asiaBill"]

/*** stripe key*/
#define payment_getPublicKey [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"payment/getPublicKey"]

/*** paypal支付的*/
#define payPal_pay [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"/payPal/pay"]
#pragma mark ----商品模块
/**
 * 商品模块
 */

/*** 首页b模板*/
#define goods_page [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/page/"]

/*** 获取搜索热词*/
#define goods_hotword [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/hotword"]

/*** 优惠券商品列表*/
#define search_coupon_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"search/coupon/list"]

/*** 搜索*/
#define search_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"search/list"]
/*** 获取商品信息  根据分类*/
#define search_category_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"search/category/list"]
/*** 获取商品id集合  根据活动id*/
#define activity_getActivityGoodsIdList [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"activity/getActivityGoodsIdList"]

/*** 获取搜索热词  关键词联想*/
#define search_keywords_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"search/keywords/list"]
/*** 获取活动商品的*/
#define search_activity_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"search/activity/list"]
/*** 商品详情*/
#define goods_p_ [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/p-"]
/*** 根据分类id获取size信息*/
#define goods_size [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/size"]

#pragma mark ---- 活动

/*** 根据活动id获取活动信息*/
#define activity_activity [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"activity/activity"]
/*** 获取秒杀主场*/
#define activity_getSeckillInfo [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"activity/getSeckillInfo"]
/*** 获取秒杀商品*/
#define activity_getSeckillGoods [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"activity/getSeckillGoods"]

#pragma mark ----评论
/*** 查询商品评分*/
#define goods_comment_calculate_ [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/comment/calculate-"]
/*** 查询商品评论信息*/
#define goods_comment_list [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/comment/list"]
/*** 查询评论信息 根据id*/
#define goods_comment_detail_ [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/comment/detail/"]
/*** 添加商品评论信息*/
#define order_comment [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/comment"]
/*** 修改商品评论信息*/
#define order_comment_edit [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"order/comment/edit"]
#pragma mark ----购物车
/**
 * 购物车
 */
/*** 添加购物车*/
#define goods_cart_addSku [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/cart/addSku"]
/*** 同步购物车*/
#define goods_cart_addSkus [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/cart/addSkus"]
/*** 更新购物车   修改数量*/
#define goods_cart_updateSkuNum [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/cart/updateSkuNum"]
/*** 下载购物车*/
#define goods_cart_getCart [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/cart/getCart"]
/*** 根据sku信息查询购物车商品*/
#define goods_cart_getSkus [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/cart/getSkus"]
/*** 删除购物车商品*/
#define goods_cart_deleteSku [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/cart/deleteSku"]


/*** 上传图片*/
#define goods_file_upload [NSString stringWithFormat:@"%@%@", HTTP_MAIN, @"goods/file/upload"]


#endif /* XZZHeaderUrl_h */

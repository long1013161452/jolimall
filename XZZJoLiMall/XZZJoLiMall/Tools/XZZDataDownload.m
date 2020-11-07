//
//  XZZDataDownload.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZDataDownload.h"

#import "XZZWordsSearch.h"
#import "XZZOrderPriceInfor.h"
#import "XZZOrderList.h"
#import "XZZOrderDetail.h"
#import "XZZOrderPostageInfor.h"
#import "XZZFilterModel.h"
#import "XZZPaymentType.h"
#import "XZZFeedback.h"
#import "XZZSetUpInforModel.h"
#import "XZZCouponsInfor.h"
#import "XZZAsiaBillPay.h"
#import "XZZActivityInfor.h"
#import "XZZSecondsKillSession.h"
#import "XZZSecondsKillGoods.h"

#import "XZZFBLogInRequest.h"

@implementation XZZDataDownload

#pragma mark ----*  商品模块
/**
 *  商品模块
 */
#pragma mark ----/***  获取首页模板 */
/***  获取首页模板 */
+ (void)goodsGetHomePageTemplateHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@1", goods_page] parameters:@{} success:^(id data) {
        
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZHomeTemplate class] json:data[@"result"]];
        if (array.count) {
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
        
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取活动商品信息 */
/***  获取活动商品信息 */
+ (void)goodsGetActivityGoods:(XZZRequestActivityGoods *)activityGoods httpBlock:(HttpBlock)httpBlock
{
    if (activityGoods.goodsIdList.count == 0 && activityGoods.activityId.length == 0) {
        !httpBlock?:httpBlock(nil, NO, nil);
        return;
    }
    NSMutableDictionary * dic = [[activityGoods yy_modelToJSONObject] mutableCopy];
    if (activityGoods.goodsIdList.count == 1) {
        NSNumber * num = activityGoods.goodsIdList[0];
        if (num.intValue == -1) {
            [dic removeObjectForKey:@"goodsIdList"];
        }
    }
    [XZZBuriedPoint aws_ViewActivity:dic];
    [XZZNetWork POST:search_activity_list parameters:dic success:^(id data) {
        if ([data isKindOfClass:[NSArray class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:data];
            !httpBlock?:httpBlock(array, array.count, nil);
        }else{
            
            id result = data[@"result"];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:result[@"list"]];
                !httpBlock?:httpBlock(array, array.count, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }
        
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取分类商品信息 */
/***  获取分类商品信息 */
+ (void)goodsGetCategoryGoods:(XZZRequestCategoryGoods *)categoryGoods httpBlock:(HttpBlock)httpBlock
{

    if ([categoryGoods.categoryId isEqualToString:@"0"]) {
        categoryGoods.categoryId = nil;
    }
    NSDictionary * dic = [categoryGoods yy_modelToJSONObject];
    [XZZBuriedPoint aws_ViewCategory:dic];
    [XZZNetWork POST:search_category_list parameters:dic  success:^(id data) {

        if ([data isKindOfClass:[NSArray class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:data];
            !httpBlock?:httpBlock(array, array.count, nil);
        }else{

            id result = data[@"result"];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:result[@"list"]];
                !httpBlock?:httpBlock(array, array.count, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取优惠券商品列表 */
/***  获取优惠券商品列表 */
+ (void)goodsGetCouponGoods:(XZZRequestCouponGoods *)couponGoods httpBlock:(HttpBlock)httpBlock
{
    if (couponGoods.goodsIdList.count == 0 && couponGoods.couponId.length == 0) {
        !httpBlock?:httpBlock(nil, NO, nil);
        return;
    }
    NSMutableDictionary * dic = [[couponGoods yy_modelToJSONObject] mutableCopy];
    if (couponGoods.goodsIdList.count == 1) {
        
        NSNumber * num = couponGoods.goodsIdList[0];
        if (num.intValue == -1) {
            [dic removeObjectForKey:@"goodsIdList"];
        }
    }
    [XZZNetWork POST:search_coupon_list parameters:dic success:^(id data) {
        id result = data[@"result"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:result[@"list"]];
            !httpBlock?:httpBlock(array, array.count, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取商品详情信息 */
/***  获取商品详情信息 */
+ (void)goodsGetGoodsDetails:(NSString *)goodsId entrance:(NSString *)entrance httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@%@", goods_p_, goodsId] parameters:nil success:^(id data) {
        XZZGoodsDetails * goods = [XZZGoodsDetails yy_modelWithJSON:data[@"result"]];
        [XZZBuriedPoint browseGoods:goods entrance:entrance];
        !httpBlock?:httpBlock(goods, goods, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取分类size信息 */
/***  获取分类size信息 */
+ (void)goodsGetSizeLiostCategoryId:(NSString *)categoryId httpBlock:(HttpBlock)httpBlock
{
    if (categoryId.length <= 0) {
        categoryId = @"0";
    }
    NSDictionary * dic = @{@"categoryId" : categoryId};
    [XZZNetWork GET:goods_size parameters:dic success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZFilterSize class] json:data[@"result"]];
        !httpBlock?:httpBlock(array, array.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取商品评分 */
/***  获取商品评分 */
+ (void)goodsGetGoodsScore:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock
{
    
    [XZZNetWork GET:[NSString stringWithFormat:@"%@%@", goods_comment_calculate_, goodsId] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZGoodsScore * goodsScores = [XZZGoodsScore yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(goodsScores, goodsScores, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取商品评论 */
/***  获取商品评论 */
+ (void)goodsGetGoodsComments:(NSString *)goodsId page:(int)page httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"pageNum" : @(page), @"goodsId" : goodsId, @"pageSize" : @20, @"isHide" : @1};
    [XZZNetWork POST:goods_comment_list parameters:dic success:^(id data) {
        id result = data[@"result"];
        NSArray * array = nil;
        if ([result isKindOfClass:[NSDictionary class]]) {
            array = [NSArray yy_modelArrayWithClass:[XZZGoodsComments class] json:data[@"result"][@"list"]];
        }
        if (array.count) {
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  新增评论 */
/***  新增评论 */
+ (void)goodsGetAddComments:(NSArray *)comments httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork POST:order_comment parameters:comments success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ---- /** 评论详情*/
/** 评论详情*/
+ (void)goodsGetCommentsId:(NSString *)commentId httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@%@", goods_comment_detail_, commentId] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            id result = data[@"result"];
            XZZGoodsComments * comments = [XZZGoodsComments yy_modelWithJSON:result];
            !httpBlock?:httpBlock(comments, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ---- /** 修改评论*/
/** 修改评论*/
+ (void)goodsGetModifyComments:(NSArray *)comments httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork POST:order_comment_edit parameters:comments success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取商品关联商品 */
/***  获取商品关联商品 */
+ (void)goodsGetGoodsRecommended:(XZZRequestRecommendedGoods *)recommendedGoods httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [recommendedGoods yy_modelToJSONObject];
    
    [XZZNetWork POST:search_keywords_list parameters:dic success:^(id data) {
        NSDictionary * dic = data[@"result"];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:data[@"result"][@"list"]];
            if (array.count) {
                !httpBlock?:httpBlock(array, YES, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
        
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}

#pragma mark ---- 活动
#pragma mark ---- /** 获取活动信息*/
/** 获取活动信息*/
+ (void)activityGetActivityId:(NSString *)activityId httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@/%@", activity_activity, activityId] parameters:nil success:^(id data) {
        NSDictionary * dic = data[@"result"];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            XZZActivityInfor * activity = [XZZActivityInfor yy_modelWithJSON:dic];
            !httpBlock?:httpBlock(activity, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ---- /** 获取秒杀活动商品*/
/** 获取秒杀活动商品*/
+ (void)activityGetSeckillGoods:(XZZRequestSeckillGoods *)seckillGoods httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [seckillGoods yy_modelToJSONObject];
    
    
    [XZZNetWork POST:activity_getSeckillGoods parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            id result = data[@"result"];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSArray * array = [NSArray yy_modelArrayWithClass:[XZZSecondsKillGoods class] json:result[@"list"]];
                !httpBlock?:httpBlock(array, array.count, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ---- /** 获取秒杀场次*/
/** 获取秒杀场次*/
+ (void)activityGetSeckillInforHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:activity_getSeckillInfo parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZALLSecondsKillSession * allSecKillSession = [XZZALLSecondsKillSession yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(allSecKillSession, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}

#pragma mark ----搜索
#pragma mark ----/***  获取搜索热词 */
/***  获取搜索热词 */
+ (void)searchGetHotSearchTermHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:goods_hotword parameters:nil success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZWordsSearch class] json:data[@"result"]];
        array = [array sortedArrayUsingComparator:^NSComparisonResult(XZZWordsSearch * obj1, XZZWordsSearch * obj2) {
             return [@(obj1.sort) compare:@(obj2.sort)];
        }];
        
        !httpBlock?:httpBlock(array, array.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取搜索商品信息 */
/***  获取搜索商品信息 */
+ (void)searchGetSearchGoods:(XZZRequestSearch *)search httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [search yy_modelToJSONObject];
    [XZZBuriedPoint search:search.query];
    [XZZBuriedPoint aws_search:dic];
    [XZZNetWork POST:search_list parameters:dic success:^(id data) {
        NSDictionary * result = data[@"result"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:result[@"list"]];
            if (array.count) {
                !httpBlock?:httpBlock(array, YES, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }else{
             !httpBlock?:httpBlock(nil, NO, nil);
        }
        
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}


#pragma mark ----*  分类模块
/**
 *  分类模块
 */
#pragma mark ----获取所有分类信息
/***  获取所有分类信息 */
+ (void)categoryGetAllInforHttpBlock:(HttpBlock)httpBlock
{
    
    [XZZNetWork GET:goods_category_all parameters:nil success:^(id data) {
        NSArray * categoryArray = [NSArray yy_modelArrayWithClass:[XZZCategory class] json:data[@"result"]];
        !httpBlock?:httpBlock(categoryArray, categoryArray.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}



#pragma mark ----*  购物车模块
/**
 *  购物车模块
 */
#pragma mark ----/***  获取购物车信息 */
/***  获取购物车信息 */
+ (void)cartGetShoppingCartInforHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:goods_cart_getCart parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZCartInfor class] json:data[@"result"]];
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  添加购物车信息 */
/***  添加购物车信息 */
+ (void)cartAddShoppingCart:(NSArray<XZZCartInfor *> *)carts isPurchased:(BOOL)isPurchased httpBlock:(HttpBlock)httpBlock
{
    if (carts.count == 0) {
        !httpBlock?:httpBlock(nil, NO, nil);
        return;
    }
    
    if (isPurchased) {
        XZZCartInfor * cartInfor = carts[0];
        NSDictionary * dic = @{@"skuId" : cartInfor.ID, @"skuNum" : @(cartInfor.skuNum)};
        [XZZNetWork GET:goods_cart_addSku parameters:dic success:^(id data) {
            if ([data[@"code"] intValue] == 200) {
                !httpBlock?:httpBlock(nil, YES, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        } failure:^(NSError *error) {
            !httpBlock?:httpBlock(nil, NO, error);
        }];
    }else{
        NSMutableArray * array = @[].mutableCopy;
        for (XZZCartInfor * cartInfor in carts) {
            NSDictionary * dic = @{@"id" : cartInfor.ID, @"skuNum" : @(cartInfor.skuNum)};
            [array addObject:dic];
        }
        [XZZNetWork POST:goods_cart_addSkus parameters:array success:^(id data) {
            if ([data[@"code"] intValue] == 200) {
                !httpBlock?:httpBlock(nil, YES, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        } failure:^(NSError *error) {
            !httpBlock?:httpBlock(nil, NO, error);
        }];
    }
}
#pragma mark ----/***  修改购物车 */
/***  修改购物车 */
+ (void)cartModifyShoppingCart:(XZZCartInfor *)cart count:(BOOL)count httpBlock:(HttpBlock)httpBlock
{

    NSDictionary * dic = @{@"skuId" : cart.ID, @"count" : count ? @"true" : @"false"};

    [XZZNetWork GET:goods_cart_updateSkuNum parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(@"Modified the item numbers successfully", YES, nil);
        }else{
            !httpBlock?:httpBlock(@"Modified the item numbers failed", NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(@"Modified the item numbers failed", NO, error);
    }];
}
#pragma mark ----/***  删除购物车 */
/***  删除购物车 */
+ (void)cartDeleteShoppingCart:(XZZCartInfor *)cart httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"skuId" : cart.ID};
    [XZZNetWork GET:goods_cart_deleteSku parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(@"Deleted successfully", YES, nil);
        }else{
            !httpBlock?:httpBlock(@"Deleted failed", NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(@"Deleted failed", NO, error);
    }];
}
#pragma mark ----/***  获取sku信息 */
/***  获取sku信息 */
+ (void)cartGetSkuInforSkuIDs:(NSArray *)skuIds httpBlock:(HttpBlock)httpBlock
{
    
    
    
    [XZZNetWork POST:goods_cart_getSkus parameters:skuIds success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZSku class] json:data[@"result"]];
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}


#pragma mark ----*  订单
/**
 *  订单
 */
#pragma mark ----/***  获取订单列表 */
/***  获取订单列表 */
+ (void)orderGetOrderListPage:(int)page httpBlock:(HttpBlock)httpBlock
{

    NSDictionary * dic = @{@"pageNum": @(page), @"pageSize": @10};
    [XZZNetWork GET:order_list parameters:dic success:^(id data) {
        NSDictionary * result = data[@"result"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZOrderList class] json:result[@"list"]];
            !httpBlock?:httpBlock(array, array.count, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取订单详情 */
/***  获取订单详情 */
+ (void)orderGetOrderDetailsOrderId:(NSString *)orderId httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"orderId" : orderId};
    [XZZNetWork GET:order_detail parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZOrderDetail * order = [XZZOrderDetail yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(order, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }

    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  下单 */
/***  下单 */
+ (void)orderCheckOut:(XZZRequestCheckOut *)checkOut httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [checkOut yy_modelToJSONObject];
    
    NSString * couponCode = checkOut.couponCode == nil ? @"" : checkOut.couponCode;
    [XZZNetWork POST:order_add parameters:dic success:^(id data) {
        NSLog(@"%@", data);
        if ([data[@"code"] intValue] == 200) {
            [XZZBuriedPoint placeOrderId:data[@"result"] Coupon:couponCode];
            !httpBlock?:httpBlock(data[@"result"], YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}

#pragma mark ----/***  下单  计算价格信息 */
/***  下单  计算价格信息 */
+ (void)orderGetPrice:(XZZRequestCalculatePrice *)calculatePrice httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [calculatePrice yy_modelToJSONObject];
    [XZZNetWork POST:order_couponDiscount parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZOrderPriceInfor * priceInfor = [XZZOrderPriceInfor yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(priceInfor, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取邮费列表 */
/***  获取邮费列表 */
+ (void)orderGetPostageHttpBlock:(HttpBlock)httpBlock
{
    return;
    [XZZNetWork GET:order_postage_getList parameters:nil success:^(id data) {
        NSArray * array = data[@"result"];
        if ([array isKindOfClass:[NSArray class]]) {
            [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray = [NSArray yy_modelArrayWithClass:[XZZOrderPostageInfor class] json:array];
            !httpBlock?:httpBlock(nil, [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray.count, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取邮费列表 */
/***  获取邮费列表 */
+ (void)orderGetPostageWeight:(int)weight goodsNum:(int)goodsNum httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork POST:order_v2_shippingFee parameters:@{@"weight" : @(weight), @"goodsNum" : @(goodsNum)} success:^(id data) {
        NSArray * array = data[@"result"];
        if ([array isKindOfClass:[NSArray class]]) {
            [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray = [NSArray yy_modelArrayWithClass:[XZZOrderPostageInfor class] json:array];
            !httpBlock?:httpBlock(nil, [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray.count, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  计算运费信息 根据重量 */
/***  计算运费信息 根据重量 */
+ (void)orderGetShippingFee:(int)weight httpBlock:(HttpBlock)httpBlock
{
    return;
    [XZZNetWork GET:order_shippingFee parameters:@{@"weight" : @(weight)} success:^(id data) {
        NSArray * array = data[@"result"];
        if ([array isKindOfClass:[NSArray class]]) {
            [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allCalculatePostageInforArray = [NSArray yy_modelArrayWithClass:[XZZOrderCalculatePostageInfor class] json:array];
            !httpBlock?:httpBlock([XZZAllOrderPostageInfor shareAllOrderPostageInfor].allCalculatePostageInforArray, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
    
}

#pragma mark ----/***  支付 */
/***  支付 */
+ (void)payGetOrderPay:(XZZRequestOrderPay *)orderPay httpCodeBlock:(HttpCodeBlock)httpCodeBlock
{
    NSDictionary * dic = [orderPay yy_modelToJSONObject];

    [XZZNetWork POST:payment_pay parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            NSDictionary * result = data[@"result"];
            if (orderPay.payType == 0) {
                if ([result isKindOfClass:[NSString class]]){
                    !httpCodeBlock?:httpCodeBlock(result, 200, YES, nil);
                }else{
                    !httpCodeBlock?:httpCodeBlock(nil, 200, NO, nil);
                }
            }else if (orderPay.payType == 1){
                !httpCodeBlock?:httpCodeBlock(result, 200, YES, nil);
            }else if (orderPay.payType == 2){
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSString * status = result[@"status"];
                    if ([status isKindOfClass:[NSString class]] && [status isEqualToString:@"success"]) {
                        !httpCodeBlock?:httpCodeBlock(result, 200, YES, nil);
                    }else{
                        !httpCodeBlock?:httpCodeBlock(result[@"respMsg"], 200, NO, nil);
                    }
                }else{
                    !httpCodeBlock?:httpCodeBlock(nil, 200, NO, nil);
                }
            }else if (orderPay.payType == 3){
                if ([result[@"status"] intValue] == 1) {
                    !httpCodeBlock?:httpCodeBlock(result, 200, YES, nil);
                }else{
                    !httpCodeBlock?:httpCodeBlock(result[@"respMsg"], 200, NO, nil);
                }
            }else if(orderPay.payType == 6){
                if ([result isKindOfClass:[NSString class]]) {
                    NSString * resultStr = (NSString *)result;
                    if ([resultStr hasPrefix:@"<html"]) {
                        !httpCodeBlock?:httpCodeBlock(result, 200, YES, nil);
                    }else{
                        !httpCodeBlock?:httpCodeBlock(result, 200, NO, nil);
                    }
                }else{
                    !httpCodeBlock?:httpCodeBlock(nil, 200, NO, nil);
                }
            }else if (orderPay.payType == 7){
                XZZAsiaBillPay * asiaBillPay = [XZZAsiaBillPay yy_modelWithJSON:result];
                !httpCodeBlock?:httpCodeBlock(asiaBillPay, 200, YES, nil);
            }
        }else{
            !httpCodeBlock?:httpCodeBlock(data[@"message"], [data[@"code"] intValue], NO, nil);
        }
        NSLog(@"%s %d 行  %@", __func__, __LINE__, data);
    } failure:^(NSError *error) {
        !httpCodeBlock?:httpCodeBlock(nil, 404, NO, error);
    }];
}
#pragma mark ----/***  获取支付类型 */
/***  获取支付类型 */
+ (void)payGetPaymentTypeHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:payment_payConfig_query parameters:nil success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZPaymentType class] json:data[@"result"]];
        NSMutableArray * arrayTwo = @[].mutableCopy;
        for (XZZPaymentType * paymentType in array) {
            if (paymentType.isOpen == 0) {
                [arrayTwo addObject:paymentType];
            }
        }
        !httpBlock?:httpBlock(arrayTwo, arrayTwo.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取Stripe获取公钥 */
/***  获取Stripe获取公钥 */
+ (void)payGetStripeKeyHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork POST:payment_getPublicKey parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(data[@"result"], YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}

#pragma mark ----*  用户模块
#pragma mark ----/***  获取IP地址 */
/***  获取IP地址 */
+ (void)userGetUserIpHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_ip parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(data[@"result"], YES, nil);
        }else{
//            [self userGetUserIpHttpBlock:httpBlock];
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取用户反馈列表 */
/***  获取用户反馈列表 */
+ (void)userGetFeedbackListPage:(int)page httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"pageNum" : @(page), @"pageSize" : @20};
    [XZZNetWork POST:user_feedback parameters:dic success:^(id data) {
        NSDictionary * result = data[@"result"];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZFeedback class] json:result[@"list"]];
            !httpBlock?:httpBlock(array, array.count, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  添加用户反馈 */
/***  添加用户反馈 */
+ (void)userGetAddFeedbackDic:(NSDictionary *)dic httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork POST:user_feedback_add parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  基础信息 */
/***  基础信息 */
+ (void)userGetBasedInformationHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_webSetting_get parameters:nil success:^(id data) {
        
        [My_Basic_Infor yy_modelSetWithJSON:data[@"result"]];
        !httpBlock?:httpBlock(nil, YES, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取设置信息列表 */
/***  获取设置信息列表 */
+ (void)userGetSetUpListInforHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_terms_get_APP parameters:nil success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZSetUpInforModel class] json:data[@"result"]];
        !httpBlock?:httpBlock(array, array.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取收藏列表 */
/***  获取收藏列表 */
+ (void)userGetGoodsCollectionListHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:goods_favorite_list parameters:nil success:^(id data) {
        
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsList class] json:data[@"result"]];
        !httpBlock?:httpBlock(array, array.count, nil);
        
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  添加收藏 */
/***  添加收藏 */
+ (void)userGetAddCollectionGoods:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"goodsId" : goodsId, @"operateType" : @1};
    NSLog(@"%s %d 行  ~~~~~~~~~~~~~~~~~ %@", __func__, __LINE__, dic);

    [XZZNetWork POST:goods_favorite parameters:dic success:^(id data) {
        NSLog(@"%s %d 行  ~~~~~~~~~~~~~~~~~ %@", __func__, __LINE__, data);
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
        NSLog(@" 添加收藏  %@", data);
    } failure:^(NSError *error) {
        NSLog(@" 添加收藏  %@", error);
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  删除收藏 */
/***  删除收藏 */
+ (void)userGetDeleteCollectionGoods:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"goodsId" : goodsId, @"operateType" : @0};
    [XZZNetWork POST:goods_favorite parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
        NSLog(@" 删除收藏  %@", data);
    } failure:^(NSError *error) {
        NSLog(@"删除收藏  %@", error);
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  领取优惠券  根据code */
/***  领取优惠券  根据code */
+ (void)userGetCouponsCode:(NSString *)code httpBlock:(HttpBlock)httpBlock
{
    code = [code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [XZZNetWork GET:[NSString stringWithFormat:@"%@/%@", user_coupon_receiveByCode, code] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(data[@"result"], YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  领取优惠券  根据params */
/***  领取优惠券  根据params */
+ (void)userGetCouponsParams:(NSString *)params httpBlock:(HttpBlock)httpBlock
{
    
    [XZZNetWork GET:[NSString stringWithFormat:@"%@/%@", user_coupon_receiveByUrl, params] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(data[@"result"], YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取s下单时可用s的优惠券 */
/***  获取s下单时可用s的优惠券 */
+ (void)userGetCanUseCouponsSkuNum:(NSArray *)skuNumArray httpBlock:(HttpBlock)httpBlock
{
//    NSArray * array = [skuNumArray yy_modelToJSONObject];
    [XZZNetWork POST:user_coupon_login_canUse parameters:skuNumArray success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZCouponsInfor class] json:data[@"result"]];
        !httpBlock?:httpBlock(array, array.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取所有优惠券信息 */
/***  获取所有优惠券信息 */
+ (void)userGetCouponsListHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_coupon_myCoupons parameters:nil success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZCouponsInfor class] json:data[@"result"]];
        !httpBlock?:httpBlock(array, array.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取商品优惠券 */
/***  获取商品优惠券 */
+ (void)userGetGoodsCoupons:(NSString *)goodsId httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"goodsIdList" : @[goodsId]};
    [XZZNetWork POST:user_coupon_getCouponList parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZGoodsDetailCoupon * goodsDetailCoupon = [XZZGoodsDetailCoupon yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(goodsDetailCoupon, goodsDetailCoupon.couponVos.count, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ---- /***  获取优惠券信息  根据id */
/***  获取优惠券信息  根据id */
+ (void)userGetCouponsInforCouponsId:(NSString *)couponsId httpBlock:(HttpBlock)httpBlock
{
    if (!couponsId) {
        !httpBlock?:httpBlock(nil, NO, nil);
        return;
    }
    [XZZNetWork GET:[NSString stringWithFormat:@"%@?couponId=%@", user_coupon_getCouponRecommendVo, couponsId] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZCouponsInfor * couponsInfor = [XZZCouponsInfor yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(couponsInfor, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取地址列表 */
/***  获取地址列表 */
+ (void)userGetAddressListHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_shipping_address_get parameters:@{} success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZAddressInfor class] json:data[@"result"]];
        !httpBlock?:httpBlock(array, array.count, nil);
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  添加地址信息 */
/***  添加地址信息 */
+ (void)userGetAddAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [address yy_modelToJSONObject];
    [XZZNetWork POST:user_shipping_address_add parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZAddressInfor * address = [XZZAddressInfor yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(address, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  删除地址信息 */
/***  删除地址信息 */
+ (void)userGetDeleteAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@/%@", user_shipping_address_del, address.ID] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(@"Delete address successfully", YES, nil);
        }else{
            !httpBlock?:httpBlock(@"Delete address failed", NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  修改地址信息 */
/***  修改地址信息 */
+ (void)userGetModifyAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = [address yy_modelToJSONObject];
    [XZZNetWork POST:user_shipping_address_update parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            XZZAddressInfor * address = [XZZAddressInfor yy_modelWithJSON:data[@"result"]];
            !httpBlock?:httpBlock(address, YES, nil);
        }else{
            !httpBlock?:httpBlock(@"Modified address failed", NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  设置默认地址 */
/***  设置默认地址 */
+ (void)userGetSetDefaultAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@%@", user_shipping_address_setDefault, address.ID] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(@"Modified address successfully", YES, nil);
        }else{
            !httpBlock?:httpBlock(@"Modified address failed", NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取国家信息 */
/***  获取国家信息 */
+ (void)userGetCountryHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_region_country_select parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            NSArray * array = [NSArray yy_modelArrayWithClass:[XZZCountryInfor class] json:data[@"result"]];
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            [self userGetCountryHttpBlock:httpBlock];
        }
    } failure:^(NSError *error) {
        [self userGetCountryHttpBlock:httpBlock];
    }];
}
#pragma mark ----/***  获取省信息 */
/***  获取省信息 */
+ (void)userGetProvinceFameCountry:(XZZCountryInfor *)country httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_region_province_select parameters:@{@"id" : country.ID.length ? country.ID : @""} success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZProvinceInfor class] json:data[@"result"]];
        if (array.count) {
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
       !httpBlock?:httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  获取城市信息 */
/***  获取城市信息 */
+ (void)userGetCityFameProvince:(XZZProvinceInfor *)province httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_region_city_select parameters:@{@"id" : province.ID.length ? province.ID : @""} success:^(id data) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZCityInfor class] json:data[@"result"]];
        if (array.count) {
            !httpBlock?:httpBlock(array, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}



#pragma mark ----*  登陆注册
/**
 *  登陆注册
 */
#pragma mark ----/***  登陆 */
/***  登陆 */
+ (void)logInGetLogInName:(NSString *)name password:(NSString *)password httpBlock:(HttpBlock)httpBlock
{
    NSDictionary * dic = @{@"username" : name, @"password" : password};
    [XZZNetWork POSTFORM:user_login parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            [User_Infor userInformation:data[@"result"]];
        }
        if (User_Infor.isLogin) {
            [XZZBuriedPoint userLoginSource:@"email" email:name];
            !httpBlock?: httpBlock(data, YES, nil);
        }else{
            !httpBlock?: httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?: httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  注册 */
/***  注册 */
+ (void)logInGetRegisteredName:(NSString *)name password:(NSString *)password httpBlock:(HttpBlock)httpBlock
{
    
    XZZUserLogInRequest * request = [XZZUserLogInRequest allocInit];
    request.email = name;
    request.loginPwd = password;
    request.confirmPwd = password;
    
//    NSDictionary * dic = @{@"email" : name, @"loginPwd" : password, @"confirmPwd" : password};
    NSDictionary * dic = [request yy_modelToJSONObject];
    
    [XZZNetWork POST:user_register parameters:dic success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            [User_Infor userInformation:data[@"result"]];
        }
        if (User_Infor.isLogin) {
            [XZZBuriedPoint logCompletedRegistrationEvent:@"email"];
            !httpBlock?: httpBlock(data, YES, nil);
        }else{
            !httpBlock?: httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?: httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  忘记密码 */
/***  忘记密码 */
+ (void)logInGetForgotPasswordEmail:(NSString *)email httpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:[NSString stringWithFormat:@"%@%@", user_resetPwd_, email] parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(data[@"message"], NO, nil);
        }
    } failure:^(NSError *error) {
        !httpBlock?: httpBlock(nil, NO, error);
    }];
}
#pragma mark ----/***  facebook登陆 */
/***  facebook登陆 */
+ (void)logInGetFacebookIdLogInEmail:(NSString *)email facebookId:(NSString *)facebookId facebookName:(NSString *)facebookName httpBlock:(HttpBlock)httpBlock
{
    if (email.length) {
        XZZFBLogInRequest * fbLoginRequest = [XZZFBLogInRequest allocInit];
        fbLoginRequest.email = email;
        fbLoginRequest.facebookId = facebookId;
        fbLoginRequest.facebookName = facebookName;
        NSDictionary * dic = [fbLoginRequest yy_modelToJSONObject];
        [XZZNetWork POST:user_facebook_register parameters:dic success:^(id data) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if ([data[@"code"] intValue] == 200) {
                    id result = data[@"result"];
                    if ([result isKindOfClass:[NSNull class]]) {
                        !httpBlock?:httpBlock(facebookId, NO, nil);
                    }else if([result isKindOfClass:[NSDictionary class]]) {
                        NSDictionary * resultDic = result;
                        if ([resultDic count] == 0) {
                            !httpBlock?:httpBlock(facebookId, NO, nil);
                        }else{
                            [User_Infor userInformation:result];
                            [XZZBuriedPoint logCompletedRegistrationEvent:@"facebook"];
                            !httpBlock?:httpBlock(nil, YES, nil);
                        }
                    }
                }else{
                    !httpBlock?:httpBlock(data[@"message"], NO, nil);
                }
            }
        } failure:^(NSError *error) {
            !httpBlock?:httpBlock(nil, NO, nil);
        }];
    }else{
        XZZFBLogInRequest * fbLoginRequest = [XZZFBLogInRequest allocInit];
        fbLoginRequest.facebookId = facebookId;
        NSDictionary * dic = [fbLoginRequest yy_modelToJSONObject];
        [XZZNetWork POST:user_facebook_login parameters:dic success:^(id data) {
            int code = [data[@"code"] intValue];
            if (code == 200) {
                id result = data[@"result"];
                if ([result isKindOfClass:[NSNull class]]) {
                    !httpBlock?:httpBlock(facebookId, NO, nil);
                }else if([result isKindOfClass:[NSDictionary class]] || [result isKindOfClass:[NSArray class]]) {
                    NSDictionary * resultDic = result;
                    if ([resultDic count] == 0) {
                        !httpBlock?:httpBlock(facebookId, NO, nil);
                    }else{
                        [User_Infor userInformation:result];
                        [XZZBuriedPoint userLoginSource:@"facebook" email:User_Infor.email];
                        !httpBlock?:httpBlock(nil, YES, nil);
                    }
                }
            }else if(code == 10012001){
                !httpBlock?:httpBlock(facebookId, NO, nil);
            }else{
                !httpBlock?:httpBlock(facebookId, NO, nil);
            }
        } failure:^(NSError *error) {
            !httpBlock?:httpBlock(nil, NO, nil);
        }];
    }
}


/***  Apple登陆 */
+ (void)logInGetIOSIdLogInEmail:(NSString *)email appleId:(NSString *)appleId appleName:(NSString *)appleName httpBlock:(HttpBlock)httpBlock
{
    if (email.length) {
        appleName = appleName.length ? appleName : email;
        XZZFBLogInRequest * fbLoginRequest = [XZZFBLogInRequest allocInit];
        fbLoginRequest.email = email;
        fbLoginRequest.appleId = appleId;
        fbLoginRequest.appleName = appleName;
        NSDictionary * dic = [fbLoginRequest yy_modelToJSONObject];
        [XZZNetWork POST:user_ios_register parameters:dic success:^(id data) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if ([data[@"code"] intValue] == 200) {
                    id result = data[@"result"];
                    if ([result isKindOfClass:[NSNull class]]) {
                        !httpBlock?:httpBlock(appleId, NO, nil);
                    }else if([result isKindOfClass:[NSDictionary class]]) {
                        NSDictionary * resultDic = result;
                        if ([resultDic count] == 0) {
                            !httpBlock?:httpBlock(appleId, NO, nil);
                        }else{
                            [User_Infor userInformation:result];
                            [XZZBuriedPoint logCompletedRegistrationEvent:@"facebook"];
                            !httpBlock?:httpBlock(nil, YES, nil);
                        }
                    }
                }else{
                    !httpBlock?:httpBlock(data[@"message"], NO, nil);
                }
            }
        } failure:^(NSError *error) {
            !httpBlock?:httpBlock(nil, NO, nil);
        }];
    }else{
        XZZFBLogInRequest * fbLoginRequest = [XZZFBLogInRequest allocInit];
        fbLoginRequest.appleId = appleId;
        NSDictionary * dic = [fbLoginRequest yy_modelToJSONObject];
        [XZZNetWork POST:user_ios_login parameters:dic success:^(id data) {
            int code = [data[@"code"] intValue];
            if (code == 200) {
                id result = data[@"result"];
                if ([result isKindOfClass:[NSNull class]]) {
                    !httpBlock?:httpBlock(appleId, NO, nil);
                }else if([result isKindOfClass:[NSDictionary class]] || [result isKindOfClass:[NSArray class]]) {
                    NSDictionary * resultDic = result;
                    if ([resultDic count] == 0) {
                        !httpBlock?:httpBlock(appleId, NO, nil);
                    }else{
                        [User_Infor userInformation:result];
                        [XZZBuriedPoint userLoginSource:@"facebook" email:User_Infor.email];
                        !httpBlock?:httpBlock(nil, YES, nil);
                    }
                }
            }else if(code == 10012001){
                !httpBlock?:httpBlock(appleId, NO, nil);
            }else{
                !httpBlock?:httpBlock(appleId, NO, nil);
            }
        } failure:^(NSError *error) {
            !httpBlock?:httpBlock(nil, NO, nil);
        }];
    }
}


#pragma mark ----/***  判断是否是新用户 */
/***  判断是否是新用户 */
+ (void)logInGetUserIsNewHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:order_firstPay parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            if ([data[@"result"] intValue] == 1) {
                !httpBlock?:httpBlock(nil, YES, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
        
    } failure:^(NSError *error) {
        !httpBlock?:httpBlock(nil, NO, error);
    }];
}

#pragma mark ----/***  获取基本授权 */
/***  获取基本授权 */
+ (void)logInGetAuthorizationHttpBlock:(HttpBlock)httpBlock
{
    [XZZNetWork GET:user_authorization_basic parameters:nil success:^(id data) {
        if ([data[@"code"] intValue] == 200) {
            !httpBlock?:httpBlock(data[@"result"], YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    } failure:^(NSError *error) {
       !httpBlock?:httpBlock(nil, NO, error);
    }];
}


#pragma mark ----*  上传图片信息
/**
 *  上传图片信息
 */
+ (void)uploadPictureInformation:(UIImage *)image httpBlock:(HttpBlock)httpBlock
{
    //1、获取一个全局串行队列
    dispatch_queue_t queueorder = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2、把任务添加到队列中执行
    dispatch_async(queueorder, ^{
        NSArray * imageArray = @[[self compressImageQuality:image toByte:5 * 1024 * 1024]];
        [XZZNetWork uploadUrl:goods_file_upload images:imageArray success:^(id data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([data[@"code"] intValue] == 200) {
                    !httpBlock?:httpBlock(data[@"result"], YES, nil);
                }else{
                    !httpBlock?:httpBlock(data[@"result"], NO, nil);
                }
            });
            
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                !httpBlock?:httpBlock(nil, NO, error);
            });
        }];
    });
}

+ (NSData *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    while (data.length > maxLength && compression > 0) {
        compression -= 0.02;
        data = UIImageJPEGRepresentation(image, compression);
    }
    return data;
}

@end

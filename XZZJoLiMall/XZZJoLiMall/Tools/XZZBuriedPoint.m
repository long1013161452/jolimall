//
//  XZZBuriedPoint.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZBuriedPoint.h"
#import "XZZBuriedDataSource.h"


@implementation XZZBuriedPoint
#pragma mark ----  添加收藏 contentData 商品名 contentId 商品ID  contentType yes no   price 价格
/**
 *  添加收藏 contentData 商品名(nil) contentId 商品ID  contentType yes no   price 价格(0)
 */
+ (void)logAddedToWishlistEvent:(NSString *)contentData
                      contentId:(NSString *)contentId
                    contentType:(NSString *)contentType
                       entrance:(NSString *)entrance
{

    if ([contentType isEqualToString:@"YES"]) {
        [self aws_StorageTimeInformation:@"AddToWishlist" parameters:@{@"goodsId" : contentId, @"entrance" : entrance}];
    }else{
        [self aws_StorageTimeInformation:@"RemoveFromWishlist" parameters:@{@"goodsId" : contentId, @"entrance" : entrance}];
    }


    [self firebaseAppTwo:kFIREventAddToWishlist parameters:@{
                                                             @"商品ID" : contentId,//id
//                                                             kFIRParameterPrice : @(price),//价格
                                                             kFIRParameterCurrency : @"USD",//货币
                                                             @"收藏状态" : contentType
                                                             }];

    NSDictionary *params =
    @{
      FBSDKAppEventParameterNameContentID : contentId,
      FBSDKAppEventParameterNameContentType : contentType,
      FBSDKAppEventParameterNameCurrency : @"USD"
      };
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameAddedToWishlist
     valueToSum:0
     parameters:params];
}


#pragma mark ----注册埋点
/**
 *  注册埋点   registrationMethod（email）
 */
+ (void)logCompletedRegistrationEvent:(NSString *)registrationMethod
{
    [self aws_StorageTimeInformation:@"Register" parameters:@{@"channel" : registrationMethod}];
    
    
    [self firebaseAppTwo:kFIREventSignUp parameters:@{kFIRParameterMedium : registrationMethod}];
    
    [self userLoginSource:registrationMethod email:User_Infor.email];
    
    NSDictionary *params =
    @{FBSDKAppEventParameterNameRegistrationMethod : registrationMethod};
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameCompletedRegistration
     parameters:params];
}
#pragma mark ----*  用户登陆
/**
 *  用户登陆
 */
+ (void)userLoginSource:(NSString *)source email:(NSString *)email
{
    source = source.length ? source : @"";
    email = email.length ? email : @"";
    NSDictionary * dic = @{
                           @"channel" : source
                           };
    [self firebaseAppTwo:kFIREventLogin parameters:dic];
    [FBSDKAppEvents logEvent:@"User Login" parameters:dic];
    
    
    [self aws_StorageTimeInformation:@"Login" parameters:dic];
    
}

#pragma mark ---- *  搜索
/**
 *  搜索
 */
+ (void)search:(NSString *)search
{
    
//    [self aws_StorageTimeInformation:@"Search" parameters:@{@"word" : search}];
    
    [self firebaseAppTwo:kFIREventSearch parameters:@{kFIRParameterSearchTerm : search}];
    
    NSDictionary *params = @{
                             FBSDKAppEventParameterNameSearchString : search,
                             FBSDKAppEventParameterNameSuccess : @(1)
                             };
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameSearched
     parameters:params];
    
}
#pragma mark ----*  aws搜索a
/**
 *  搜索a
 */
+ (void)aws_search:(NSDictionary *)search
{
    [self aws_StorageTimeInformation:@"SearchProduct" parameters:search];
    
}
#pragma mark ---- *  立即购买
/**
 *  立即购买
 */
+ (void)aws_buyNow:(XZZCartInfor *)cart
{
    NSDictionary * dic = @{
                           @"skuId" : cart.ID,
                           @"price" : [NSString stringWithFormat:@"%.2f", cart.skuPrice],
                           @"count" : @(cart.skuNum),
                           @"goodsId" : cart.goodsId
                           };
    [self aws_StorageTimeInformation:@"BuyNow" parameters:dic];
}
#pragma mark ----*  商品列表  分类
/**
 *  商品列表  分类
 */
+ (void)aws_ViewCategory:(NSDictionary *)ViewCategory
{
    NSMutableDictionary * dic = ViewCategory.mutableCopy;
    
    NSArray * colorCodeList = dic[@"colorCodeList"];
    NSString * colorCodes = @"";
    for (NSString * str in colorCodeList) {
        if (colorCodes.length) {
            colorCodes = [NSString stringWithFormat:@"%@,%@", colorCodes, str];
        }else{
            colorCodes = [NSString stringWithFormat:@"%@", str];
        }
    }
    [dic setObject:colorCodes forKey:@"colorCodeList"];
    NSArray * sizeCodeList = dic[@"sizeCodeList"];
    NSString * sizeCodes = @"";

    for (NSString * str in sizeCodeList) {
        if (sizeCodes.length) {
            sizeCodes = [NSString stringWithFormat:@"%@,%@", sizeCodes, str];
        }else{
            sizeCodes = [NSString stringWithFormat:@"%@", str];
        }
    }
    [dic setObject:sizeCodes forKey:@"sizeCodeList"];
    NSString * categoryId = dic[@"categoryId"];
    if (categoryId.length <= 0) {
        [dic setObject:@"0" forKey:@"categoryId"];
    }
    
    [self aws_StorageTimeInformation:@"ViewCategory" parameters:dic];
}
#pragma mark ----*  商品列表  活动列表
/**
 *  商品列表  活动列表
 */
+ (void)aws_ViewActivity:(NSDictionary *)ViewActivity
{
    [self aws_StorageTimeInformation:@"ViewActivity" parameters:ViewActivity];
}

#pragma mark ----*  浏览商品
/**
 *  浏览商品
 */
/**
 *  浏览商品
 */
+ (void)browseGoods:(XZZGoodsDetails *)commodity entrance:(NSString *)entrance
{
    if (!commodity) {
        return;
    }
    
    [self aws_StorageTimeInformation:@"ViewContent" parameters:@{@"goodsId" : commodity.goods.ID, @"entrance" : entrance}];
    
    XZZCategoryMap * categor = [commodity.categoryMap lastObject];
    XZZSku * sku = [commodity.skuList firstObject];
    // Define product with relevant parameters.
    NSDictionary *product1 = @{
                               kFIRParameterItemID : commodity.goods.ID, // ITEM_ID or ITEM_NAME is required.
                               kFIRParameterItemName : commodity.goods.title,
                               kFIRParameterItemCategory : [NSString stringWithFormat:@"%@/%@/%@", categor.firstName, categor.secondName, categor.thirdName],
                               kFIRParameterPrice : @(sku.skuPrice),
                               kFIRParameterCurrency : @"USD"  // Item-level currency unused today.
                               };
    
    // Prepare ecommerce dictionary.
    NSArray *items = @[product1];
    
    NSDictionary *ecommerce = @{
                                @"items" : items,
                                kFIRParameterItemList : @"商品浏览" // List name.
                                };
    
    [self firebaseAppTwo:kFIREventViewItem parameters:ecommerce];
    
    NSString * goodsCode = commodity.goods.code.length ? commodity.goods.code : @"";
//    goodsCode = [NSString stringWithFormat:@"%@", goodsCode, ]
    
    
    NSData * contentData = [NSJSONSerialization dataWithJSONObject:@[@{@"id" : goodsCode, @"quantity" : @(1)}] options:NSJSONWritingPrettyPrinted error:nil];
    NSString * contentStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n\r" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    contentStr = @"ceshi";
    NSDictionary *params =
    @{
      FBSDKAppEventParameterNameContent : contentStr,
      FBSDKAppEventParameterNameCurrency : @"USD",
      FBSDKAppEventParameterNameContentID : goodsCode,
      FBSDKAppEventParameterNameContentType : @"product"
      };
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameViewedContent
     valueToSum:sku.skuPrice
     parameters:params];
    
    
    
}
#pragma mark ---- *  添加购物车
/**
 *  添加购物车
 */
+ (void)addToCart:(XZZGoodsDetails *)commodity cart:(XZZCartInfor *)cart
{
    
    [self aws_StorageTimeInformation:@"AddToCart" parameters:@{@"skuId" : cart.ID, @"price" : [NSString stringWithFormat:@"%.2f", cart.skuPrice], @"count" : @(cart.skuNum), @"goodsId" : cart.goodsId}];
    
    
    XZZCategoryMap * categor = [commodity.categoryMap lastObject];
    
    NSDictionary *product1 = @{
                               kFIRParameterItemID : cart.ID, // ITEM_ID or ITEM_NAME is required.
                               kFIRParameterItemName : commodity.goods.title,
                               @"goodsID" : commodity.goods.ID,
                               kFIRParameterItemCategory :  [NSString stringWithFormat:@"%@/%@/%@", categor.firstName, categor.secondName, categor.thirdName],
                               kFIRParameterPrice : @(cart.skuPrice),
                               kFIRParameterCurrency : @"USD",  // Item-level currency unused today.
                               kFIRParameterQuantity : @(cart.skuNum)
                               };
    
    // Prepare ecommerce dictionary.
    NSArray *items = @[product1];
    
    NSDictionary *ecommerce = @{
                                @"items" : items
                                };
    [self firebaseAppTwo:kFIREventAddToCart parameters:ecommerce];
    
    NSString * goodsCode = commodity.goods.code.length ? commodity.goods.code : @"";
//    NSString * goodsCode = commodity.goods.code.length ? [NSString stringWithFormat:@"%@%@", commodity.goods.code, cart.colorCode] : @"";
    
    NSData * contentData = [NSJSONSerialization dataWithJSONObject:@[@{@"id" : goodsCode, @"quantity" : @(cart.skuNum)}] options:NSJSONWritingPrettyPrinted error:nil];
    NSString * contentStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n\r" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //contentStr = @"ceshi";
    NSDictionary *params =
    @{
      FBSDKAppEventParameterNameContent : contentStr,
      FBSDKAppEventParameterNameCurrency : @"USD",
      FBSDKAppEventParameterNameContentID : goodsCode,
      FBSDKAppEventParameterNameContentType : @"product"
      };
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameAddedToCart
     valueToSum:cart.skuPrice
     parameters:params];
    
}
#pragma mark ---- *  删除购物车
/**
 *  删除购物车
 */
+ (void)removalsFromCart:(XZZCartInfor *)cart
{
    NSDictionary *product1 = @{
                               kFIRParameterItemID : cart.ID, // ITEM_ID or ITEM_NAME is required.
                               kFIRParameterItemName : cart.goodsTitle,
                               kFIRParameterPrice : @(cart.skuPrice),
                               kFIRParameterCurrency : @"USD",  // Item-level currency unused today.
                               kFIRParameterQuantity : @(cart.skuNum)
                               };
    
    // Prepare ecommerce dictionary.
    NSArray *items = @[product1];
    
    NSDictionary *ecommerce = @{
                                @"items" : items
                                };
    [self firebaseAppTwo:kFIREventRemoveFromCart parameters:ecommerce];
    
    [self aws_StorageTimeInformation:@"RomoveFromCart" parameters:@{@"skuId" : cart.ID}];
}

#pragma mark ----*  点击购物车的Checkout
/**
 *  点击购物车的Checkout
 */
+ (void)clickCheckout
{
    NSArray * carts = [all_cart getSelectedCartArray];
    NSMutableArray * goodsArr = @[].mutableCopy;
    for (XZZCartInfor * cart in carts) {
        [goodsArr addObject:@{@"skuId" : cart.ID, @"price" : [NSString stringWithFormat:@"%.2f", cart.skuPrice], @"count" : @(cart.skuNum)}];
    }
    [self aws_StorageTimeInformation:@"ClickCheckout" parameters:@{@"goodsArr" : goodsArr}];
    
    [self firebaseAppTwo:@"Click_Checkout" parameters:nil];
    [FBSDKAppEvents logEvent:@"Click_Checkout"];
}
#pragma mark ---- *  下单  埋点
/**
 *  下单  埋点
 */
+ (void)placeOrderId:(NSString *)orderId Coupon:(NSString *)Coupon
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    if (!Coupon) {
        Coupon = @"";
    }
    [XZZDataDownload orderGetOrderDetailsOrderId:orderId httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [self placeOrder:data];
        }
    }];


}
#pragma mark ---- *  下单  埋点
/**
 *  下单  埋点
 */
+ (void)placeOrder:(XZZOrderDetail *)orderInfor
{

    NSString * Coupon = orderInfor.couponCode;

    [self aws_StorageTimeInformation:@"InitiateCheckout" parameters:@{@"orderId" : orderInfor.orderId, @"amount" : [NSString stringWithFormat:@"%.2f", orderInfor.total], @"coupon" : Coupon}];


    NSMutableArray * items = @[].mutableCopy;
    NSString * contentData = @"";
    for (XZZOrderSku * cart in orderInfor.skus) {
        contentData = [NSString stringWithFormat:@"%@/%@", contentData, cart.goodsTitle];
        NSDictionary *product1 = @{
                                   kFIRParameterItemID : cart.skuId, // ITEM_ID or ITEM_NAME is required.
                                   kFIRParameterItemName : cart.goodsTitle,
                                   kFIRParameterPrice : @(cart.price),
                                   kFIRParameterCurrency : @"USD",  // Item-level currency unused today.
                                   kFIRParameterQuantity : cart.quantity
                                   };
        [items addObject:product1];
    }
    NSDictionary *ecommerce = @{
                                @"items" : items,
                                kFIRParameterItemList : @"下单", // List name.
                                kFIRParameterTransactionID : orderInfor.orderId,
                                kFIRParameterAffiliation : orderInfor.shippingId,
                                kFIRParameterValue : @(orderInfor.total), // Revenue.
                                kFIRParameterTax : @0,
                                kFIRParameterShipping : @(orderInfor.shipping),
                                kFIRParameterCurrency : @"USD",
                                kFIRParameterCoupon : Coupon
                                };
    [self firebaseAppTwo:kFIREventBeginCheckout parameters:ecommerce];



    NSDictionary *params =
    @{
      FBSDKAppEventParameterNameContent : contentData,
      FBSDKAppEventParameterNameContentID : orderInfor.orderId,
      FBSDKAppEventParameterNameContentType : @"Checkout",
      FBSDKAppEventParameterNameNumItems : @(orderInfor.skus.count),
      FBSDKAppEventParameterNamePaymentInfoAvailable : @(0),
      FBSDKAppEventParameterNameCurrency :  @"USD",
      };
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameInitiatedCheckout
     valueToSum:orderInfor.total
     parameters:params];


}

#pragma mark ---- *  支付埋点  order订单信息  payType支付类型   awsPayType (paypal,iPaylinks)
/**
 *  支付埋点  order订单信息  payType支付类型   awsPayType (paypal,iPaylinks)
 */
+ (void)payOrderId:(NSString *)orderId payType:(int)payType
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    __block int payTypeBlock = payType;
    [XZZDataDownload orderGetOrderDetailsOrderId:orderId httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [self pay:data payType:payTypeBlock isFB:YES];
        }
    }];
}
#pragma mark ---- *  支付埋点  order订单信息  payType支付类型   awsPayType (paypal,iPaylinks)
/**
 *  支付埋点  order订单信息  payType支付类型   awsPayType (paypal,iPaylinks)
 */
+ (void)pay:(XZZOrderDetail *)order payType:(int)payType isFB:(BOOL)isFB
{

    NSString * payTypeStr = payType == 0 ? @"paypal" : @"iPaylinks";
    payTypeStr = payType == 1 ? @"stripe" : @"iPaylinks";
    payTypeStr = payType == 2 ? @"iPaylinks" : @"AsiaBill";
    

    NSMutableArray * items = @[].mutableCopy;
    int count= 0;
    NSMutableArray * content_ids = @[].mutableCopy;
    NSMutableArray * content = @[].mutableCopy;
    
    for (XZZOrderSku * orderDetailsVo in order.skus) {
        count += orderDetailsVo.quantity.intValue;
        NSDictionary *product1 = @{
                                   kFIRParameterItemID : orderDetailsVo.skuId, // ITEM_ID or ITEM_NAME is required.
                                   kFIRParameterItemName : orderDetailsVo.goodsId,
                                   kFIRParameterPrice : @(orderDetailsVo.price),
                                   kFIRParameterCurrency : @"USD",  // Item-level currency unused today.
                                   kFIRParameterQuantity : orderDetailsVo.quantity
                                   };
        [items addObject:product1];
        
        
        NSString * str = orderDetailsVo.goodsCode;
        
        if (str.length > 0) {
            [content addObject:@{@"id" : str, @"quantity" : orderDetailsVo.quantity}];
            [content_ids addObject:str];
        }
    }
    NSDictionary *ecommerce = @{
                                @"items" : items,
                                kFIRParameterItemList : @"支付", // List name.
                                kFIRParameterTransactionID : order.orderId,
                                kFIRParameterAffiliation : order.shippingId,
                                kFIRParameterValue : @(order.total), // Revenue.
                                kFIRParameterTax : @0,
                                kFIRParameterShipping : @(order.shipping),
                                kFIRParameterCurrency : @"USD",
//                                kFIRParameterCoupon : order.order.couponCode,
                                kFIRParameterCheckoutOption : payTypeStr
                                };



    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:content_ids options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    str = [str stringByReplacingOccurrencesOfString:@"\n\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSData * contentData = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
    NSString * contentStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];

    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n\r" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@" " withString:@""];

    //    contentStr = @"ceshi";

    NSDictionary *params = @{
                             FBSDKAppEventParameterNameContent : contentStr,
                             FBSDKAppEventParameterNameNumItems : @(count),
                             FBSDKAppEventParameterNamePaymentInfoAvailable : @(1),
                             FBSDKAppEventParameterNameCurrency :  @"USD",
                             FBSDKAppEventNameAddedPaymentInfo : payTypeStr,
                             FBSDKAppEventParameterNameContentID : str,
                             FBSDKAppEventParameterNameContentType : @"product"
                             };
    
    if (isFB) {
            [FBSDKAppEvents logPurchase:order.total//count
              currency:@"USD"
            parameters: params];
    }else{
        [self firebaseAppTwo:kFIREventEcommercePurchase parameters:ecommerce];
        [self aws_StorageTimeInformation:@"Purchase" parameters:@{@"orderId" : order.orderId, @"amount" : [NSString stringWithFormat:@"%.2f",  order.total], @"coupon" : order.couponCode, @"payMethod" : payTypeStr}];

    }
    
    


}

#pragma mark ----*  分享   platform平台信息 1是facebook  2是messenger    3 是WhatsApp  4 是Pinterest
/**
 *  分享   platform平台信息 1是facebook  2是messenger    3 是WhatsApp  4 是Pinterest
 */
+ (void)shareProductInfor:(XZZGoodsDetails *)goodsDetails platform:(int)platform
{
    NSString * platformName = @"";
    
    switch (platform) {
        case 1:{
            platformName = @"Facebook";
        }
            break;
        case 2:{
            platformName = @"Messenger";
        }
            break;
        case 3:{
            platformName = @"WhatsApp";
        }
            break;
        case 4:{
            platformName = @"Pinterest";
        }
            break;
            
        default:
            break;
    }
    
    [self aws_StorageTimeInformation:@"ShareProducts" parameters:@{@"goodsid" : goodsDetails.goods.ID, @"snsName" : platformName}];
    
    
    XZZCategoryMap * categor = [goodsDetails.categoryMap lastObject];
    XZZSku * sku = [goodsDetails.skuList firstObject];
    // Define product with relevant parameters.
    NSDictionary *product1 = @{
                               kFIRParameterItemID : goodsDetails.goods.ID, // ITEM_ID or ITEM_NAME is required.
                               kFIRParameterItemName : goodsDetails.goods.title,
                               kFIRParameterItemCategory : [NSString stringWithFormat:@"%@/%@/%@", categor.firstName, categor.secondName, categor.thirdName],
                               kFIRParameterPrice : @(sku.skuPrice),
                               kFIRParameterCurrency : @"USD"  // Item-level currency unused today.
                               };
    NSArray * items = @[product1];
    NSDictionary *ecommerce = @{
                                @"items" : items,
                                kFIRParameterContentType : platformName
                                };
    [self firebaseAppTwo:kFIREventShare parameters:ecommerce];
    
    [FBSDKAppEvents logEvent:@"ShareProducts" parameters:ecommerce];
    
}
#pragma mark ---- *  推送埋点
/**
 *  推送埋点
 */
+ (void)pushBuriedPointTitle:(NSString *)title
{
    [self aws_StorageTimeInformation:@"ClickPush" parameters:@{@"title" : title.length ? title : @""}];
    
}




+ (void)page:(NSString *)pageName className:(NSString *)className
{
    NSDictionary *params = @{@"name" : pageName, @"clessName" : className};
    [FBSDKAppEvents logEvent:@"page" parameters:params];
    
    
    
    [FIRAnalytics setScreenName:pageName screenClass:className];
    NSDictionary * dic = @{
                           @"className" : className,
                           };
    [self aws_StorageTimeInformation:@"PageView" parameters:dic];
}


+ (void)aws_page:(NSString *)pageName className:(NSString *)className
{
    if (!pageName.length) {
        pageName = @"";
    }
    if (!className.length) {
        className = @"";
    }
    
    
    NSDictionary * dic = @{
                           @"className" : className,
                           };
    [self aws_StorageTimeInformation:@"PageView" parameters:dic];
}



/***  进入购物车 */
+ (void)cartPage
{
    NSDictionary *params = @{@"name" : @"ShoppingCart"};
    [FBSDKAppEvents logEvent:@"EnterShoppingCart" parameters:params];
    
    //    [self aws_StorageTimeInformation:@"EnterShoppingCart" parameters:params];
    
    [FIRAnalytics logEventWithName:@"EnterShoppingCart"
                        parameters:params];
}



#pragma mark ----*  feacebook 埋点
/**
 *  feacebook 埋点
 */
+ (void)facebookAppTwo:(NSString *)name parameters:(NSDictionary *)parameters
{
    [FBSDKAppEvents logEvent:name parameters:parameters];

}
/**
 *  kFIREventAddPaymentInfo  添加付款信息  下单
 *  kFIREventAddToCart  添加购物车
 *  kFIREventAddToWishlist  添加收藏
 *  kFIREventAppOpen   应用打开
 *  kFIREventBeginCheckout    开始支付
 *  kFIREventCampaignDetails   活动细节
 *  kFIREventCheckoutProgress  付款进度
 *  kFIREventEarnVirtualCurrency  虚拟货币
 *  kFIREventEcommercePurchase   采购
 *  kFIREventGenerateLead
 *  kFIREventJoinGroup
 *  kFIREventLevelUp
 *  kFIREventLogin  登陆
 *  kFIREventPostScore
 *  kFIREventPresentOffer
 *  kFIREventPurchaseRefund
 *  kFIREventRemoveFromCart  购物车删除
 *  kFIREventSearch   g搜索
 *  kFIREventSelectContent 选择内容
 *  kFIREventSetCheckoutOption  设置付款选项
 *  kFIREventSignUp  注册
 *  kFIREventSpendVirtualCurrency  使用虚拟货币
 *  kFIREventTutorialBegin  教程开始
 *  kFIREventTutorialComplete  教程完成
 *  kFIREventUnlockAchievement  解锁成就
 *  kFIREventViewItem 查看项目
 *  kFIREventViewItemList 查看项目列表
 *  kFIREventViewSearchResults  查看搜索结果
 *  kFIREventLevelStart  水平开始
 *  kFIREventLevelEnd  水平结束
 *  kFIREventShare 分享
 */
+ (void)firebaseAppTwo:(NSString *)name parameters:(NSDictionary *)parameters
{
    
    [FIRAnalytics logEventWithName:name parameters:parameters];
    
}
#pragma mark ----* aws 发送商品数据信息
/**
 *  发送商品数据信息
 */
+ (void)aws_StorageTimeInformation:(NSString *)name parameters:(NSDictionary *)parameters
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    XZZEquipmentInfor * infor = [XZZEquipmentInfor shareEquipmentInfor];
    
    [XZZBuriedDataSource allocInit];

    NSMutableDictionary * dict = parameters.mutableCopy;
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
    }
    [dict setValue:@((long)[NSDate date].timeIntervalSince1970 * 1000) forKey:@"eventTimestamp"];//时间戳
    [dict setObject:name forKey:@"eventName"];//事件名
    [dict setValue:infor.uuid forKey:@"userUniqId"];//唯一标识
    NSLog(@"%@", [User_Infor.userId class]);
    [dict setValue:[User_Infor.userId integerValue] != 0 ? User_Infor.userId : @"0" forKey:@"userUid"];//用户id
        [dict setValue:User_Infor.email forKey:@"userEmail"];//用户邮箱
        [dict setValue:infor.ip forKey:@"ip"];//用户IP
    [dict setObject:@"normal" forKey:@"eventType"];


    [dict setValue:@"Apple" forKey:@"deviceBrand"];//设备平台
    [dict setValue:infor.equipmentModel forKey:@"deviceModel"];//设备型号
    [dict setValue:@"iOS" forKey:@"deviceOS"];//设备操作系统
    [dict setValue:infor.systemVersion forKey:@"deviceOSVersion"];//系统版本
    [dict setValue:@"iOS" forKey:@"platform"];//哪一端
    [dict setValue:infor.app_Version forKey:@"appVersion"];//APP版本
    [dict setValue:@"App Store" forKey:@"appInstallSource"];//安卓来源
    [dict setObject:[self presentingVC] forKey:@"className"];//当前页面的类名
    [dict setObject:@"jolimall" forKey:@"brand"];//电商品牌
    
    NSLog(@"%@", dict);
    NSDictionary * dic = dict;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    str = [str stringByReplacingOccurrencesOfString:@"\n\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];


    NSData * data = [[NSString stringWithFormat:@"%@\n", str] dataUsingEncoding:NSUTF8StringEncoding];


#ifdef DEBUG
    [delegate.kinesisRecorder saveRecord:data streamName:@"xzz-b2c-mall-test"];
#else
    [delegate.kinesisRecorder saveRecord:data streamName:@"xzz-b2c-mall"];
#endif
    
    
}


//获取到当前所在的视图
+ (NSString *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    if (result) {
        return NSStringFromClass(result.class);
    }
    return @"UIViewController";
}

/**
 *  用户寻求帮助的方式   type 1  帮助列表  2 工单列表  3 添加工单  4 聊天
 */
+ (void)SupportPerson:(int)type
{
    NSString * str = @"";
    switch (type) {
        case 1:{
            str = @"help";
        }
            break;
        case 2:{
            str = @"ticket list";
        }
            break;
        case 3:{
            str = @"add ticket";
        }
            break;
        case 4:{
            str = @"chat";
        }
            break;
            
        default:{
            return;
        }
            break;
    }
    [self aws_StorageTimeInformation:@"Support" parameters:@{@"supportMethod" : str}];
}

@end

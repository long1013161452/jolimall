//
//  XZZUserInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZZAddressInfor.h"

#define user_infor_location @"user_infor_location"

#define User_Infor [XZZUserInfor sharedUserInfor]

/**
 *  判断收藏状态
 */
#define StateCollectionGoodsId(goodsId) [User_Infor determineStateCollectionGoodsId:goodsId]

/**
 *  用户信息
 */
@interface XZZUserInfor : NSObject

+ (XZZUserInfor *)sharedUserInfor;


/**
 * 是否登录  yes为登录状态   no为未登录状态
 */
@property (nonatomic, assign)BOOL isLogin;


/**
 * 邮箱
 */
@property (nonatomic, strong)NSString * email;

/**
 * id
 */
@property (nonatomic, strong)NSString * userId;

/**
 * token
 */
@property (nonatomic, strong)NSString * token;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * access_token;

/***  退出登陆 */
- (void)loggedOut;

- (void)userInformation:(id)result;

/**
 * 地址列表
 */
@property (nonatomic, strong)NSMutableArray * addressArray;

/**
 * 所有的国家信息
 */
@property (nonatomic, strong)NSArray * allCountriesArray;
/**
 *  获取默认地址信息
 */
- (XZZAddressInfor *)getDefaultAddressInfor;
/**
 *  读取本地用户信息
 */
+ (void)readLocalUserInformation;

/**
 *  获取地址信息
 */
- (void)getAddressListHttpBlock:(HttpBlock)httpBlock;
/**
 *  添加地址
 */
- (void)addAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;
/**
 *  删除地址
 */
- (void)deleteAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;
/**
 *  修改地址
 */
- (void)modifyAddress:(XZZAddressInfor *)address newAddress:(XZZAddressInfor *)newAddress httpBlock:(HttpBlock)httpBlock;
/**
 *  设置默认
 */
- (void)setDefaultAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock;

/**
 * 所有的收藏信息
 */
@property (nonatomic, strong)NSMutableArray * collectionArray;

/**
 *  获取收藏列表
 */
- (void)getInformationCollectibleGoodsHttpBlock:(HttpBlock)httpBlock;
/**
 *  收藏商品信息  source 来源  1 list  2 detail  3  personalcenter
 */
- (void)collectionGoodsId:(NSString *)goodsId source:(int)source httpBlock:(HttpBlock)httpBlock;
/**
 *  判断收藏状态
 */
- (BOOL)determineStateCollectionGoodsId:(NSString *)goodsId;




@end



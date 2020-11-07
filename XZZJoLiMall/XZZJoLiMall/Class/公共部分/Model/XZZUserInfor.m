//
//  XZZUserInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZUserInfor.h"




@interface XZZUserInfor ()

/**
 * 收藏   字典
 */
@property (nonatomic, strong)NSMutableDictionary * collectionDic;

@end

@implementation XZZUserInfor

static XZZUserInfor * userInfor;


+ (XZZUserInfor *)sharedUserInfor
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        userInfor = [[XZZUserInfor alloc]init];
        
    });
    return userInfor;
}

- (NSString *)email
{
    if (!_email.length) {
        return @"";
    }
    return _email;
}

- (NSMutableArray *)collectionArray
{
    if (!_collectionArray) {
        self.collectionArray = @[].mutableCopy;
    }
    return _collectionArray;
}

- (NSMutableDictionary *)collectionDic
{
    if (!_collectionDic) {
        self.collectionDic = @{}.mutableCopy;
    }
    return _collectionDic;
}

/**
 *  读取本地用户信息
 */
+ (void)readLocalUserInformation
{
    XZZUserInfor * user = [self sharedUserInfor];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_infor_location];
    [user userInformation:dic];
}

/***  退出登陆 */
- (void)loggedOut
{
    self.token = @"";
    self.userId = @"";
    self.email = @"";
    self.access_token = nil;
    [self.collectionArray removeAllObjects];
    [self.addressArray removeAllObjects];
    [self.collectionDic removeAllObjects];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:user_infor_location];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [all_cart removeCartInfor];
    self.isLogin = NO;

    
}

- (void)userInformation:(id)result
{
    NSDictionary * dic = result;
    if (![result isKindOfClass:[NSDictionary class]]) {
        self.isLogin = NO;
        return;
    }
    if ([dic count] == 0) {
        self.isLogin = NO;
        return;
    }
    NSMutableDictionary * mutableDic = [dic mutableCopy];
    [mutableDic removeObjectForKey:@"facebookId"];
    if ([mutableDic[@"id"] isKindOfClass:[NSNull class]]) {
        [mutableDic removeObjectForKey:@"id"];
    }

    [[NSUserDefaults standardUserDefaults] setObject:mutableDic forKey:user_infor_location];
    

    NSDictionary * token = dic[@"token"];
    self.access_token = [NSString stringWithFormat:@"%@ %@", token[@"token_type"], token[@"access_token"]];

    self.email = dic[@"email"];
    self.userId = dic[@"id"];
    self.token = token[@"refresh_token"];
    
    
    self.isLogin = YES;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogIn" object:nil];

    
//    [self deleteOrderInformation];
}

- (void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    if (isLogin) {
        [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:@"token"];
        [self downloadUserInformation];
        [self getInformationCollectibleGoodsHttpBlock:nil];
        [self getAddressListHttpBlock:^(id data, BOOL successful, NSError *error) {
            
        }];
    }
    
}

- (NSString *)userId
{
    if (!_userId) {
        self.userId = @"";
    }
    return _userId;
}

#pragma mark ----
/**
 *  下载用户信息    收藏信息  地址信息  购物车
 */
- (void)downloadUserInformation
{
    [all_cart getAllCartHttpBlock:^(id data, BOOL successful, NSError *error) {
        
    }];
    
}


- (void)getInformationCollectibleGoodsHttpBlock:(HttpBlock)httpBlock
{
    WS(wSelf)
    [XZZDataDownload userGetGoodsCollectionListHttpBlock:^(id data, BOOL successful, NSError *error) {
        [wSelf.collectionArray removeAllObjects];
        [wSelf.collectionDic removeAllObjects];
        if (successful) {
            if ([data isKindOfClass:[NSArray class]]) {
                [wSelf.collectionArray addObjectsFromArray:data];
            }
            for (XZZGoodsList * goodsList in data) {
                [wSelf.collectionDic setValue:goodsList forKey:goodsList.goodsId];
            }
        }
        !httpBlock?:httpBlock(nil, successful, error);
    }];
}


#pragma mark ----*  获取默认地址信息
/**
 *  获取默认地址信息
 */
- (XZZAddressInfor *)getDefaultAddressInfor
{
    for (XZZAddressInfor * address in self.addressArray) {
        if (address.status == 1) {
            return address;
        }
    }
    return [self.addressArray firstObject];
}

/**
 *  获取地址信息
 */
- (void)getAddressListHttpBlock:(HttpBlock)httpBlock
{
        WS(wSelf)
        [XZZDataDownload userGetAddressListHttpBlock:^(id data, BOOL successful, NSError *error) {
            if (successful) {
                wSelf.addressArray = [NSMutableArray arrayWithArray:data];
                !httpBlock?:httpBlock(nil, YES, nil);
            }else{
                !httpBlock?:httpBlock(nil, NO, nil);
            }
        }];
    
}

/**
 *  添加地址
 */
- (void)addAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
    [XZZDataDownload userGetAddAddress:address httpBlock:^(id data, BOOL successful, NSError *error) {
        NSString * remind = @"Shipping address added failed";
        if (successful) {
            remind = @"Shipping address added successfully";
        }
        !httpBlock?:httpBlock(remind, successful, error);
    }];
}
/**
 *  删除地址
 */
- (void)deleteAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
        [XZZDataDownload userGetDeleteAddress:address httpBlock:^(id data, BOOL successful, NSError *error) {
            NSString * remind = @"Shipping address deleted failed";
            if (successful == YES) {
                [self.addressArray removeObject:address];
                remind = @"Shipping address deleted successfully";
            }
            !httpBlock?:httpBlock(data, successful, error);
        }];

}
/**
 *  修改地址
 */
- (void)modifyAddress:(XZZAddressInfor *)address newAddress:(XZZAddressInfor *)newAddress httpBlock:(HttpBlock)httpBlock
{
    newAddress.ID = address.ID;
    newAddress.userId = User_Infor.userId;
    [XZZDataDownload userGetModifyAddress:newAddress httpBlock:^(id data, BOOL successful, NSError *error) {
        NSString * remind = @"Shipping address modified failed";
        if (successful) {
            [self.addressArray removeObject:address];
            [self.addressArray addObject:data];
            remind = @"Shipping address modified successfully";
        }
        !httpBlock?:httpBlock(data, successful, error);
    }];
}

- (void)setDefaultAddress:(XZZAddressInfor *)address httpBlock:(HttpBlock)httpBlock
{
    [XZZDataDownload userGetSetDefaultAddress:address httpBlock:^(id data, BOOL successful, NSError *error) {
        NSString * remind = @"Shipping address modified failed";
        if (successful) {
            for (XZZAddressInfor * addressTwo in self.addressArray) {
                if ([address.ID isEqualToString:addressTwo.ID]) {
                    address.status = 1;
                }else{
                    addressTwo.status = 0;
                }
            }
            remind = @"Shipping address modified successfully";
        }
        !httpBlock?:httpBlock(data, successful, error);
    }];
}


#pragma mark ----*  读取本地地址信息
/**
 *  读取本地地址信息
 */
- (void)readLocalAddress
{
    NSArray * shopDic = [NSKeyedUnarchiver unarchiveObjectWithFile:[self localAddressSaverLocation]];
    if (shopDic.count <= 0) {
        self.addressArray = [NSMutableArray array];
        return;
    }
    self.addressArray = shopDic.mutableCopy;
}


#pragma mark ----*  存储地址信息的位置
/**
 *  存储地址信息的位置
 */
- (NSString *)localAddressSaverLocation
{
    //获取沙盒Cache路径
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //文件路径
    NSString *uniquePath=[filePath stringByAppendingPathComponent:@"address_infor"];
    
    return uniquePath;
}



/**
 *  收藏商品信息  source 来源  1 list  2 detail  3  personalcenter
 */
- (void)collectionGoodsId:(NSString *)goodsId source:(int)source httpBlock:(HttpBlock)httpBlock
{
    weakView(weak_goodsId, goodsId)
    
    NSString * entrance = @"";
    switch (source) {
        case 1:{
            entrance = @"list";
        }
            break;
        case 2:{
            entrance = @"detail";
        }
            break;
        case 3:{
            entrance = @"personalcenter";
        }
            break;
            
        default:
            break;
    }
    
    if ([self determineStateCollectionGoodsId:goodsId]) {
        [XZZBuriedPoint logAddedToWishlistEvent:nil contentId:goodsId contentType:@"NO" entrance:entrance];
        id commodity = self.collectionDic[weak_goodsId];
        [self.collectionArray removeObject:commodity];
        [self.collectionDic removeObjectForKey:weak_goodsId];
        
        !httpBlock?:httpBlock(@"Collection to cancel successfully", YES, nil);
        /***  移除收藏 */
        [XZZDataDownload userGetDeleteCollectionGoods:goodsId httpBlock:^(id data, BOOL successful, NSError *error) {
            NSString * remind = @"Collection to cancel failed";
            if (successful) {
                id commodity = self.collectionDic[weak_goodsId];
                [self.collectionArray removeObject:commodity];
                [self.collectionDic removeObjectForKey:weak_goodsId];
                remind = @"Collection to cancel successfully";
            }
//            !httpBlock?:httpBlock(remind, successful, error);
        }];
    }else{
        [XZZBuriedPoint logAddedToWishlistEvent:nil contentId:goodsId contentType:@"YES" entrance:entrance];
        
        [self.collectionDic setObject:weak_goodsId forKey:weak_goodsId];
        !httpBlock?:httpBlock(@"Item has been added to Wishlist.", YES, nil);
        /***  添加收藏 */
        [XZZDataDownload userGetAddCollectionGoods:goodsId httpBlock:^(id data, BOOL successful, NSError *error) {
            
            NSLog(@"%s %d 行  ~~~~~~~~~~~~~~~~~ %@", __func__, __LINE__, successful ? @"YES" : @"NO");
            NSString * remind = @"Collection added failed";
            if (successful) {
                [self.collectionDic setObject:weak_goodsId forKey:weak_goodsId];
                remind = @"Item has been added to Wishlist.";
            }
            NSLog(@"%s %d 行  ~~~~~~~~~~~~~~~~~ %@", __func__, __LINE__, self.collectionDic);
//            !httpBlock?:httpBlock(remind, successful, error);
        }];
    }
}

/**
 *  判断收藏状态
 */
- (BOOL)determineStateCollectionGoodsId:(NSString *)goodsId
{
    return self.collectionDic[goodsId] ? YES : NO;
}


@end

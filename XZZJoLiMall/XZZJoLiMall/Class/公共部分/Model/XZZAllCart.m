//
//  XZZAllCart.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAllCart.h"

@interface XZZAllCart ()

/**
 * 是否是本地购物车
 */
@property (nonatomic, assign)BOOL isLocalCart;

@end

@implementation XZZAllCart

static XZZAllCart * allcart;

+ (XZZAllCart *)sharedAllCart
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        allcart = [[XZZAllCart alloc]init];
        
    });
    return allcart;
}

- (void)removeCartInfor
{
    [self.allCartArray removeAllObjects];
    [self.allCartDictionary removeAllObjects];
    [self.selectedCartDictionary removeAllObjects];
    [self deleteLocalShoppingCart];
    [self storeSelectedItemInfor];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];

}

#pragma mark ----*  获取所有选中的购物车商品
/**
 *  获取所有选中的购物车商品
 */
- (NSArray *)getSelectedCartArray
{
    NSMutableArray * array = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        if (self.selectedCartDictionary[cartInfor.ID] && cartInfor.status == 1) {
            [array addObject:cartInfor];
        }
    }
    return array.copy;
}

- (NSMutableDictionary *)selectedCartDictionary
{
    if (!_selectedCartDictionary) {
        [self readSelectedItemInfor];
    }
    return _selectedCartDictionary;
}

- (NSMutableArray *)allCartArray
{
    if (!_allCartArray) {
        self.allCartArray = @[].mutableCopy;
    }
    return _allCartArray;
}

- (NSMutableDictionary *)allCartDictionary
{
    if (!_allCartDictionary) {
        self.allCartDictionary = @{}.mutableCopy;
    }
    return _allCartDictionary;
}

#pragma mark ---- *  判断是否选中
/**
 *  判断是否选中
 */
- (BOOL)isSelectedCart:(XZZCartInfor *)cart
{
    if (self.selectedCartDictionary[cart.ID]) {
        return YES;
    }
    return NO;
}
#pragma mark ---- *  选中或者取消
/**
 *  选中或者取消
 */
- (BOOL)selectedOrCancelCart:(XZZCartInfor *)cart
{
    if (cart.status == 1) {
        if (self.selectedCartDictionary[cart.ID]) {
            [self.selectedCartDictionary removeObjectForKey:cart.ID];
            [self storeSelectedItemInfor];
            return NO;
        }else{
            [self.selectedCartDictionary setObject:@"1" forKey:cart.ID];
            [self storeSelectedItemInfor];
            return YES;
        }
        return YES;
    }
    return YES;
}
#pragma mark ---- *  全部选中或者取消
/**
 *  全部选中或者取消
 */
- (BOOL)allSelectedOrCancel
{
    if ([self determinesWhetherAllAreSelected]) {//已经全部选中了   进行取消
        [self.selectedCartDictionary removeAllObjects];
        [self storeSelectedItemInfor];
        return NO;
    }
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        if (cartInfor.status == 1) {
            [self.selectedCartDictionary setObject:@"1" forKey:cartInfor.ID];
        }
    }
    [self storeSelectedItemInfor];
    return YES;
}
#pragma mark ----*  判断是否全部选中
/**
 *  判断是否全部选中
 */
- (BOOL)determinesWhetherAllAreSelected
{
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        if (cartInfor.status == 1 && !self.selectedCartDictionary[cartInfor.ID]) {
            return NO;
        }
    }
    NSArray * array = [self getSelectedCartArray];
    if (array.count > 0) {
        return YES;
    }
    return NO;
}

#pragma mark ---- *  所有商品是否已下架
/**
 *  所有商品是否已下架
 */
- (BOOL)allGoodsRemovedFromShelves
{
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        if (cartInfor.status == 1) {
            return NO;
        }
    }
    return YES;
}
#pragma mark ---- *  购物车数量
/**
 *  购物车数量
 */
- (int)cartNum
{
    int count = 0;
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        count += cartInfor.skuNum;
    }
    return count;
}
#pragma mark ---- *  所有选中的购物车商品价格
/**
 *  所有选中的购物车商品价格
 */
- (CGFloat)allSelectedCartPrice
{
    CGFloat price = 0;
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        if (cartInfor.status == 1) {
            if (self.selectedCartDictionary[cartInfor.ID]) {
                price += (cartInfor.skuNum * cartInfor.skuPrice);
            }
        }
    }
    return price;
}
#pragma mark ---- *  添加购物车
/**
 *  添加购物车
 */
- (void)addCart:(XZZCartInfor *)cart goodsDetails:(XZZGoodsDetails *)goodsDetails httpBlock:(HttpBlock)httpBlock
{
    [XZZBuriedPoint addToCart:goodsDetails cart:cart];
    if (User_Infor.isLogin) {
        [XZZDataDownload cartAddShoppingCart:@[cart] isPurchased:YES httpBlock:^(id data, BOOL successful, NSError *error) {
             NSString * remind = @"Added to cart failed";
            if (successful) {
                [self.selectedCartDictionary setObject:@"1" forKey:cart.ID];
                [self storeSelectedItemInfor];
                [self getAllCartHttpBlock:^(id data, BOOL successful, NSError *error) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];
                }];
                remind = @"Added to cart successfully";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];
            !httpBlock?:httpBlock(remind, successful, error);
        }];
    }else{
        XZZCartInfor * cartInfor = [self.allCartDictionary objectForKey:cart.ID];
        [self.allCartArray removeObject:cartInfor];
        if (cartInfor) {
            cartInfor.skuNum += cart.skuNum;
        }else{
            [self.allCartDictionary setObject:cart forKey:cart.ID];
            cartInfor = cart;
        }
        [self.allCartArray insertObject:cartInfor atIndex:0];
        [self.selectedCartDictionary setObject:@"1" forKey:cart.ID];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];
        !httpBlock?:httpBlock(@"Added to cart successfully", YES, nil);
        [self storeLocalShoppingCart];
        [self storeSelectedItemInfor];
        self.isLocalCart = YES;
    }
}
#pragma mark ---- *  删除购物车
/**
 *  删除购物车
 */
- (void)deleteCart:(XZZCartInfor *)cart httpBlock:(HttpBlock)httpBlock
{
    [self.selectedCartDictionary removeObjectForKey:cart.ID];
    [XZZBuriedPoint removalsFromCart:cart];
    if (User_Infor.isLogin) {
        [XZZDataDownload cartDeleteShoppingCart:cart httpBlock:^(id data, BOOL successful, NSError *error) {
            NSString * remind = @"Deleted failed";
            if (successful) {
                [self.allCartArray removeObject:cart];
                remind = @"Delete success";
            }
            !httpBlock?:httpBlock(remind, successful, error);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];
        }];
    }else{
        
        id cartTwo = self.allCartDictionary[cart.ID];
        NSLog(@"===---===---===---  %@  \n  %@ \n  %@", cart, cartTwo, self.allCartArray);
        [self.allCartArray removeObject:cartTwo];
        [self.allCartDictionary removeObjectForKey:cart.ID];
        [self.selectedCartDictionary removeObjectForKey:cart.ID];
        [self storeLocalShoppingCart];
        [self storeSelectedItemInfor];
        !httpBlock?:httpBlock(@"Delete success", YES, nil);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];
        self.isLocalCart = YES;
    }
}
#pragma mark ---- *  修改购物车
/**
 *  修改购物车
 */
- (void)modifyCart:(XZZCartInfor *)cart count:(BOOL)count httpBlock:(HttpBlock)httpBlock
{
    if (User_Infor.isLogin) {
        [XZZDataDownload cartModifyShoppingCart:cart count:count httpBlock:httpBlock];
    }else{
        !httpBlock?:httpBlock(@"Modified the item numbers successfully", YES, nil);
        [self storeLocalShoppingCart];
        [self storeSelectedItemInfor];
    }
}
#pragma mark ---- *  获取购物车
/**
 *  获取购物车
 */
- (void)getAllCartHttpBlock:(HttpBlock)httpBlock
{
    if (User_Infor.isLogin) {
        
        if (self.isLocalCart && self.allCartArray.count) {
            self.isLocalCart = NO;
            [XZZDataDownload cartAddShoppingCart:self.allCartArray isPurchased:NO httpBlock:^(id data, BOOL successful, NSError *error) {
                [self deleteLocalShoppingCart];                
                [self getAllCartHttpBlock:httpBlock];
            }];
        }else{
            [XZZDataDownload cartGetShoppingCartInforHttpBlock:^(id data, BOOL successful,  NSError *error) {
                if (successful) {
                    [self processShoppingCartDataInformation:data];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];
                !httpBlock?:httpBlock(nil, YES, nil);
            }];
        }
        self.isLocalCart = NO;

    }else{
        [self readLocalShoppingCart];
        [self updateLocalShoppingCartInforHttpBlock:httpBlock];
    }
}
#pragma mark ----*  更新sku信息
/**
 *  更新sku信息
 */
- (void)updateLocalShoppingCartInforHttpBlock:(HttpBlock)httpBlock
{
    if (User_Infor.isLogin) {
        return;
    }
    self.isLocalCart = YES;
    NSMutableArray * skuIdList = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in self.allCartArray) {
        [skuIdList addObject:cartInfor.ID];
    }
    
    [XZZDataDownload cartGetSkuInforSkuIDs:skuIdList httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [self.allCartArray removeAllObjects];
            for (XZZSku * sku in data) {
                XZZCartInfor * cartInfor = [XZZCartInfor cartInforWithSku:sku num:0];
                [self.allCartArray addObject:cartInfor];
                
                XZZCartInfor * cartInforTwo = self.allCartDictionary[sku.ID];
                cartInfor.skuNum = cartInforTwo.skuNum > 0 ? cartInforTwo.skuNum : 1;
                [self.allCartDictionary setObject:cartInfor forKey:sku.ID];
            }
            [self storeLocalShoppingCart];
            !httpBlock?:httpBlock(nil, YES, nil);
        }else{
            !httpBlock?:httpBlock(data, NO, error);
        }
    }];
    
    
}

#pragma mark ----*  处理购物车数据信息
/**
 *  处理购物车数据信息
 */
- (void)processShoppingCartDataInformation:(NSArray *)array
{
    [self.allCartArray removeAllObjects];
    [self.allCartDictionary removeAllObjects];
    [self.allCartArray addObjectsFromArray:array];
    for (XZZCartInfor * cartInfor in array) {
        [self.allCartDictionary setObject:cartInfor forKey:cartInfor.ID];
    }
}

#pragma mark ----*  存储本地购物车
/**
 *  存储本地购物车
 */
- (void)storeLocalShoppingCart
{
    self.isLocalCart = YES;
    [NSKeyedArchiver archiveRootObject:self.allCartArray toFile:[self localShoppingCartPath]];
}
#pragma mark ----*  读取本地购物车
/**
 *  读取本地购物车
 */
- (void)readLocalShoppingCart
{
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:[self localShoppingCartPath]];
    [self.allCartArray removeAllObjects];
    [self.allCartDictionary removeAllObjects];
    for (XZZCartInfor * cartInfor in array) {
        [self.allCartArray addObject:cartInfor];
        [self.allCartDictionary setObject:cartInfor forKey:cartInfor.ID];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"numberShoppingCartsHasChanged" object:nil];

}
#pragma mark ----*  删除本地购物车
/**
 *  删除本地购物车
 */
- (void)deleteLocalShoppingCart
{
    //创建文件管理对象
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //拼接文件名
    NSString *uniquePath= [self localShoppingCartPath];
    //文件是否存在
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    //进行逻辑判断
    if (blHave) {
        /***  文件删除 */
        [fileManager removeItemAtPath:uniquePath error:nil];
    }
}

#pragma mark ----*  本地购物车路径
/**
 *  本地购物车路径
 */
- (NSString *)localShoppingCartPath
{
    //获取沙盒Cache路径
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //文件路径
    NSString *uniquePath=[filePath stringByAppendingPathComponent:@"shop_cart_name"];
    
    return uniquePath;
}
#pragma mark ----*  存储选中的商品信息
/**
 *  存储选中的商品信息
 */
- (void)storeSelectedItemInfor
{
    [NSKeyedArchiver archiveRootObject:self.selectedCartDictionary toFile:[self selectShoppingCartPathLocally]];
}
#pragma mark ----*  读取选中购物车信息
/**
 *  读取选中购物车信息
 */
- (void)readSelectedItemInfor
{
    NSDictionary * dic = [NSKeyedUnarchiver unarchiveObjectWithFile:[self selectShoppingCartPathLocally]];
    if (dic.count) {
        self.selectedCartDictionary = dic.mutableCopy;
    }else{
        self.selectedCartDictionary = @{}.mutableCopy;
    }
}
#pragma mark ----*  本地选中购物车路径
/**
 *  本地选中购物车路径
 */
- (NSString *)selectShoppingCartPathLocally
{
    //获取沙盒Cache路径
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //文件路径
    NSString *uniquePath=[filePath stringByAppendingPathComponent:@"selected_shop_cart_name"];
    
    return uniquePath;
}

#pragma mark ---- sku排序  将活动商品排在一起
/**
 * #pragma mark ---- sku排序  将活动商品排在一起
 */
- (NSArray *)skuSorting:(NSArray *)skuList
{
    NSMutableDictionary * dic = @{}.mutableCopy;
    NSMutableArray * activityIdList = @[].mutableCopy;
    for (XZZSku * sku in skuList) {
        NSString * key = @"-1";
        if (sku.activityVo.isShow) {
            key = sku.activityVo.activityId;
        }
        NSMutableArray * array = dic[key];
        if (!array) {
            array = @[].mutableCopy;
            [dic setObject:array forKey:key];
            [activityIdList addObject:key];
        }
        [array addObject:sku];
    }
    NSMutableArray * array = @[].mutableCopy;
    for (NSString * key in activityIdList) {
        if (![key isEqualToString:@"-1"]) {
                NSArray * skuList = dic[key];
            [array addObjectsFromArray:skuList];
        }
    }
    [array addObjectsFromArray:dic[@"-1"]];
    return array;
}

@end

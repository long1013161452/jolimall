//
//  XZZAllCart.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>


#define all_cart [XZZAllCart sharedAllCart]

/**
 *  所有购物车
 */
@interface XZZAllCart : NSObject

/**
 *  单利
 */
+ (XZZAllCart *)sharedAllCart;

/**
 * 所有购物车信息
 */
@property (nonatomic, strong)NSMutableArray * allCartArray;
/**
 * 所有购物车信息   字典方便存取
 */
@property (nonatomic, strong)NSMutableDictionary * allCartDictionary;
/**
 * 选中的购物车信息
 */
@property (nonatomic, strong)NSMutableDictionary * selectedCartDictionary;
/**
 *  移除购物车信息
 */
- (void)removeCartInfor;


/**
 *  获取所有选中的购物车商品
 */
- (NSArray *)getSelectedCartArray;

/**
 *  判断是否选中
 */
- (BOOL)isSelectedCart:(XZZCartInfor *)cart;
/**
 *  选中或者取消
 */
- (BOOL)selectedOrCancelCart:(XZZCartInfor *)cart;
/**
 *  全部选中或者取消
 */
- (BOOL)allSelectedOrCancel;
/**
 *  判断是否全部选中
 */
- (BOOL)determinesWhetherAllAreSelected;
/**
 *  所有商品是否已下架
 */
- (BOOL)allGoodsRemovedFromShelves;
/**
 *  购物车数量
 */
- (int)cartNum;
/**
 *  所有选中的购物车商品价格
 */
- (CGFloat)allSelectedCartPrice;
/**
 *  添加购物车
 */
- (void)addCart:(XZZCartInfor *)cart goodsDetails:(XZZGoodsDetails *)goodsDetails httpBlock:(HttpBlock)httpBlock;
/**
 *  删除购物车
 */
- (void)deleteCart:(XZZCartInfor *)cart httpBlock:(HttpBlock)httpBlock;
/**
 *  修改购物车
 */
- (void)modifyCart:(XZZCartInfor *)cart count:(BOOL)count httpBlock:(HttpBlock)httpBlock;
/**
 *  获取购物车
 */
- (void)getAllCartHttpBlock:(HttpBlock)httpBlock;

/**
 * #pragma mark ---- sku排序  将活动商品排在一起
 */
//- (NSArray *)skuSorting:(NSArray *)skuList;


@end


//
//  XZZCommonLogicalInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/18.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  登陆
 */
#define logInVC(vc) [XZZCommonLogicalInfor logInVC:vc];
/**
 *  进入商品详情
 */
#define GoodsDetails(goodsId, vc) [XZZCommonLogicalInfor goGoodsDetailsAccordingId:goodsId VC:vc];







/**
 *  公共逻辑信息
 */
@interface XZZCommonLogicalInfor : NSObject

/**
 *  处理商品收藏  source  1是列表   2是详情  3是用户页面
 */
+ (void)goodsCollectionAccordingId:(NSString *)goodsId source:(int)source VC:(UIViewController *)vc reloadData:(GeneralBlock)reloadData;
/**
 *  登陆
 */
+ (void)logInVC:(UIViewController *)VC;

/**
 *  进入商品详情
 */
+ (void)goGoodsDetailsAccordingId:(NSString *)goodsId VC:(UIViewController *)vc;



@end

NS_ASSUME_NONNULL_END

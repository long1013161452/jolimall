//
//  XZZHomeViewModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/8.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZHomeViewModel : NSObject

/**
 *  更新数据
 */
- (void)updateData;
/**
 *  数据下载   用于下拉加载
 */
- (void)dataDownload;

/**
 * tableview的区头视图
 */
@property (nonatomic, strong)NSMutableArray * tableHeardArray;

/**
 * 商品列表  商品信息
 */
@property (nonatomic, strong)NSMutableArray * goodsArray;

/**
 * 控制器
 */
@property (nonatomic, weak)UIViewController * VC;


/**
 * 用于刷新
 */
@property (nonatomic, strong)GeneralBlock reloadData;


@end

NS_ASSUME_NONNULL_END

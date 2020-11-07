//
//  XZZGoodsListCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/8.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN




@interface XZZGoodsListCell : UITableViewCell

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;


/**
 *  一排有几个商品
 */
@property (nonatomic, assign)int count;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL cartHidden;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL collectionHidden;

/**
 * 展示商品角标信息   
 */
@property (nonatomic, assign)XZZGoodsViewDisplayAngle goodsViewDisplay;

/**
 * 商品信息   数组
 */
@property (nonatomic, strong)NSArray * goodsArray;

+ (CGFloat)calculateCellHeight:(int)count;


@end

NS_ASSUME_NONNULL_END

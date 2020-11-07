//
//  XZZRequestSku.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/27.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZRequestSku : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * colorId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * sizeId;

/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat discount;

@end

NS_ASSUME_NONNULL_END

//
//  XZZFeedback.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZFeedback : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * content ;//   string
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * createTime ;//   string($date-time)
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * email ;//   string
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID  ;//  integer($int64)
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * title ;//   string
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * tokenId ;//   string
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * userId ;//   integer($int64)

@end

NS_ASSUME_NONNULL_END

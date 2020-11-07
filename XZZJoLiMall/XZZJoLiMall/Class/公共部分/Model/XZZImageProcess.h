//
//  XZZImageProcess.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  图片处理
 */
@interface XZZImageProcess : NSObject

+ (instancetype)allocInitUrl:(NSString *)url width:(int)width height:(int)height;


/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * bucket;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * key;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSDictionary * edits;




@end




NS_ASSUME_NONNULL_END

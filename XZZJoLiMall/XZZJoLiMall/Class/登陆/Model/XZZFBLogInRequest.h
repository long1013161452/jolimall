//
//  XZZFBLogInRequest.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/10/10.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZFBLogInRequest : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * email;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * facebookId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * facebookName;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * appleId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * appleName;
@end


@interface XZZUserLogInRequest : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * email;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * loginPwd;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * confirmPwd;

@end

NS_ASSUME_NONNULL_END

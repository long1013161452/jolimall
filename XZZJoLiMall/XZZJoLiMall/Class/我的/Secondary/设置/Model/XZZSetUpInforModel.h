//
//  XZZSetUpInforModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XZZALLSetUpInfor : NSObject

+ (XZZALLSetUpInfor *)shareAllSetUpInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * setUpInforArray;



@end





@interface XZZSetUpInforModel : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * name;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * httpUrl;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * title;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * content;

@end

NS_ASSUME_NONNULL_END

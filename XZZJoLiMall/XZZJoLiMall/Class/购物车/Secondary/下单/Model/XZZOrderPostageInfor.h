//
//  XZZOrderPostageInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/29.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZOrderPostageInfor : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID;
/**
 * id
 */
@property (nonatomic, strong)NSString * transportId;
/**
 * 标题
 */
@property (nonatomic, strong)NSString * name;

/**
 * 限制
 */
@property (nonatomic, assign)CGFloat freeLimit;
/**
 * 邮费
 */
@property (nonatomic, assign)CGFloat fee;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * desc;

@end

/**
 *  自定义邮费信息
 */
@interface XZZOrderCalculatePostageInfor : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat type;
/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat fee;

@end

@interface XZZAllOrderPostageInfor : NSObject

+ (XZZAllOrderPostageInfor *)shareAllOrderPostageInfor;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * allPostageInforArray;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * allCalculatePostageInforArray;

- (void)getAllPostageInformation:(HttpBlock)httpBlock;

- (void)getAllPostageInformationWeight:(int)weight goodsNum:(int)goodsNum httpBlock:(HttpBlock)httpBlock;


@end

NS_ASSUME_NONNULL_END

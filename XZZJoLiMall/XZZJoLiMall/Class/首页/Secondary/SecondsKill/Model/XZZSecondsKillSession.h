//
//  XZZSecondsKillSession.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 秒杀场次
 */
@interface XZZSecondsKillSession : NSObject


/**
 * 结束时间
 */
@property (nonatomic, strong)NSString * endTime;

/**
 * id
 */
@property (nonatomic, strong)NSString * ID;
/**
 * 开始时间
 */
@property (nonatomic, strong)NSString * startTime;

/**
 *     0.暂停 1.开启 2.过期 3.进行中 4.预设
 */
@property (nonatomic, assign)NSInteger status;


@end

/**
 * 所有 秒杀场次
 */
@interface XZZALLSecondsKillSession : NSObject


/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * bannerImage;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * seoDescription;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * seoTitle;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableArray<XZZSecondsKillSession *> * seckillDetailVoList;


@end

NS_ASSUME_NONNULL_END

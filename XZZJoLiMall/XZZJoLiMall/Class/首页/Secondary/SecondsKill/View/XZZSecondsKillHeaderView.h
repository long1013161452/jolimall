//
//  XZZSecondsKillHeaderView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



/** 秒杀*/
@interface XZZSecondsKillHeaderView : UIView


/**
 * <#expression#>
 */
@property (nonatomic, strong) FLAnimatedImageView * imageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * secondsKillList;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * imageUrl;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * backView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock refreshBlock;
/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectSession selectSession;


/**
 * 滚动视图的前面
 */
@property (nonatomic, assign)CGFloat scrollViewX;



@end

NS_ASSUME_NONNULL_END

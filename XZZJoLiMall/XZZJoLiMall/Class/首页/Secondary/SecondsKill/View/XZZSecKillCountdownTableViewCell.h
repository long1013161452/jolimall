//
//  XZZSecKillCountdownTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/12/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZSecKillCountdownTableViewCell : UITableViewCell

/**
 * 倒计时时间
 */
@property (nonatomic, strong)NSString * time;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * state;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END

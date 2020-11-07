//
//  XZZSecondsKillGodosListXIBTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/28.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZSecondsKillGoods.h"

#import "XZZLocalPushRecord.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^ClickOutRemind)(NSString * goodsId, UIImage * image);


@interface XZZSecondsKillGodosListXIBTableViewCell : UITableViewCell

/**
 * <#expression#>
 */
@property (nonatomic, assign)XZZSecondsKillState state;

/**
 * <#expression#>
 */
@property (nonatomic, assign)XZZSecondsKillGoodsLocation goodsLocation;


/**
 * <#expression#>
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * <#expression#>
 */
@property (nonatomic, strong)ClickOutRemind remindMe;

@property (nonatomic, strong)ClickOutRemind cancleReminder;


/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecondsKillGoods * goods;

@property (nonatomic, strong)NSString * secKillId;

@end

NS_ASSUME_NONNULL_END

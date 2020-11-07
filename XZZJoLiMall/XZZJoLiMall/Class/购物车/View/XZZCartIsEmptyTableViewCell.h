//
//  XZZCartIsEmptyTableViewCell.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZCartIsEmptyTableViewCell : UITableViewCell

- (void)addView;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

//
//  XZZCheckOutSelectedFreightView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  展示y选中的邮费信息
 */
@interface XZZCheckOutSelectedFreightView : UIView


/**
 * 邮费
 */
@property (nonatomic, assign)CGFloat postage;

- (void)setPostage:(CGFloat)postage name:(NSString *)name;

/**
 * 选择地址
 */
@property (nonatomic, strong)GeneralBlock changePostage;


@end

NS_ASSUME_NONNULL_END

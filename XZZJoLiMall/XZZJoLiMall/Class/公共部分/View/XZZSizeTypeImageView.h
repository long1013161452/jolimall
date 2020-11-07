//
//  XZZSizeTypeImageView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZSizeTypeImageView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * imageUrl;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * transparentLayerView;
/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;

@end

NS_ASSUME_NONNULL_END

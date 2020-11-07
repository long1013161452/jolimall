//
//  XZZShareView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XZZShareView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, weak)UIViewController *  VC;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * imageURL;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * title;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * url;
/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

- (void)addView;

/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;




@end








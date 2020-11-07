//
//  XZZRootViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  控制器的根父类
 */
@interface XZZRootViewController : UIViewController

/**
 * 标题
 */
@property (nonatomic, strong)NSString * myTitle;

/**
 * 页面名称标签
 */
@property (nonatomic, strong)NSString * nameVC;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * chatImageView;



/***  进入GIF活动页面 */
- (void)goToGIFActivitiesPage;
/***  添加聊天 活动 浮窗 */
- (void)addChatAndActivityFloatWindow;

@end

NS_ASSUME_NONNULL_END

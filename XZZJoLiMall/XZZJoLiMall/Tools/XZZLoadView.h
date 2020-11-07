//
//  XZZLoadView.h
//  ZBYElectricity
//
//  Created by 龙少 on 2018/9/15.
//  Copyright © 2018年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

#define loadView(view) [XZZLoadView loadView:view];

#define loadViewStop [XZZLoadView stop];

/*** 展示成功的提示框*/
#define SVProgressSuccess(data) [PromptInformation showSuccessWithStatus:data];
/*** 展示成功的提示框*/
#define SVProgressError(data) [PromptInformation showErrorWithStatus:data];

@interface XZZLoadView : UIView


+ (void)loadView:(UIView *)view;

+ (void)stop;


@end



@interface PromptInformation : NSObject

+ (void)showSuccessWithStatus:(NSString *)status;

+ (void)showErrorWithStatus:(NSString *)status;

@end

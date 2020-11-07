//
//  XZZLoadView.m
//  ZBYElectricity
//
//  Created by 龙少 on 2018/9/15.
//  Copyright © 2018年 long. All rights reserved.
//

#import "XZZLoadView.h"
#import "HYCircleProgressView.h"





@interface XZZLoadView ()


@property (weak, nonatomic) IBOutlet UIImageView *loadImageView;

@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation XZZLoadView


static XZZLoadView * loadView;


+ (XZZLoadView *)sharedLoadView
{
    static dispatch_once_t oneToken;
//
    dispatch_once(&oneToken, ^{
    
        loadView = [XZZLoadView XibInitializationMethodFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        NSMutableArray * array = @[].mutableCopy;
        for (int i = 1; i < 33; i++) {
            NSString * imageName = [NSString stringWithFormat:@"loading_%d", i];
            UIImage * image = imageName(imageName);
            if (image) {
                [array addObject:image];
            }
        }
        loadView.backView.layer.cornerRadius = 8;
        loadView.loadImageView.animationImages = array;
        loadView.loadImageView.animationDuration = 2;
        loadView.loadImageView.animationRepeatCount = 0;
    });

    return loadView;
}



+ (void)loadView:(UIView *)view
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        XZZLoadView * load = [self sharedLoadView];
        [((AppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:load];
        [load.loadImageView startAnimating];
    });
}

+ (void)stop
{
    dispatch_async(dispatch_get_main_queue(), ^{
        XZZLoadView * load = [self sharedLoadView];
        [load removeFromSuperview];
        [load.loadImageView stopAnimating];
    });
}

@end



@implementation PromptInformation

+ (void)showSuccessWithStatus:(NSString *)status
{
    
    if ([NSThread isMainThread]) {
        [SVProgressHUD showSuccessWithStatus:status];
    }
    return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:status];
    });
    
}

+ (void)showErrorWithStatus:(NSString *)status
{
    if ([NSThread isMainThread]) {
        [SVProgressHUD showErrorWithStatus:status];
    }
    return;
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:status];
    });
}

@end

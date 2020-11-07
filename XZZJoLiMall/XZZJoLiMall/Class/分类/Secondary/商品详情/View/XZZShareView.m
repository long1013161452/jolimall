//
//  XZZShareView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZShareView.h"

#import "XZZSingleSharedView.h"

@interface XZZShareView ()


/**
 * 透明层
 */
@property (nonatomic, strong)UIView * transparentLayerView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

@end

@implementation XZZShareView


- (void)addView
{
    WS(wSelf)
    [self removeAllSubviews];
    /***  背景透明视图 */
    self.transparentLayerView = [UIView allocInitWithFrame:self.bounds];
    self.transparentLayerView.backgroundColor = kColorWithRGB(0, 0, 0, .55);
    [self.transparentLayerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:self.transparentLayerView];
    
    CGFloat backViewHeight = StatusRect.size.height > 20 ? (177 + bottomHeight) : 177;
    
    /***  用于展示分享类型 */
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, self.height, ScreenWidth, backViewHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    self.backView = backView;
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? ( bottomHeight) : 0;
    UIButton * cancelButton = [UIButton allocInit];
    [cancelButton setImage:imageName(@"goods_details_Shut_down") forState:(UIControlStateNormal)];
    [cancelButton setImage:imageName(@"goods_details_Shut_down") forState:(UIControlStateHighlighted)];
    [cancelButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.backView);
        make.height.equalTo(@(45));
        make.bottom.equalTo(wSelf.backView).offset(-buttonBottom);
    }];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, .5)];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self.backView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(cancelButton);
        make.height.equalTo(@.5);
    }];
    
    XZZSingleSharedView * FBShareView = [XZZSingleSharedView allocInit];
    FBShareView.imageView.image = imageName(@"goods_details_FB");
    FBShareView.nameLabel.text = @"FaceBook";
    [FBShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
    FBShareView.tag = 1;
    [self.backView addSubview:FBShareView];
    [FBShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(wSelf.backView);
        make.bottom.equalTo(dividerView.mas_top);
    }];
    
    UIView * leftView = FBShareView;
    
    if ([RFBMessenger shared].whetherInstall) {
        XZZSingleSharedView * FBMShareView = [XZZSingleSharedView allocInit];
        FBMShareView.imageView.image = imageName(@"goods_details_Messenger");
        FBMShareView.nameLabel.text = @"Message";
        [FBMShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        FBMShareView.tag = 2;
        [self.backView addSubview:FBMShareView];
        [FBMShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = FBMShareView;
    }
    
    
    if ([RWhatsAppManager shared].whetherInstall) {
        XZZSingleSharedView * WHAPPShareView = [XZZSingleSharedView allocInit];
        WHAPPShareView.imageView.image = imageName(@"goods_details_whatsapp");
        WHAPPShareView.nameLabel.text = @"WhatsApp";
        [WHAPPShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        WHAPPShareView.tag = 3;
        [self.backView addSubview:WHAPPShareView];
        [WHAPPShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
            
        }];
        leftView = WHAPPShareView;
    }
    
    if ([RPinterestManager shared].whetherInstall) {
        XZZSingleSharedView * PShareView = [XZZSingleSharedView allocInit];
        PShareView.imageView.image = imageName(@"goods_details_pinterest");
        PShareView.nameLabel.text = @"pinterest";
        [PShareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        PShareView.tag = 4;
        [self.backView addSubview:PShareView];
        [PShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.bottom.width.equalTo(leftView);
        }];
        leftView = PShareView;
    }
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.backView).offset(-15);
    }];
    
    
}


- (void)shareTap:(UITapGestureRecognizer *)tap
{
    if (self.VC && self.title && self.imageURL && self.url) {
        [self clickOnGoodsShareType:tap.view.tag];
    }else{
        if ([self.delegate respondsToSelector:@selector(clickOnGoodsShareType:)]) {
            [self.delegate clickOnGoodsShareType:tap.view.tag];
        }
    }
    [self removeView];
}


#pragma mark ----分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
/**
 *  分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
 */
- (void)clickOnGoodsShareType:(NSInteger)type
{
    NSString * urlStr = self.url;
    NSString * title = self.title;
    NSString * imageUrl = self.imageURL;
    switch (type) {
        case 1:{
            RFacebookManager* manager = [RFacebookManager shared];
            [manager shareWebpageWithURL:urlStr
                                   quote:title
                                 hashTag:@"JoLiMall"
                                    from:self.VC
                                    mode:ShareModeSheet//ShareModeAutomatic
                              completion:^(RShareSDKPlatform platform, ShareResult result, NSString *errorInfo) {
                                  if (result == RShareResultSuccess) {
                                      NSLog(@"分享成功");
                                  } else if (result == RShareResultCancel){
                                      NSLog(@"分享取消");
                                  } else {
                                      NSLog(@"分享失败%@", errorInfo);
                                  }
                              }];
        }
            break;
        case 2:{
            [[RFBMessenger shared] shareTitle:title
                                          url:urlStr
                                 elementTitle:title
                                     subtitle:title
                                     imageUrl:imageUrl
                                   completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
                                       if (result == RShareResultSuccess) {
                                           NSLog(@"分享成功");
                                       } else if (result == RShareResultCancel){
                                           NSLog(@"分享取消");
                                       } else {
                                           NSLog(@"分享失败%@", errorInfo);
                                           
                                       }
                                   }];
        }
            break;
        case 3:{
            [[RWhatsAppManager shared]shareText:[NSString stringWithFormat:@"%@\n%@", title, urlStr]];
        }
            break;
        case 4:{
            RPinterestManager* manager = [RPinterestManager shared];
            [manager shareImageWithURL:imageUrl
                            webpageURL:urlStr
                               onBoard:@"JoLiMall"
                           description:title
                                  from:self.VC
                            completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
                                if (result == RShareResultSuccess) {
                                    NSLog(@"分享成功");
                                } else if (result == RShareResultCancel){
                                    NSLog(@"分享取消");
                                } else {
                                    NSLog(@"分享失败%@", errorInfo);
                                    
                                }
                            }];
        }
            break;
            
        default:
            break;
    }
}





/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [self bringSubviewToFront: [UIApplication sharedApplication].delegate.window];
        [UIView animateWithDuration:.3 animations:^{
            self.backView.top = ScreenHeight - self.backView.height;
        }];
    });
    
    
}

/**
 * 移除视图
 */
- (void)removeView
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.backView.top = ScreenHeight;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
    
    
}


@end



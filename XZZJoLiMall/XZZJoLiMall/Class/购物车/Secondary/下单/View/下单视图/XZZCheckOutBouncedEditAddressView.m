//
//  XZZCheckOutBouncedEditAddressView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutBouncedEditAddressView.h"

@interface XZZCheckOutBouncedEditAddressView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

@end

@implementation XZZCheckOutBouncedEditAddressView


- (void)setAddressInfor:(XZZAddressInfor *)addressInfor
{
    _addressInfor = addressInfor;
    if (!self.editAddressInforView) {
        [self addView];
    }
    self.editAddressInforView.addressInfor = addressInfor;
}

- (void)addView
{
    WS(wSelf)
    UIView * view = [UIView allocInit];
    view.backgroundColor = kColorWithRGB(0, 0, 0, .3);
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(wSelf);
    }];
    
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.7)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, ScreenWidth, 45) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    label.text = @"Shipping Address";
    label.font = textFont_bold(14);
    [self.backView addSubview:label];
    
    UIButton * shutDownButton = [UIButton allocInitWithImageName:@"goods_details_Shut_down" selectedImageName:@"goods_details_Shut_down"];
    shutDownButton.frame = CGRectMake(self.backView.width - label.height, 0, label.height, label.height);
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:shutDownButton];
    
    UIView * dividerView1 = [UIView allocInitWithFrame:CGRectMake(0, label.bottom - .5, ScreenWidth, .5)];
    dividerView1.backgroundColor = DIVIDER_COLOR;
    [label addSubview:dividerView1];
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? bottomHeight : 0;

    UIButton * button = [UIButton allocInitWithTitle:@"Continue to shipping" color:kColor(0xffffff) selectedTitle:@"Continue to shipping" selectedColor:kColor(0xffffff) font:18];
    button.frame = CGRectMake(0, self.backView.height - buttonBottom - 45, ScreenWidth, 45);
    button.backgroundColor = button_back_color;
    [button addTarget:self action:@selector(checkOutEditAddressInformation) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:button];
    
    
    self.scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, label.bottom, ScreenWidth, button.top - label.bottom)];
    [self.backView addSubview:self.scrollView];
    
    
    self.editAddressInforView = [XZZCheckOutEditAddressInforView allocInit];
    self.editAddressInforView.selectCountryInforViewModel = self.selectCountryInforViewModel;
    [self.scrollView addSubview:self.editAddressInforView];
    [self.editAddressInforView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(@0);
    }];
    
    [self dynamicChangesRefreshView];
}

- (void)checkOutEditAddressInformation
{
    !self.editAddressInforBlock?:self.editAddressInforBlock();
}

#pragma mark ----*  动态延时刷新视图
/**
 *  动态延时刷新视图
 */
- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.scrollView.contentSize = CGSizeMake(0, wSelf.editAddressInforView.bottom + 20);
    });
}


/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [wSelf.VC.view addSubview:wSelf];
        CGFloat top = StatusRect.size.height > 20 ? 88 : 64;
        [UIView animateWithDuration:.3 animations:^{
            wSelf.backView.bottom = ScreenHeight - top;
        }];
    });
}

/**
 * 移除视图
 */
- (void)removeView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            wSelf.backView.top = ScreenHeight;
        } completion:^(BOOL finished) {
            [wSelf removeFromSuperview];
        }];
    });
}

@end

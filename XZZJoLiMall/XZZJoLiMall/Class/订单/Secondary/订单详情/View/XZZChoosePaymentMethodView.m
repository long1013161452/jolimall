//
//  XZZChoosePaymentMethodView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZChoosePaymentMethodView.h"

#import "XZZPaymentType.h"

@interface XZZChoosePaymentMethodView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

@end

@implementation XZZChoosePaymentMethodView





- (void)setPaymentTypeArr:(NSArray *)paymentTypeArr
{
    _paymentTypeArr = paymentTypeArr;
    [self addView];
}

- (void)addView
{
    [self removeAllSubviews];
    WS(wSelf)
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backView.backgroundColor = kColorWithRGB(0, 0, 0, .55);
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:backView];
    
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * (1.1 / 2.0))];
    self.backView.backgroundColor = kColor(0xffffff);
    [self addSubview:self.backView];
    
    UILabel * titleView = [UILabel labelWithFrame:CGRectMake(0, 0, ScreenWidth, 50) backColor:nil textColor:kColor(0x191919) textFont:16 textAlignment:(NSTextAlignmentCenter) tag:1];
    titleView.font = textFont_bold(16);
    titleView.text = @"Payment Method";
    [self.backView addSubview:titleView];
    
    UIButton * shutDownButton = [UIButton allocInitWithImageName:@"order_Add_comments_Shut_down" selectedImageName:@"order_Add_comments_Shut_down"];
    shutDownButton.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:shutDownButton];
    
    CGFloat top = titleView.bottom + 10;
    BOOL card = NO;
    BOOL payPay = NO;
    for (XZZPaymentType * type in self.paymentTypeArr) {
        if (type.payType == 0) {
            payPay = YES;
        }else{
            card = YES;
        }
    }
    
    if (card) {
        UIView * cardView = [self viewFrame:CGRectMake(0, top, ScreenWidth, 50) imageName:@"order_pay_card" title:@"Credit Card" titleColor:kColor(0xED9F2D)];
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOutCart)]];
        top = cardView.bottom;
    }
    
    if (payPay) {
        UIView * payPayView = [self viewFrame:CGRectMake(0, top, ScreenWidth, 50) imageName:@"order_pay_paypal_two" title:nil titleColor:nil];
        [payPayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOutPayPal)]];
        top = payPayView.bottom;
    }
    
    self.backView.height = top + 50;
    
}

- (void)clickOutCart
{
    !self.cardPay?:self.cardPay();
    [self removeView];
}

- (void)clickOutPayPal
{
    !self.payPalPay?:self.payPalPay();
    [self removeView];
}





- (UIView *)viewFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)titleColor
{
    UIView * backView = [UIView allocInitWithFrame:frame];
    [self.backView addSubview:backView];
    weakView(weak_backView, backView)
    UIView * view = [UIView allocInit];
    view.userInteractionEnabled = NO;
    [backView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.top.equalTo(weak_backView);
    }];
    weakView(weak_view, view)
    UIImage * image = imageName(imageName);
        UIImageView * imageView = [UIImageView allocInit];
        imageView.image = image;
        [view addSubview:imageView];
    weakView(weak_laftView, imageView)
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@10);
            make.centerY.equalTo(weak_view);
            make.width.equalTo(weak_laftView.mas_height).multipliedBy(image.size.width / image.size.height);
            if (!title) {
                make.right.equalTo(weak_view);
            }
        }];
    
    if (title) {
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:titleColor textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
        label.text = title;
        label.font = textFont_bold(16);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weak_laftView.mas_right).offset(5);
            make.centerY.equalTo(weak_laftView);
            make.right.equalTo(weak_view);
        }];
    }
    return backView;
}

/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [UIView animateWithDuration:.3 animations:^{
            wSelf.backView.bottom = ScreenHeight;
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

//
//  XZZOrderDetailsPriceView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/17.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZOrderDetailsPriceView.h"

@interface XZZOrderDetailsPriceView ()

/**
 * 运费
 */
@property (nonatomic, strong)UILabel * shippingLabel;

/**
 * 支付金额
 */
@property (nonatomic, strong)UILabel * totalLabel;
/**
 * d商品总价
 */
@property (nonatomic, strong)UILabel * subTotalLabel;
/**
 * 优惠价格
 */
@property (nonatomic, strong)UILabel * discountLabel;
/**
 * 利润label
 */
@property (nonatomic, strong)UILabel * profitLabel;

/**
 * 支付按钮
 */
@property (nonatomic, strong)UIButton * payNowButton;

@end

@implementation XZZOrderDetailsPriceView


+ (instancetype)allocInit
{
    XZZOrderDetailsPriceView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    
    NSLog(@"%s %d 行", __func__, __LINE__);
    self.backgroundColor = [UIColor whiteColor];
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@10);
    }];
    
    weakView(weak_dividerView, dividerView)
    self.subTotalLabel = [self priceInforTitle:@"Sub Total:" textColor:kColor(0x000000) priceColor:kColor(0x191919) font:textFont(14)];
    UIView * subTotalView = self.subTotalLabel.superview;
    [subTotalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_dividerView.mas_bottom).offset(16);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@20);
    }];
    weakView(weak_subTotalView, subTotalView)
    self.shippingLabel = [self priceInforTitle:@"Shipping:" textColor:kColor(0x000000) priceColor:kColor(0x191919) font:textFont(14)];
    UIView * shippingView = self.shippingLabel.superview;
    [shippingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@20);
        make.top.equalTo(weak_subTotalView.mas_bottom);
    }];
    weakView(weak_shippingView, shippingView)
    
    self.discountLabel = [self priceInforTitle:@"Discount:" textColor:kColor(0x000000) priceColor:kColor(0x191919) font:textFont(14)];
    UIView * discountView = self.discountLabel.superview;
    [discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_shippingView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@20);
    }];
    
    weakView(weak_discountView, discountView)
    
    self.profitLabel = [self priceInforTitle:@"Profit:" textColor:kColor(0x000000) priceColor:kColor(0x191919) font:textFont(14)];
    UIView * profitView = self.profitLabel.superview;
    [profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_discountView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@30);
    }];
    
    weakView(weak_profitView, profitView)
    self.totalLabel = [self priceInforTitle:@"Total:" textColor:kColor(0x000000) priceColor:kColor(0xFF4444) font:textFont_bold(16)];
    UIView * totalView = self.totalLabel.superview;
    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_profitView.mas_bottom).offset(5);
        make.height.equalTo(@30);
    }];
    
    weakView(weak_totalView, totalView)
    
    CGFloat buttonBackHeight = (StatusRect.size.height > 20 ? bottomHeight : 0) + 76;
    
    UIView * buttonBackView = [UIView allocInit];
    buttonBackView.backgroundColor = BACK_COLOR;
    [self addSubview:buttonBackView];
    [buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_totalView.mas_bottom).offset(20);
        make.height.equalTo(@(buttonBackHeight));
    }];
    
    self.payNowButton = [UIButton allocInitWithTitle:@"Pay Now" color:kColor(0xffffff) selectedTitle:@"Pay Now" selectedColor:kColor(0xffffff) font:16];
    self.payNowButton.titleLabel.font = textFont_bold(16);
//    [self.payNowButton cutRounded:22];
    self.payNowButton.layer.cornerRadius = 22;
    self.payNowButton.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:68/255.0 alpha:0.2].CGColor;
    self.payNowButton.layer.shadowOffset = CGSizeMake(0,8);
    self.payNowButton.layer.shadowOpacity = 1;
    self.payNowButton.layer.shadowRadius = 8;
    self.payNowButton.backgroundColor = button_back_color;
    [self.payNowButton addTarget:self action:@selector(clickOnPayNowButton) forControlEvents:(UIControlEventTouchUpInside)];
    [buttonBackView addSubview:self.payNowButton];
    [self.payNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.left.equalTo(@16);
        make.top.equalTo(@16);
        make.right.equalTo(wSelf).offset(-84);
    }];
    
    
}

- (void)setOrderDetail:(XZZOrderDetail *)orderDetail
{
    _orderDetail = orderDetail;
    
    if (orderDetail.discount <= 0) {
        self.discountLabel.superview.hidden = YES;
        [self.discountLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else{
        self.discountLabel.text = [NSString stringWithFormat:@"-$%.2f", orderDetail.discount];
    }
    
    if (orderDetail.profit <= 0) {
        self.profitLabel.superview.hidden = YES;
        [self.profitLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else{
        self.profitLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.profit];
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.total];;
    self.shippingLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.shipping];
    self.subTotalLabel.text = [NSString stringWithFormat:@"$%.2f", orderDetail.subTotal];
    
    
}

- (void)clickOnPayNowButton
{
    !self.payNow?:self.payNow();
}




- (void)setHideButton:(BOOL)hideButton
{
    _hideButton = hideButton;
    if (hideButton) {
        [self.payNowButton.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];

        self.payNowButton.superview.hidden = YES;
    }
}


- (UILabel *)priceInforTitle:(NSString *)title textColor:(UIColor *)textColor priceColor:(UIColor *)priceColor font:(UIFont *)font
{
    UIView * view = [UIView allocInit];
    [self addSubview:view];
    weakView(weak_view, view)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.font = font;
    titleLabel.text = title;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.bottom.equalTo(weak_view);
        make.width.equalTo(@90);
    }];
    
    weakView(weak_titleLabel, titleLabel)
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:priceColor textFont:12 textAlignment:(NSTextAlignmentRight) tag:1];
    priceLabel.font = font;
    [view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_titleLabel.mas_right);
        make.top.bottom.equalTo(weak_view);
    }];
    return priceLabel;
    
}


@end

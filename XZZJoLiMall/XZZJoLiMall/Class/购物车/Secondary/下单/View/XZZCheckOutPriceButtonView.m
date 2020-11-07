//
//  XZZCheckOutPriceButtonView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutPriceButtonView.h"

@interface XZZCheckOutPriceButtonView ()

/**
 * 商品总价
 */
@property (nonatomic, strong)UIView * subtotalView;

/**
 * 商品总价
 */
@property (nonatomic, strong)UILabel * subtotalLabel;

/**
 * 运费
 */
@property (nonatomic, strong)UIView * shippingView;
/**
 * 运费
 */
@property (nonatomic, strong)UILabel * shippingLabel;

/**
 * 折扣
 */
@property (nonatomic, strong)UIView * discountView;
/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;

/**
 * 利润
 */
@property (nonatomic, strong)UIView * profitView;
/**
 * 利润
 */
@property (nonatomic, strong)UILabel * profitLabel;

/**
 * 支付价格
 */
@property (nonatomic, strong)UIView * totalView;
/**
 * 支付价格
 */
@property (nonatomic, strong)UILabel * totalLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * continueButton;


@end

@implementation XZZCheckOutPriceButtonView

+ (instancetype)allocInit
{
    XZZCheckOutPriceButtonView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    CGFloat height = 25;
    self.subtotalLabel = [self priceInforTitle:@"Subtotal" textColor:kColor(0x000000) font:textFont(12)];
    self.subtotalView = self.subtotalLabel.superview;
    [self.subtotalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    self.shippingLabel = [self priceInforTitle:@"Shipping" textColor:kColor(0x000000) font:textFont(12)];
    self.shippingView = self.shippingLabel.superview;
    [self.shippingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.subtotalView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    self.discountLabel = [self priceInforTitle:@"Discount" textColor:kColor(0x000000) font:textFont(12)];
    self.discountView = self.discountLabel.superview;
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.shippingView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    self.profitLabel = [self priceInforTitle:@"Profit" textColor:kColor(0x000000) font:textFont(12)];
    self.profitView = self.profitLabel.superview;
    [self.profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.discountView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    
    self.totalLabel = [self priceInforTitle:@"Total" textColor:kColor(0x000000) font:textFont_bold(14)];
    self.totalLabel.font = textFont_bold(14);
    self.totalView = self.totalLabel.superview;
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.profitView.mas_bottom).offset(5);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@40);
    }];
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? bottomHeight : 0;

    UIButton * continueButton = [UIButton allocInitWithTitle:@"CONTINUE" color:kColor(0xffffff) selectedTitle:@"CONTINUE" selectedColor:kColor(0xffffff) font:18];
    [continueButton addTarget:self action:@selector(PlaceOrder) forControlEvents:(UIControlEventTouchUpInside)];
    continueButton.backgroundColor = button_back_color;
    [self addSubview:continueButton];
    self.continueButton = continueButton;
    [continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf.totalView.mas_bottom);
        make.height.equalTo(@46);
        make.bottom.equalTo(wSelf).offset(-buttonBottom);
    }];
    
    
}

- (void)setButtonStr:(NSString *)buttonStr
{
    _buttonStr = buttonStr;
    [self.continueButton setTitle:buttonStr forState:(UIControlStateNormal)];
    [self.continueButton setTitle:buttonStr forState:(UIControlStateSelected)];
}

- (void)PlaceOrder
{
    !self.block?:self.block();
}

- (void)setPriceInfor:(XZZOrderPriceInfor *)priceInfor
{
    _priceInfor = priceInfor;
    
    if (priceInfor.discount <= 0) {
        [self.discountView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.discountView.hidden = YES;
    }else{
        [self.discountView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
        self.discountView.hidden = NO;
    }
    
    if (priceInfor.profit <= 0) {
        [self.profitView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.profitView.hidden = YES;
    }else{
        [self.profitView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
        self.profitView.hidden = NO;
    }
    
    self.discountLabel.text = [NSString stringWithFormat:@"-$%.2f", priceInfor.discount];
    /***  支付金额 */
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.payTotal];
    /***  运费 */
    self.shippingLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.postFeePrice];
    self.profitLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.profit];
    self.subtotalLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.skuTotal];
    
    
    
    
}



- (UILabel *)priceInforTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIView * view = [UIView allocInit];
    [self addSubview:view];
    weakView(weak_view, view)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.text = title;
    titleLabel.font = font;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.bottom.equalTo(weak_view);
    }];
    
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:10 textAlignment:(NSTextAlignmentRight) tag:1];
    priceLabel.font = font;
    [view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_view).offset(-11);
        make.top.bottom.equalTo(weak_view);
    }];
    return priceLabel;
    
}
 


@end

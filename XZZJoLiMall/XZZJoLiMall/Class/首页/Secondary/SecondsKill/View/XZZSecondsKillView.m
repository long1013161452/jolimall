//
//  XZZSecondsKillView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillView.h"


@interface XZZSecondsKillView ()
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;
/**
 * 标题
 */
@property (nonatomic, strong)UILabel * titleLabel;
/**
 * 上下午
 */
@property (nonatomic, strong)UILabel * AMAndPMLabel;
/**
 * 状态
 */
@property (nonatomic, strong)UILabel * stateLabel;

@end


@implementation XZZSecondsKillView


+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZSecondsKillView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (void)addView
{
    WS(wSelf)
    
    self.backView = [UIView allocInit];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf);
        make.top.equalTo(@0);
        make.bottom.equalTo(wSelf);
    }];
    
    self.titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.titleLabel.text = @"8:00";
    self.titleLabel.font = textFont_bold(14);
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(wSelf.backView);
    }];
    
    self.AMAndPMLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:kColor(0xD73E3E) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    [self.AMAndPMLabel cutRounded:8];
    self.AMAndPMLabel.text = @"AM";
    self.AMAndPMLabel.font = textFont_bold(14);
    [self.backView addSubview:self.AMAndPMLabel];
    [self.AMAndPMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.width.equalTo(@36);
        make.left.equalTo(wSelf.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(wSelf.titleLabel);
        make.right.equalTo(wSelf.backView);
    }];
    
    self.stateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.stateLabel.text = @"Ended";
    self.stateLabel.font = textFont_bold(14);
    [self.backView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.titleLabel);
        make.top.equalTo(wSelf.titleLabel.mas_bottom);
        make.centerX.equalTo(wSelf);
    }];
}

- (void)setSecondsKill:(XZZSecondsKillSession *)secondsKill
{
    _secondsKill = secondsKill;
    
    if (secondsKill.status == 2) {
        self.stateLabel.text = @"Ended";
    }else if (secondsKill.status == 3){
        self.stateLabel.text = @"Ending soon";
    }else{
        self.stateLabel.text = @"Next";
    }
    
    NSDate * date = [self conversionDate:secondsKill.startTime];
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [NSDateFormatter allocInit];
    }
    formatter.PMSymbol = @"PM";
    formatter.AMSymbol = @"AM";
    [formatter setDateFormat:@"a"];
    
    self.AMAndPMLabel.text = [formatter stringFromDate:date];
    [formatter setDateFormat:@"hh:mm"];
    self.titleLabel.text = [formatter stringFromDate:date];
    
    
}


- (void)setIndicatorcenterX:(CGFloat)indicatorcenterX
{
    _indicatorcenterX = indicatorcenterX;
    
    
    /** 选中的时候*/
    CGFloat r1 = 255.f;
    CGFloat g1 = 255.f;
    CGFloat b1 = 255.f;
    CGFloat a1 = 1.f;
    
    CGFloat AMPMr1 = 215.f;
    CGFloat AMPMg1 = 62.f;
    CGFloat AMPMb1 = 62.f;
    /** 未选中的时候*/
    CGFloat r2 = 177.f;
    CGFloat g2 = 67.f;
    CGFloat b2 = 67.f;
    CGFloat a2 = 0.5f;
    
    CGFloat AMPMr2 = 220.f;
    CGFloat AMPMg2 = 88.f;
    CGFloat AMPMb2 = 88.f;
    
    /** 滚动的时候*/
    CGFloat r = 0.f;
    CGFloat g = 0.f;
    CGFloat b = 0.f;
    CGFloat a = 0.f;
    
    CGFloat AMPMr = 0.f;
    CGFloat AMPMg = 0.f;
    CGFloat AMPMb = 0.f;
    
    
    CGFloat proportion = 0.f;

    if (self.centerX > indicatorcenterX) {
        proportion = (self.centerX - indicatorcenterX) / self.width;
    }else{
        proportion = (indicatorcenterX - self.centerX) / self.width;
    }
    
    proportion = proportion > 1 ? 1.0 : proportion;
    if (self.state == XZZSecondsKillStateEnd) {
        r = (r2 - r1) * proportion + r1;
        g = (g2 - g1) * proportion + g1;
        b = (b2 - b1) * proportion + b1;
        UIColor * color = kColorWithRGB(r, g, b, 1);
        self.titleLabel.textColor = color;
        self.AMAndPMLabel.backgroundColor = color;
        self.stateLabel.textColor = color;
        
        AMPMr = (AMPMr2 - AMPMr1) * proportion + AMPMr1;
        AMPMg = (AMPMg2 - AMPMg1) * proportion + AMPMg1;
        AMPMb = (AMPMb2 - AMPMb1) * proportion + AMPMb1;
        
        self.AMAndPMLabel.textColor = kColorWithRGB(AMPMr, AMPMg, AMPMb, 1);
        
    }else{
        r = r1;
        g = g1;
        b = b1;
        a = (a2 - a1) * proportion + a1;
        
//        UIColor * color = kColorWithRGB(r, g, b, 1);
        self.titleLabel.alpha = a;
        self.AMAndPMLabel.alpha = a;
        self.stateLabel.alpha = a;
        
        
        
        
    }
    
    
    

    
    
    
    
    
    
    
}












@end

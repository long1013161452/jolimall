//
//  XZZGoodsWhyJolimallView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsWhyJolimallView.h"

@interface XZZGoodsWhyJolimallView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * introductionLabel;



@end

@implementation XZZGoodsWhyJolimallView

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = button_back_color;
    [self addSubview:dividerView];
    
    self.titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x191919) textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.titleLabel.font = textFont_bold(16);
    self.titleLabel.text = @"Why Jolimall";
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@24);
        make.left.equalTo(@16);
        make.height.equalTo(@20);
    }];
    
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.titleLabel);
        make.centerY.equalTo(wSelf.titleLabel).offset(4);
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@2);
    }];

    self.introductionLabel = [UILabel labelWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 0) backColor:nil textColor:kColor(0x666666) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.introductionLabel.numberOfLines = 0;
    [self addSubview:self.introductionLabel];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.titleLabel);
        make.top.equalTo(wSelf.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(wSelf);
    }];
}

- (void)setIntroduction:(NSString *)introduction
{
    _introduction = introduction;
    if (!self.introductionLabel) {
        [self addView];
    }
    

    introduction = [introduction stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    introduction = [introduction stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    introduction = [introduction stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    self.introductionLabel.text = introduction;
    [self.introductionLabel changeTheHeightInputInformation];
    self.height = self.introductionLabel.height + 70;
}



@end

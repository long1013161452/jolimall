//
//  XZZCouponEmptyTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponEmptyTableViewCell.h"

@interface XZZCouponEmptyTableViewCell ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * imageViewTwo;

@end

@implementation XZZCouponEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addView
{
    if (!self.imageViewTwo) {
        self.backgroundColor = [UIColor clearColor];
        WS(wSelf)
        self.imageViewTwo = [UIImageView allocInit];
        self.imageViewTwo.image = imageName(@"coupons_list_empty");
        [self addSubview:self.imageViewTwo];
        [self.imageViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.top.equalTo(@100);
        }];
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:15 textAlignment:(NSTextAlignmentCenter) tag:1];
        label.text = @"It is empty here";
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.imageViewTwo.mas_bottom).offset(20);
            make.centerX.equalTo(wSelf);
        }];
    }
}

@end

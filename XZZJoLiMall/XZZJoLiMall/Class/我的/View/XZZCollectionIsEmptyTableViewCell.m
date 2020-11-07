//
//  XZZCollectionIsEmptyTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCollectionIsEmptyTableViewCell.h"

@implementation XZZCollectionIsEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}


- (void)addView
{
    WS(wSelf)
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    imageView.image = imageName(@"my_Collection_is_empty");
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@55);
        make.centerX.equalTo(wSelf);
    }];
weakView(weak_imageView, imageView)
    UILabel * label = [UILabel allocInit];
    label.text = @"It is empty here";
    label.textColor = kColor(0x505050);
    label.font = textFont(12);
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_imageView);
        make.top.equalTo(weak_imageView.mas_bottom).offset(20);
    }];
}

@end

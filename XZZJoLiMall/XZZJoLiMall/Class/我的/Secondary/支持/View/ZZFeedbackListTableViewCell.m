//
//  ZZFeedbackListTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "ZZFeedbackListTableViewCell.h"


@interface ZZFeedbackListTableViewCell ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * timeLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * contentLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * headerImageView;

@end

@implementation ZZFeedbackListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFeedback:(XZZFeedback *)feedback
{
    _feedback = feedback;
    if (!self.backView) {
        [self addView];
    }
    self.titleLabel.text = feedback.title;
    self.contentLabel.text = feedback.content;
    self.timeLabel.text = [self timeFormat:@"yyyy-MMM-dd HH:mm:ss" conversionDate:feedback.createTime];
}

- (void)addView{
    WS(wSelf)
    self.backView = [UIView allocInit];
    self.backView.backgroundColor = kColor(0xffffff);
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf);
    }];
    
    self.headerImageView = [UIImageView allocInit];
    self.headerImageView.image = imageName(@"my_head_image");
    [self.backView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@20);
        make.width.height.equalTo(@50);
    }];
    
    self.titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.headerImageView.mas_right).offset(20);
        make.top.equalTo(wSelf.headerImageView);
        make.right.equalTo(wSelf.backView).offset(-20);
        make.height.equalTo(@30);
    }];
    
    self.contentLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x323232) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.contentLabel.numberOfLines = 0;
    [self.backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.titleLabel);
        make.top.equalTo(wSelf.titleLabel.mas_bottom);
    }];
    
    
    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentRight) tag:1];
    [self.backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.titleLabel);
        make.top.equalTo(wSelf.contentLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.bottom.equalTo(wSelf.backView);
    }];
}

@end

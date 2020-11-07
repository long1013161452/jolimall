//
//  XZZSetUpListTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/5.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSetUpListTableViewCell.h"


@interface XZZSetUpListTableViewCell ()


/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;


@end

@implementation XZZSetUpListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInforModel:(XZZSetUpInforModel *)inforModel
{
    _inforModel = inforModel;
    
    if (!self.titleLabel) {
        [self addView];
    }
    self.titleLabel.text = inforModel.title;
}

- (void)addView{
    
    WS(wSelf)
    
    self.titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wSelf);
        make.left.equalTo(@11);
    }];
    
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"address_arrow"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-11);
        make.centerY.equalTo(wSelf);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.titleLabel);
        make.bottom.centerX.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    
}





@end

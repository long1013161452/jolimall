//
//  XZZMyTicketsListIsEmptyTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/24.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZMyTicketsListIsEmptyTableViewCell.h"

@implementation XZZMyTicketsListIsEmptyTableViewCell

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




- (void)addView{
   
    self.backgroundColor = BACK_COLOR;
    
    WS(wSelf)
    UIImageView * imageview = [UIImageView allocInit];
    imageview.image = imageName(@"chat_tickets_is_empty");
    [self addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.centerX.equalTo(wSelf);
    }];
    
    weakView(weak_imageview, imageview)
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:15 textAlignment:(NSTextAlignmentCenter) tag:1];
    label.text = @"No recent tickets";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_imageview);
        make.top.equalTo(weak_imageview.mas_bottom).offset(15);
        make.bottom.equalTo(wSelf);
    }];
    
    
}


@end

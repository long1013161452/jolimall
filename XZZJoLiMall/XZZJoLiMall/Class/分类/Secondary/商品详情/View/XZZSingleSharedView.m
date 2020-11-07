//
//  XZZSingleSharedView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/11.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSingleSharedView.h"


@implementation XZZSingleSharedView

+ (instancetype)allocInit
{
    XZZSingleSharedView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    WS(wSelf)
    self.imageView = [UIImageView allocInit];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@25);
        make.width.height.equalTo(@44);
        make.centerX.equalTo(wSelf);
    }];
    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:11 textAlignment:(NSTextAlignmentCenter) tag:1];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.imageView.mas_bottom).offset(15);
        make.centerX.equalTo(wSelf);
    }];
    
}

@end

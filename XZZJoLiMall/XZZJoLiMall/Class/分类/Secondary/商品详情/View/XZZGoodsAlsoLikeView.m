//
//  XZZGoodsAlsoLikeView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/27.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsAlsoLikeView.h"

@implementation XZZGoodsAlsoLikeView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZGoodsAlsoLikeView * view = [super allocInitWithFrame:frame];
    [view addView];
    return view;
}

- (void)addView{
    self.backgroundColor = [UIColor whiteColor];
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(10, dividerView.bottom  + 10, 200, 45) backColor:nil textColor:kColor(0x000000) textFont:16 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.font = textFont_bold(16);
    label.text = @"You Might Also Like";
    [self addSubview:label];
    self.height = label.bottom;
    
}


@end

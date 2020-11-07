//
//  XZZGoodsDetailsYouSaveView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/9/24.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsDetailsYouSaveView.h"

@interface XZZGoodsDetailsYouSaveView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * preferentialLabel;

@end

@implementation XZZGoodsDetailsYouSaveView

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    
   
    self.preferentialLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:button_back_color textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    [self addSubview:self.preferentialLabel];
    [self.preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@10);
        make.height.equalTo(@25);
    }];
    
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.height.equalTo(@8);
    }];
    
    
}

- (void)setPreferential:(NSString *)preferential
{
    if (!self.preferentialLabel) {
        [self addView];
    }
    if (preferential.length <= 0) {
        self.height = 8;
        return;
    }
    _preferential = preferential;
    self.preferentialLabel.text = [NSString stringWithFormat:@"  You Save %@   ", preferential];
    self.height = 60;
}

@end

//
//  XZZGoodsColorView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsColorView.h"

@interface XZZGoodsColorView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIButton * selectedColorButton;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * colorButtonArray;

@end

@implementation XZZGoodsColorView



- (void)setGoods:(XZZGoodsDetails *)goods
{
    _goods = goods;
    [self addView];
}

- (void)addView{
    
    self.backgroundColor = [UIColor whiteColor];
    [self removeAllSubviews];
    UILabel * colorLabel = [UILabel labelWithFrame:CGRectMake(16, 10, 200, 15) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    colorLabel.text = @"Color";
    colorLabel.font = textFont_bold(12);
    [self addSubview:colorLabel];
    
    CGFloat left = colorLabel.left;
    CGFloat top = colorLabel.bottom + 10;
    CGFloat width = 30;
    CGFloat height = 40;
    CGFloat interval = 13;
    CGFloat bottom = colorLabel.bottom;
    NSInteger tag = 0;
    
    NSMutableArray * array = @[].mutableCopy;
    
    for (XZZColor * color in self.goods.colorInforArray) {
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(left, top, width, height)];
        [button addImageFromUrlStr:color.smallMainPicture];
        button.tag = tag;
        [button addTarget:self action:@selector(clickOnChooseColor:) forControlEvents:(UIControlEventTouchUpInside)];
        button.layer.borderColor = kColor(0xff0000).CGColor;
        [self addSubview:button];
        [array addObject:button];
        if (button.right + interval > self.width) {
            button.top += (height + interval);
            button.left = colorLabel.left;
        }
        tag++;
        top = button.top;
        left = button.right + interval;
        bottom = button.bottom + 30;
    }
    self.colorButtonArray = array.copy;
    
    if (self.goods.goods.sizeTypeCodePicture.length > 0) {
        UIButton * sizeGuideButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 60 - 8, bottom - 30, 65, 20)];
        [sizeGuideButton setTitle:@"Size Guide" forState:(UIControlStateNormal)];
        [sizeGuideButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
        sizeGuideButton.titleLabel.font = textFont(12);
        [sizeGuideButton addTarget:self action:@selector(clickOnSizeGuide) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:sizeGuideButton];
        
//        UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(sizeGuideButton.left, sizeGuideButton.bottom - 2, sizeGuideButton.width, .5)];
//        dividerView.backgroundColor = button_back_color;
//        [self addSubview:dividerView];
        
    }
    
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, bottom, ScreenWidth, 8)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    self.height = dividerView.bottom;
    
    !self.refresh?:self.refresh();
    
    
}

- (void)clickOnChooseColor:(UIButton *)button
{
    self.selectedColorButton.layer.borderWidth = 0;
    if ([self.selectedColorButton isEqual:button]) {
        self.selectedColorButton = nil;
        !self.chooseColor?:self.chooseColor(nil);
    }else{
        button.layer.borderWidth = 1;
        self.selectedColorButton = button;
    !self.chooseColor?:self.chooseColor(self.goods.colorInforArray[button.tag]);
    }
}

- (void)clickOnSizeGuide
{
    !self.sizeGuide?:self.sizeGuide();
}


/**
 *  选中颜色
 */
- (void)selectedColorInfor:(XZZColor *)color
{
    if (color) {
        for (int i = 0; i < self.goods.colorInforArray.count; i++) {
            XZZColor * colorTwo = self.goods.colorInforArray[i];
            if ([colorTwo.colorCode isEqualToString:color.colorCode]) {
                if (self.colorButtonArray.count > i) {
                    [self externalCallsModifySelectedState:self.colorButtonArray[i] color:color];
                }
            }
        }
    }else{
        [self externalCallsModifySelectedState:self.selectedColorButton color:color];
    }
}
#pragma mark ----*  外部调用修改选中状态
/**
 *  外部调用修改选中状态
 */
- (void)externalCallsModifySelectedState:(UIButton *)button color:(XZZColor *)color
{
    self.selectedColorButton.layer.borderWidth = 0;
    if (color) {
        button.layer.borderWidth = 1;
        self.selectedColorButton = button;
    }else{
        self.selectedColorButton = nil;
    }
}

@end

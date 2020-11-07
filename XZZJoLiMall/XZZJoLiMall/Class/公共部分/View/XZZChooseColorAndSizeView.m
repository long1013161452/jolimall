//
//  XZZChooseColorAndSizeView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/9.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZChooseColorAndSizeView.h"


@interface XZZChooseColorAndSizeView ()

/**
 * 选中的颜色
 */
@property (nonatomic, strong)XZZColor * selectedColor;
/**
 * 颜色视图数组
 */
@property (nonatomic, strong)NSMutableArray * colorViewArray;
/**
 *  * 选中的颜色视图
 */
@property (nonatomic, strong)UIView * selectedColorView;
/**
 * 颜色c视图背景
 */
@property (nonatomic, weak)UIView * colorBackView;
/**
 * 选中的尺码
 */
@property (nonatomic, strong)XZZSize * selectedSize;
/**
 * 尺码视图数组
 */
@property (nonatomic, strong)NSMutableArray * sizeViewArray;
/**
 *  * 选中的尺码视图
 */
@property (nonatomic, strong)UIButton * selectedSizeView;
/**
 * 尺码视图背景
 */
@property (nonatomic, weak)UIView * sizeBackView;

@end

@implementation XZZChooseColorAndSizeView


- (void)selectedColor:(XZZColor *)color selectedSize:(XZZSize *)size
{
    if (color) {
        for (int i = 0; i < self.colorArray.count; i++) {
            XZZColor * colorTwo = self.colorArray[i];
            if ([colorTwo.colorCode isEqualToString:color.colorCode]) {
                self.selectedColorView = self.colorViewArray[i];
                break;
            }
        }
    }
    if (size) {
        for (int i = 0; i < self.sizeArray.count; i++) {
            XZZSize * sizeTwo = self.sizeArray[i];
            if ([sizeTwo.sizeCode isEqualToString:size.sizeCode]) {
                self.selectedSizeView = self.sizeViewArray[i];
                break;
            }
        }
    }
}

- (void)setColorArray:(NSArray<XZZColor *> *)colorArray
{
    _colorArray = colorArray;
    [self addColorView];
}

- (void)addColorView{
    if (!self.colorBackView) {
        UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        self.colorBackView = backView;
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
    }
    [self.colorBackView removeAllSubviews];
    
    self.colorViewArray = @[].mutableCopy;
    
    UILabel * colorLabel = [UILabel allocInitWithFrame:CGRectMake(8, 0, 100, 20)];
    colorLabel.text = @"COLOR";
    colorLabel.textColor = kColor(0x000000);
    colorLabel.font = textFont(14);
    [self.colorBackView addSubview:colorLabel];
    
    float width = 30 + 5;
    float height = 40 + 5;
    float top = colorLabel.bottom + 10;
    float left = 8;
    float bottom = colorLabel.bottom;
    float interval = 13;
    NSInteger tag = 0;
    for (XZZColor * color in self.colorArray) {
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(left, top, width, height)];
        [button addTarget:self action:@selector(ClickOnColorButton:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = tag;
        [button.imageView addImageFromUrlStr:@""];
        [self.colorBackView addSubview:button];
        
        [self.colorViewArray addObject:button];
        if (button.right + interval > ScreenWidth) {
            button.top += (height + interval);
            button.left = 8;
        }
        tag++;
        top = button.top;
        left = button.right + interval;
        bottom = button.bottom;
    }
    
    self.colorBackView.height = bottom + 15;
    self.sizeBackView.top = self.colorBackView.bottom;
    self.height = self.sizeBackView.bottom + 10;
}

- (void)ClickOnColorButton:(UIButton *)button
{
    self.selectedColorView = button;
}

- (void)setSelectedColorView:(UIView *)selectedColorView
{
    if ([self.selectedColorView isEqual:selectedColorView]) {
        return;
    }
    
}


- (void)setSizeArray:(NSArray<XZZSize *> *)sizeArray
{
    _sizeArray = sizeArray;
    [self addSizeView];
}

- (void)addSizeView{
    if (!self.sizeBackView) {
        UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        self.sizeBackView = backView;
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
    }
    [self.sizeBackView removeAllSubviews];
    
    self.sizeViewArray = @[].mutableCopy;
    
    UILabel * sizeLabel = [UILabel allocInitWithFrame:CGRectMake(15, 15, self.width, 20)];
    sizeLabel.text = @"SIZE";
    sizeLabel.textColor = kColor(0x000000);
    sizeLabel.font = textFont(14);
    [self.sizeBackView addSubview:sizeLabel];
    
    UIButton * sizeGuideButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 60 - 8, sizeLabel.top, 65, 20)];
    [sizeGuideButton setTitle:@"Size Guide" forState:(UIControlStateNormal)];
    [sizeGuideButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    sizeGuideButton.titleLabel.font = textFont(12);
    [sizeGuideButton addTarget:self action:@selector(toViewSizeGuide) forControlEvents:(UIControlEventTouchUpInside)];
    [self.sizeBackView addSubview:sizeGuideButton];
    
//    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(sizeGuideButton.left, sizeGuideButton.bottom - 2, sizeGuideButton.width, .5)];
//    dividerView.backgroundColor = kColor(0x000000);
//    [self.sizeBackView addSubview:dividerView];
    
    float width = 50;
    float height = 33;
    float top = sizeLabel.bottom + 10;
    float left = 8;
    float bottom = sizeLabel.bottom;
    float interval = 13;
    NSInteger tag = 0;
    for (XZZSize * size in self.sizeArray) {
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(left, top, width, height)];
        [button addTarget:self action:@selector(ClickOnSizeButton:) forControlEvents:(UIControlEventTouchUpInside)];

        button.tag = tag;
        [self.sizeBackView addSubview:button];
        [self.sizeViewArray addObject:button];
        if (button.right + interval > ScreenWidth) {
            button.top += (height + interval);
            button.left = 8;
        }
        tag++;
        top = button.top;
        left = button.right + interval;
        bottom = button.bottom;
    }
    
    self.sizeBackView.height = bottom + 15;
    self.sizeBackView.top = self.colorBackView.bottom;
    self.height = self.sizeBackView.bottom + 10;
}

- (void)toViewSizeGuide
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
}

- (void)ClickOnSizeButton:(UIButton *)button{
    NSLog(@"%s %d 行", __func__, __LINE__);
    self.selectedSizeView = button;
}

- (void)setSelectedSizeView:(UIButton *)selectedSizeView
{
    if ([self.selectedSizeView isEqual:selectedSizeView]) {
        return;
    }
    selectedSizeView.selected = YES;
    self.selectedSizeView.selected = NO;
    _selectedSizeView = selectedSizeView;
    self.selectedSize = self.sizeArray[selectedSizeView.tag];
}









@end

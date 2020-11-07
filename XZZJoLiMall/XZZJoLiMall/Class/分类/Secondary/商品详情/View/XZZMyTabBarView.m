//
//  XZZMyTabBarView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/23.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZMyTabBarView.h"

@implementation XZZMyTabBarView

- (void)addView{
    
    self.backgroundColor = kColor(0xffffff);
    WS(wSelf)

    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    
    NSArray * titleArray = @[@"shop", @"category", @"cart", @"me"];
    
    NSArray * image1Array = @[@"tabbar_home", @"tabbar_category", @"tabbar_cart", @"tabbar_me"];
    
    NSArray * image2Array = @[@"tabbar_home_selected", @"tabbar_category_selected", @"tabbar_cart_selected", @"tabbar_me_selected"];
    
    UIColor * color = kColor(0x8D8D8D);
    UIColor * color2 = kColorWithRGB(252, 32, 0, 1);
    
    NSInteger selectedIndex = self.VC.tabBarController.selectedIndex;
    
    UIView * leftView = nil;
    for (int i = 0; i < titleArray.count; i++) {
        UIButton * button = nil;
        if (selectedIndex == i) {
            button = [self title:titleArray[i] titleColor:color2 imageName:image2Array[i] tag:i];
        }else{
            button = [self title:titleArray[i] titleColor:color imageName:image1Array[i] tag:i];
        }
        
        [self addSubview:button];
        weakView(weak_leftView, leftView)
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (weak_leftView) {
                make.left.equalTo(weak_leftView.mas_right);
                make.width.equalTo(weak_leftView);
            }else{
                make.left.equalTo(@0);
            }
            make.top.bottom.equalTo(wSelf);
        }];
        leftView = button;
    }
    
    if (leftView) {
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf);
        }];
    }
    
}

- (UIButton *)title:(NSString *)title titleColor:(UIColor *)color imageName:(NSString *)image tag:(NSInteger)tag
{
    UIButton * button = [UIButton allocInit];
    button.tag = tag;
//    [self addSubview:button];
    
    weakView(weak_button, button)
    UIView * view = [UIView allocInit];
    [button addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weak_button);
        make.height.equalTo(@49);
    }];
    
    
    UIImageView * imageView = [UIImageView allocInit];
    imageView.image = imageName(image);
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_button);
        make.top.equalTo(@9);
    }];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:color textFont:10 textAlignment:(NSTextAlignmentCenter) tag:0];
    label.text = title;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_button);
        make.top.equalTo(@34);
    }];

    return button;
}




@end

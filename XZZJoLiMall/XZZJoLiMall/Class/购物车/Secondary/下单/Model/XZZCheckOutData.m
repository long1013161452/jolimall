//
//  XZZCheckOutData.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/21.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutData.h"

@implementation XZZCheckOutData

- (NSString *)selectedProfit
{
    if (!_selectedProfit) {
        self.selectedProfit = @"1";
    }
    return _selectedProfit;
}

@end

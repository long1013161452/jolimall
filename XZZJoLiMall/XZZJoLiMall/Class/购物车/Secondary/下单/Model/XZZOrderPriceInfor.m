//
//  XZZOrderPriceInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/1.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderPriceInfor.h"

@implementation XZZOrderPriceInfor

- (CGFloat)payTotal
{
    return self.total + self.postFeePrice + self.profit;
}

@end

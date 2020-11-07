//
//  XZZRequestSearch.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/12.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRequestSearch.h"

@implementation XZZRequestSearch

- (NSString *)query
{
    if (!_query) {
        self.query = @"";
    }
    return _query;
}

- (int)orderBy
{
    if (!_orderBy) {
        self.orderBy = 1;
    }
    return _orderBy;
}

@end

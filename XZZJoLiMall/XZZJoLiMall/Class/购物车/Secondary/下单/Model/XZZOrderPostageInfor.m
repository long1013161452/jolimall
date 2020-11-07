//
//  XZZOrderPostageInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/29.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderPostageInfor.h"

@implementation XZZOrderPostageInfor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"desc" : @"description"};
}

- (CGFloat)fee
{
    if (_fee < 0) {
        return 0;
    }
    return _fee;
}

@end

@implementation XZZOrderCalculatePostageInfor



@end

@implementation XZZAllOrderPostageInfor

static XZZAllOrderPostageInfor * allOrderPostageInfor = nil;

+ (XZZAllOrderPostageInfor *)shareAllOrderPostageInfor
{
    static dispatch_once_t oneToken;
    //
    dispatch_once(&oneToken, ^{
        
        allOrderPostageInfor = [self allocInit];
        
    });
                  return allOrderPostageInfor;
}


- (void)getAllPostageInformation:(HttpBlock)httpBlock
{
    [XZZDataDownload orderGetPostageHttpBlock:httpBlock];
}

- (void)getAllPostageInformationWeight:(int)weight goodsNum:(int)goodsNum httpBlock:(HttpBlock)httpBlock
{
    [XZZDataDownload orderGetPostageWeight:weight goodsNum:goodsNum httpBlock:httpBlock];
}


@end

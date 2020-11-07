//
//  XZZSecondsKillSession.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillSession.h"

@implementation XZZSecondsKillSession

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}



@end


@implementation XZZALLSecondsKillSession

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"seckillDetailVoList" : [XZZSecondsKillSession class]};
}

@end

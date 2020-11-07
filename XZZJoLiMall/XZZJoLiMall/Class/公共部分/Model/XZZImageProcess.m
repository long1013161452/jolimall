//
//  XZZImageProcess.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZImageProcess.h"


@implementation XZZImageProcess

+ (instancetype)allocInitUrl:(NSString *)url width:(int)width height:(int)height
{
    XZZImageProcess * imageProcess = [super allocInit];
    
    NSArray *array = [url componentsSeparatedByString:@"/"];
        
    imageProcess.key = [NSString stringWithFormat:@"image/%@", [array lastObject]];
    
    imageProcess.edits = @{@"jpeg" : @{@"quality" : @80},
                           @"png" :  @{@"quality" : @80},
                           @"webp" :  @{@"quality" : @80},
                           @"toFormat" : @"webp",
                           @"resize" : @{@"width" : @(width), @"height" : @(height),@"fit" : @"inside"}
                               };
    
    return imageProcess;
}

- (NSString *)bucket
{
    return @"s3.chellysun.com";
}




@end

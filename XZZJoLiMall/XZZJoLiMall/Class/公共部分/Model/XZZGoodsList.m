//
//  XZZGoodsList.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsList.h"



@implementation XZZGoodsList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"activityVo" : [XZZActivityInfor class]};
}

- (NSString *)status
{
    if (!_status) {
        _status = @"1";
    }
    if (_status.boolValue && (self.isExistStock.length == 0 || self.isExistStock.boolValue)) {
        _status = @"1";
    }else{
        _status = @"0";
    }
    return _status;
}


- (NSString *)pictureUrl
{
    
    
    
    
//    
//    
//    // Image_prefix 是   http://b2cci.zbycorp.com:8081/b2c-dev-s3/
//    // Image_New_prefix  https://n2n05n6wq1.execute-api.cn-northwest-1.amazonaws.com.cn/dev/fit-in/
//    if (![_pictureUrl hasPrefix:Image_New_prefix]) {//判断是否是直接返回的前缀开头  Image_prefix 是
//        
//        NSString * imageprefixNew = [NSString stringWithFormat:@"%@%.0fx%.0f/", Image_New_prefix, (ScreenWidth / 2.0 * 3), (ScreenWidth / 2.0 * 4)];//  字符串拼接 Image_New_prefix 是新的前缀，不包含大小   ScreenWidth屏幕宽度   拼出来https://n2n05n6wq1.execute-api.cn-northwest-1.amazonaws.com.cn/dev/fit-in/600x800/   这种格式的
//        self.pictureUrl = [_pictureUrl stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];//字符串替换，把Image_prefix替换成imageprefixNew
//        
//    }
    return _pictureUrl;
}




@end

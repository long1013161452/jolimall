//
//  ZDCChatEvent+XZZChatEvent.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "ZDCChatEvent+XZZChatEvent.h"

#import <objc/runtime.h>



static NSString * imageUrlKey = @"imageUrlKey";

static NSString * imageKey = @"imageKey";

@implementation ZDCChatEvent (XZZChatEvent)





//
//- (void)setImaegUrl:(NSString *)imaegUrl
//{
//    objc_setAssociatedObject(self, &imageUrlKey, imageKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSString *)imaegUrl
//{
//    return objc_getAssociatedObject(self, &imageUrlKey);
//}
//
- (void)setImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &imageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)image
{
    return objc_getAssociatedObject(self, &imageKey);
}






@end

//
//  CHKeychain.h
//  测试缓存
//
//  Created by 龙少 on 2018/12/11.
//  Copyright © 2018年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CHKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service class:(Class)Myclass;

@end



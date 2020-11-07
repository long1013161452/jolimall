//
//  XZZNetWork.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSA.h"




/**
 *  网络请求
 */
@interface XZZNetWork : NSObject



/**
 * get请求
 * urlStr       请求链接
 * parameters   请求参数
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调
 */
+ (void)GET:(NSString *)urlStr
 parameters:(NSDictionary *)parameters
    success:(void(^)(id data))success
    failure:(void(^)(NSError * error))failure;


/**
 * post请求
 * urlStr       请求链接
 * parameters   请求参数
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调
 */
+ (void)POST:(NSString *)urlStr
  parameters:(id)parameters
     success:(void(^)(id data))success
     failure:(void(^)(NSError * error))failure;


/**
 * post请求  表单提交
 * urlStr       请求链接
 * parameters   请求参数
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调
 */
+ (void)POSTFORM:(NSString *)urlStr
  parameters:(id)parameters
     success:(void(^)(id data))success
     failure:(void(^)(NSError * error))failure;


/**
 *  上传图片
 *  urlStr      url链接
 *  imageArray  图片信息
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调 */
+ (void)uploadUrl:(NSString *)urlStr
           images:(NSArray *)imageArray
          success:(void(^)(id data))success
          failure:(void(^)(NSError * error))failure;
/**
 * 加密 post请求
 * urlStr       请求链接
 * parameters   请求参数
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调
 */
+ (void)encryptionPOST:(NSString *)urlStr
            parameters:(id)parameters
               success:(void(^)(id data))success
               failure:(void(^)(NSError * error))failure;

@end



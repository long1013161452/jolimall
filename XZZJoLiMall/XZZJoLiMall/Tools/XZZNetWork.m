//
//  XZZNetWork.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZNetWork.h"

@implementation XZZNetWork

+ (void)GET:(NSString *)urlStr
 parameters:(NSDictionary *)parameters
    success:(void(^)(id data))success
    failure:(void(^)(NSError * error))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 设置允许请求的类别
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    
    // 设置header
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString * authorization = ((AppDelegate *)[UIApplication sharedApplication].delegate).authorization;
    [manager.requestSerializer setValue:User_Infor.access_token.length > 0 ? User_Infor.access_token : authorization forHTTPHeaderField:@"Authorization"];

    
    [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@  %@", urlStr, responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if ([responseObject[@"code"] integerValue] == 401) {
                    [User_Infor loggedOut];
                    logInVC(nil);
                }
            }
            success(responseObject);
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@  %@", urlStr, error);
            failure(error);
        });
    }];
    
}

+ (void)POST:(NSString *)urlStr
  parameters:(id)parameters
     success:(void(^)(id data))success
     failure:(void(^)(NSError * error))failure
{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    // 设置允许请求的类别
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    

    NSError *requestError = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:parameters error:&requestError];
    
    // 设置header
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString * authorization = ((AppDelegate *)[UIApplication sharedApplication].delegate).authorization;
    [request setValue:User_Infor.access_token.length > 0 ?  User_Infor.access_token : authorization forHTTPHeaderField:@"authorization"];
    NSLog(@"%@", User_Infor.access_token );
    if (parameters) {
        //    // body
        NSData *postData= [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:postData];
    }
    
    NSURLSessionDataTask *dataTask = [manager.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        NSDictionary *fields= [(NSHTTPURLResponse *)response allHeaderFields];
        NSArray *cookies=[NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:urlStr]];
        NSDictionary* requestFields=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        
        if (error) { // failed
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@  %@", urlStr, error);
                failure(error);
            });
        }
        else
        {
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@   %@", urlStr, responseObject);
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject[@"code"] integerValue] == 401) {
                        [User_Infor loggedOut];
                        logInVC(nil);
                    }
                }
                success(responseObject);
                
            });
            
        }
        
    }];
    
    [dataTask resume];
    
}

+ (void)POSTFORM:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    // 设置允许请求的类别
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", @"application/x-www-form-urlencoded", nil];
    // 设置header
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSError *requestError = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:parameters error:&requestError];
    

    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString * authorization = ((AppDelegate *)[UIApplication sharedApplication].delegate).authorization;
    [request setValue:User_Infor.access_token.length > 0 ?  User_Infor.access_token : authorization forHTTPHeaderField:@"authorization"];
    NSLog(@"%@", User_Infor.access_token );
    if (parameters) {
        NSString * str = @"";
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            for (NSString * key in parameters) {
                str = [NSString stringWithFormat:@"%@%@%@=%@", str, str.length ? @"&" : @"", key, parameters[key]];
            }
        }
        [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    NSURLSessionDataTask *dataTask = [manager.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        NSDictionary *fields= [(NSHTTPURLResponse *)response allHeaderFields];
        NSArray *cookies=[NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:urlStr]];
        NSDictionary* requestFields=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        
        
        if (error) { // failed
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@  %@", urlStr, error);
                failure(error);
            });
        }else{
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", responseObject);
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject[@"code"] integerValue] == 401) {
                        [User_Infor loggedOut];
                        logInVC(nil);
                    }
                }
                success(responseObject);
            });
        }
    }];
    
    [dataTask resume];
}

/**
 *  上传图片
 *  urlStr      url链接
 *  imageArray  图片信息
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调 */
+ (void)uploadUrl:(NSString *)urlStr
           images:(NSArray *)imageArray
          success:(void(^)(id data))success
          failure:(void(^)(NSError * error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"accept"];
    NSString * authorization = ((AppDelegate *)([UIApplication sharedApplication].delegate)).authorization;
    [manager.requestSerializer setValue:User_Infor.access_token.length > 0 ?  User_Infor.access_token : authorization forHTTPHeaderField:@"authorization"];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < imageArray.count; i++) {
            NSData *imageData = nil;
            if ([imageArray[i] isKindOfClass:[NSData class]]) {
                imageData = imageArray[i];

            }else{
                UIImage *image = imageArray[i];
                imageData = UIImageJPEGRepresentation(image, 1);
            }
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError * error;
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", responseObject);
            success(responseObject);
        });
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@  %@", urlStr, error);
            failure(error);
        });

    }];
}

/**
 * 加密 post请求
 * urlStr       请求链接
 * parameters   请求参数
 * success      请求成功之后的block回调
 * failure      请求失败之后的block回调
 */
+ (void)encryptionPOST:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure
{
    
    //1、获取一个全局串行队列
    dispatch_queue_t queueorder = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2、把任务添加到队列中执行
    dispatch_async(queueorder, ^{
        
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:key_pk]];
        NSString * encryption  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
        // 设置允许请求的类别
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
        
        
        //    manager.requestSerializer.timeoutInterval = 30;
        
        // request
        NSError *requestError = nil;
        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:parameters error:&requestError];
        
        // 设置header
        //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:User_Infor.access_token.length > 0 ?  User_Infor.access_token : @"Basic am9saW1hbGw6cG9ydGFs" forHTTPHeaderField:@"authorization"];

        if (encryption.length) {
            if (parameters) {
                
                NSData *postData= [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
                
                NSString * str = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
                
                NSString * key = [RSA randomString:16];
                NSString * vi = [RSA randomString:16];
                
                NSString * ecbStr = [[ECB sharedEncryptionTools] encryptString:str keyString:key iv:vi];
                NSLog(@"加密: %@",ecbStr);
                NSLog(@"解密: %@",[[ECB sharedEncryptionTools] decryptString:ecbStr keyString:key iv:vi]);
                
                str = ecbStr;
                
                key = [RSA encryptString:key publicKey:encryption];
                vi = [RSA encryptString:vi publicKey:encryption];
                
                postData =[str dataUsingEncoding:NSUTF8StringEncoding];
                
                [request setValue:key forHTTPHeaderField:@"key"];
                [request setValue:vi forHTTPHeaderField:@"vi"];
                
                [request setHTTPBody:postData];
            }
        }else{
            
            if (parameters) {
                //    // body
                NSData *postData= [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
                [request setHTTPBody:postData];
            }
        }
        
        
        NSURLSessionDataTask *dataTask = [manager.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            
            NSDictionary *fields= [(NSHTTPURLResponse *)response allHeaderFields];
            NSArray *cookies=[NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:urlStr]];
            NSDictionary* requestFields=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
            
            if (requestFields[@"Cookie"]) {
                NSString * Cookie = requestFields[@"Cookie"];
                if ([Cookie hasPrefix:@"token="]) {
                    User_Infor.token = [Cookie stringByReplacingOccurrencesOfString:@"token=" withString:@""];
                }
            }
            
            if (error) { // failed
                NSLog(@"\n请求失败：%@", error);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    failure(error);
                });
            }
            else
            {
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    success(responseObject);
                    
                });
                
            }
            
        }];
        
        [dataTask resume];
        
    });
}




@end


//
//  XZZLocalPushRecord.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZLocalPushRecord.h"

@interface XZZLocalPushRecord ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSMutableDictionary * pushDic;


/**
 * <#expression#>
 */
@property (nonatomic, strong)dispatch_source_t timer;


@end


/**
 * 推送场次
 */
@implementation XZZLocalPushRecord

- (NSMutableDictionary *)pushDic
{
    if (!_pushDic) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        weakObjc(weak_dic, dic)
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            for (UNNotificationRequest *req in requests){
                [weak_dic setValue:req forKey:req.identifier];
            }
        }];
        self.pushDic = dic;
    }
    return _pushDic;
}


+ (XZZLocalPushRecord *)shareLocalPushRecord
{
    static XZZLocalPushRecord * record = nil;
    static dispatch_once_t t ;
    dispatch_once(&t, ^{
        record = [self allocInit];
        record.nowTime = [[NSDate date] timeIntervalSince1970];
//        [record startCountdown];
    });
    
    return record;
}

- (BOOL)isPushSessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId
{
    NSString * key = [self keySessionsId:sessionsId goodsID:goodsId];
    id value = self.pushDic[key];
    return value;
}

- (void)addPushSessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId
{
    NSString * key = [self keySessionsId:sessionsId goodsID:goodsId];
    [self.pushDic setValue:@"push" forKey:key];
}

- (void)deletePushSessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId
{
    NSString * key = [self keySessionsId:sessionsId goodsID:goodsId];
    [self.pushDic removeObjectForKey:key];
}

- (NSString *)keySessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId
{
    return [NSString stringWithFormat:@"%@-%@", sessionsId, goodsId];
}

- (void)getPushIdInformation
{
    [self.pushDic removeAllObjects];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    weakObjc(weak_dic, dic)
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        NSLog(@"~~~~~~~%@", requests);
        for (UNNotificationRequest *req in requests){
            [weak_dic setValue:req forKey:req.identifier];
            NSLog(@"~~~~%@", dic);
        }
        [self.pushDic setDictionary:weak_dic];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PushRecord_getPushIds" object:nil];

    }];

}

#pragma mark ----*  开始倒计时
/**
 *  开始倒计时
 */
- (void)startCountdown
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    WS(wSelf)
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        wSelf.nowTime++;
    });
    dispatch_resume(_timer);
}



@end

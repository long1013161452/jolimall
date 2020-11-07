//
//  XZZLocalPushRecord.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define PushRecord_isPush(sessionsId, goodsId) [[XZZLocalPushRecord shareLocalPushRecord] isPushSessionsId:sessionsId goodsID:goodsId]

#define PushRecord_addPush(sessionsId, goodsId) [[XZZLocalPushRecord shareLocalPushRecord] addPushSessionsId:sessionsId goodsID:goodsId]

#define PushRecord_deletePush(sessionsId, goodsId) [[XZZLocalPushRecord shareLocalPushRecord] deletePushSessionsId:sessionsId goodsID:goodsId]

#define PushRecord_keyPush(sessionsId, goodsId) [[XZZLocalPushRecord shareLocalPushRecord] keySessionsId:sessionsId goodsID:goodsId]


#define PushRecord_getPushIds [[XZZLocalPushRecord shareLocalPushRecord] getPushIdInformation]

@interface XZZLocalPushRecord : NSObject


+ (XZZLocalPushRecord *)shareLocalPushRecord;

- (BOOL)isPushSessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId;

- (void)addPushSessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId;

- (void)deletePushSessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId;


- (NSString *)keySessionsId:(NSString *)sessionsId goodsID:(NSString *)goodsId;

- (void)getPushIdInformation;


/**
 * 单位是秒
 */
@property (nonatomic, assign)NSInteger nowTime;

@end


NS_ASSUME_NONNULL_END

//
//  XZZBasicInformation.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/5/15.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZBasicInformation.h"

@implementation XZZBasicInformation

static XZZBasicInformation * basicInfor = nil;
/**
 *  单利
 */
+ (XZZBasicInformation *)sharedBasicInformation
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        basicInfor = [[XZZBasicInformation alloc]init];
        
    });
    return basicInfor;
}

- (NSString *)detailsPageInfo1Title
{
    if (!_detailsPageInfo1Title) {
        self.detailsPageInfo1Title = @"";
    }
    return _detailsPageInfo1Title;
}

- (NSString *)detailsPageInfo1Desc
{
    if (!_detailsPageInfo1Desc) {
        self.detailsPageInfo1Desc = @"";
    }
    return _detailsPageInfo1Desc;
}

- (NSString *)detailsPageInfo2Title
{
    if (!_detailsPageInfo2Title) {
        self.detailsPageInfo2Title = @"";
    }
    return _detailsPageInfo2Title;
}

- (NSString *)detailsPageInfo2Desc
{
    if (!_detailsPageInfo2Desc) {
        self.detailsPageInfo2Desc = @"";
    }
    return _detailsPageInfo2Desc;
}




@end

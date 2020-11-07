//
//  XZZCreateCellInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZChatTableViewCell.h"
#import "XZZRepairOrderDetailsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZZCreateCellInfor : NSObject

+ (UITableViewCell *)createChatCellInfor:(ZDCChatEvent *)event tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id<XZZMyDelegate>)delegate;


+ (UITableViewCell *)createRepairOrderDetailsCell:(ZDKCommentWithUser *)commentUser tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id<XZZMyDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END

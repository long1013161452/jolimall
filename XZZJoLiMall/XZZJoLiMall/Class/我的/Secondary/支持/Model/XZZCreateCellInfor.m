//
//  XZZCreateCellInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCreateCellInfor.h"

@implementation XZZCreateCellInfor


+ (UITableViewCell *)createChatCellInfor:(ZDCChatEvent *)event tableView:(UITableView *)tableView indexPath:(nonnull NSIndexPath *)indexPath delegate:(nonnull id<XZZMyDelegate>)delegate
{
    XZZChatTableViewCell * cell = nil;
    switch (event.type) {
        case ZDCChatEventTypeVisitorMessage:{//自己发出的消息
            cell = [XZZChatMyMessageTableViewCell codeCellWithTableView:tableView];
        }
            break;
        case ZDCChatEventTypeVisitorUpload:{//自己发出的图片
            cell = [XZZChatMyImageMessageTableViewCell codeCellWithTableView:tableView];
        }
            break;
        case ZDCChatEventTypeAgentMessage:{//服务器消息
            cell = [XZZChatServerMessageTableViewCell codeCellWithTableView:tableView];
        }
            break;
        case ZDCChatEventTypeAgentUpload:{//服务器的图片消息
            cell = [XZZChatServerImageMessageTableViewCell codeCellWithTableView:tableView];
        }
            break;
//        case ZDCChatEventTypeRating:{//对聊天进行评价
//            cell = [XZZChatRatingMessageTableViewCell codeCellWithTableView:tableView];
//        }
//            break;
            
        case ZDCChatEventTypeRatingComment:{//对聊天进行评价  已经评价
            cell = [XZZChatRatingMessageTableViewCell codeCellWithTableView:tableView];
        }
            break;
            
            
        default:{
            cell = [XZZChatMessageTableViewCell codeCellWithTableView:tableView];
        }
            break;
    }
    cell.event = event;
    cell.delegate = delegate;
    cell.indexPath = indexPath;
    cell.backgroundColor = kColorWithRGB(0, 0, 0, 0);
    return cell;
}


+ (UITableViewCell *)createRepairOrderDetailsCell:(ZDKCommentWithUser *)commentUser tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id<XZZMyDelegate>)delegate
{
    XZZRepairOrderDetailsTableViewCell * cell = nil;
    
    if (commentUser.user.isAgent) {
        cell = [XZZServerRepairOrderDetailsTableViewCell codeCellWithTableView:tableView];
    }else{
        cell = [XZZMyRepairOrderDetailsTableViewCell codeCellWithTableView:tableView];
    }
    cell.delegate = delegate;
    cell.commentWithUser = commentUser;
    cell.backgroundColor = kColorWithRGB(0, 0, 0, 0);
    return cell;
}


@end

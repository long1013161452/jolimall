//
//  XZZAddressEditorView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZAddressEditorView : UIView

/**
 * 标题
 */
@property (nonatomic, strong)NSString * title;

/**
 * 输入框
 */
@property (nonatomic, strong)UITextField * textField;

/**
 * 编辑
 */
@property (nonatomic, assign)BOOL input;

/**
 *  输入内容缺失
 */
- (void)inputUnfilledContent;

- (void)textFieldDidChange:(id) sender;

@end

NS_ASSUME_NONNULL_END

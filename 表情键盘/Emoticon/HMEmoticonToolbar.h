//
//  HMEmoticonToolbar.h
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 表情工具栏按钮类型
typedef enum : NSUInteger {
    HMEmoticonToolbarRecent,
    HMEmoticonToolbarNormal,
    HMEmoticonToolbarEmoji,
    HMEmoticonToolbarLangXiaohua,
} HMEmoticonToolbarType;

@protocol HMEmoticonToolbarDelegate;

@interface HMEmoticonToolbar : UIView
@property (nonatomic, weak, nullable) id<HMEmoticonToolbarDelegate> delegate;
@end

@protocol HMEmoticonToolbarDelegate <NSObject>

/// 表情工具栏选中分组
///
/// @param section 分组
- (void)emoticonToolbarDidSelectSection:(NSInteger)section;

@end

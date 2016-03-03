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

@interface HMEmoticonToolbar : UIView

@end

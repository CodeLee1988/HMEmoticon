//
//  HMEmoticonInputView.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonInputView.h"
#import "HMEmoticonToolbar.h"
#import "UIImage+HMEmoticon.h"

@implementation HMEmoticonInputView

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)prepareUI {
    // 1. 设置尺寸
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 258;
    self.frame = rect;

    // 2. 基本属性设置
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage hm_imageNamed:@"emoticon_keyboard_background"]];
    
    // 3. 添加工具栏
    HMEmoticonToolbar *toolbar = [[HMEmoticonToolbar alloc] init];
    [self addSubview:toolbar];
    
    // 设置工具栏位置
    CGRect toolBarRect = self.bounds;
    toolBarRect.origin.y = toolBarRect.size.height - 42;
    toolBarRect.size.height = 42;
    toolbar.frame = toolBarRect;
}

@end

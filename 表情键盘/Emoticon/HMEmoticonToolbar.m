//
//  HMEmoticonToolbar.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonToolbar.h"
#import "UIImage+HMEmoticon.h"
#import "HMEmoticonManager.h"

/// 按钮 tag 起始数值
static NSInteger kEmoticonToolbarTagBaseValue = 1000;

@implementation HMEmoticonToolbar

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 计算分组按钮位置
    CGRect rect = self.bounds;
    CGFloat w = rect.size.width / self.subviews.count;
    rect.size.width = w;
    
    int index = 0;
    for (UIView *v in self.subviews) {
        v.frame = CGRectOffset(rect, index++ * w, 0);
    }
}

#pragma mark - 监听方法
/// 点击工具栏按钮
- (void)clickToolbarButton:(UIButton *)button {
    [self.delegate emoticonToolbarDidSelectSection:button.tag - kEmoticonToolbarTagBaseValue];
}

#pragma mark - 设置界面
- (void)prepareUI {
    
    NSArray *packages = [HMEmoticonManager sharedManager].packages;
    
    // 创建按钮
    NSInteger index = 0;
    for (HMEmoticonPackage *package in packages) {
        [self addChildButton:package.groupName bgImageName:package.bgImageName type:index++];
    }
}

- (void)addChildButton:(NSString *)title bgImageName:(NSString *)bgImageName type:(HMEmoticonToolbarType)type {
    UIButton *btn = [[UIButton alloc] init];
    
    btn.tag = type + kEmoticonToolbarTagBaseValue;
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    
    NSString *imageName = [NSString stringWithFormat:@"compose_emotion_table_%@_normal", bgImageName];
    NSString *imageNameSL = [NSString stringWithFormat:@"compose_emotion_table_%@_selected", bgImageName];
    
    [btn setBackgroundImage:[[UIImage hm_imageNamed:imageName] hm_resizableImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage hm_imageNamed:imageNameSL] hm_resizableImage] forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(clickToolbarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

@end

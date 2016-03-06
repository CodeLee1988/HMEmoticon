//
//  HMEmoticonCell.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonCell.h"
#import "HMEmoticon.h"
#import "UIImage+HMEmoticon.h"
#import "HMEmoticonTipView.h"
#import "HMEmoticonButton.h"

@implementation HMEmoticonCell {
    HMEmoticonTipView *_tipView;
}

#pragma mark - 设置数据
- (void)setEmoticons:(NSArray<HMEmoticon *> *)emoticons {
    _emoticons = emoticons;
    
    for (UIView *v in self.contentView.subviews) {
        v.hidden = YES;
    }
    self.contentView.subviews.lastObject.hidden = NO;
    
    NSInteger index = 0;
    for (HMEmoticon *e in _emoticons) {
        HMEmoticonButton *btn = self.contentView.subviews[index++];
        
        btn.emoticon = e;
    }
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        
        // 添加手势监听
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(longPressed:)];
        
        longPressGesture.minimumPressDuration = 0.1;
        
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

#pragma mark - 监听方法
- (void)longPressed:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self];
    
    // 查找选中按钮
    HMEmoticonButton *button = nil;
    for (HMEmoticonButton *btn in self.contentView.subviews) {
        if (CGRectContainsPoint(btn.frame, location) && !btn.hidden) {
            button = btn;
            break;
        }
    }
    if (button == nil) {
        [_tipView removeFromSuperview];
        
        return;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            if (button != self.contentView.subviews.lastObject) {
                [self.window addSubview:_tipView];
            }
        case UIGestureRecognizerStateChanged: {
            CGPoint buttonCenter = [self.contentView convertPoint:button.center toView:self.window];
            
            //修改描点后 直接将TipView的中心点设置为和点击到的表情按钮中心店相同就可以实现 视图和按钮图像底部的对齐
            /*// 将中心点 y 值向上移动 (tipView高度 - 按钮图像视图高度) * 0.5; 使得提示视图刚好和按钮图像底部对齐
            buttonCenter.y -= (_tipView.bounds.size.height - button.imageView.bounds.size.height) * 0.5;*/
            
            
            _tipView.center = buttonCenter;
            _tipView.emoticon = button.emoticon;
        }
            break;
        case UIGestureRecognizerStateEnded:
            [self clickEmoticonButton:button];
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [_tipView removeFromSuperview];
            break;
        default:
            break;
    }
}

- (void)clickEmoticonButton:(HMEmoticonButton *)button {
    [self.delegate emoticonCellDidSelectedEmoticon:button.emoticon isRemoved:button.isDeleteButton];
}

#pragma mark - 设置界面
- (void)prepareUI {
    NSInteger rowCount = 3;
    NSInteger colCount = 7;
    
    CGFloat leftMargin = 8;
    CGFloat bottomMargin = 16;
    
    CGFloat w = ceil((self.bounds.size.width - 2 * leftMargin) / colCount);
    CGFloat h = ceil((self.bounds.size.height - bottomMargin) / rowCount);
    
    for (NSInteger i = 0; i < 21; i++) {
        NSInteger col = i % colCount;
        NSInteger row = i / colCount;
        
        CGRect rect = CGRectMake(col * w + leftMargin, row * h, w, h);
        UIButton *button = [HMEmoticonButton emoticonButtonWithFrame:rect tag:i];
        
        [self.contentView addSubview:button];
        
        [button addTarget:self
                   action:@selector(clickEmoticonButton:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 删除按钮
    ((HMEmoticonButton *)self.contentView.subviews.lastObject).deleteButton = YES;
    
    // 提示视图
    _tipView = [[HMEmoticonTipView alloc] init];
}

@end

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

@implementation HMEmoticonCell

#pragma mark - 设置数据
- (void)setEmoticons:(NSArray<HMEmoticon *> *)emoticons {
    _emoticons = emoticons;
    
    for (UIView *v in self.contentView.subviews) {
        v.hidden = YES;
    }
    
    NSInteger index = 0;
    for (HMEmoticon *e in _emoticons) {
        UIButton *btn = (UIButton *)self.contentView.subviews[index++];
        
        [btn setImage:[UIImage hm_imageNamed:e.imagePath] forState:UIControlStateNormal];
        [btn setTitle:e.emoji forState:UIControlStateNormal];
        
        btn.hidden = NO;
    }
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - 监听方法
- (void)clickEmoticonButton:(UIButton *)button {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 设置界面
- (void)prepareUI {
    NSInteger rowCount = 3;
    NSInteger colCount = 7;
    
    CGFloat leftMargin = 8;
    CGFloat bottomMargin = 16;
    
    CGFloat w = ceil((self.bounds.size.width - 2 * leftMargin) / colCount);
    CGFloat h = ceil((self.bounds.size.height - bottomMargin) / rowCount);
    
    for (NSInteger row = 0; row < rowCount; row++) {
        for (NSInteger col = 0; col < colCount; col++) {
            CGRect rect = CGRectMake(col * w + leftMargin, row * h, w, h);
            
            UIButton *button = [[UIButton alloc] initWithFrame:rect];
                        
            [self.contentView addSubview:button];
            
            [button addTarget:self
                       action:@selector(clickEmoticonButton:)
             forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

@end

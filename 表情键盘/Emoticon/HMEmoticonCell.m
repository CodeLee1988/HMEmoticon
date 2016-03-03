//
//  HMEmoticonCell.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonCell.h"

@implementation HMEmoticonCell

#pragma mark - 设置数据
- (void)setEmoticons:(NSArray<HMEmoticon *> *)emoticons {
    _emoticons = emoticons;
    
    NSLog(@"%@", emoticons);
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
            
            [button setTitle:@"1" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]];
            
            [self.contentView addSubview:button];
            
            [button addTarget:self
                       action:@selector(clickEmoticonButton:)
             forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

@end

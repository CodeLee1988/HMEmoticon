//
//  HMEmoticonTipView.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/5.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonTipView.h"
#import "UIImage+HMEmoticon.h"

@implementation HMEmoticonTipView {
    UIButton *_tipButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithImage:[UIImage hm_imageNamed:@"emoticon_keyboard_magnifier"]];
    if (self) {

        _tipButton = [[UIButton alloc] init];
        _tipButton.backgroundColor = [UIColor redColor];
        [self addSubview:_tipButton];
        
        // 计算按钮大小
        CGFloat width = 32;
        CGFloat x = (self.bounds.size.width - width) * 0.5;
        
        _tipButton.frame = CGRectMake(x, 8, width, width);
    }
    return self;
}

@end

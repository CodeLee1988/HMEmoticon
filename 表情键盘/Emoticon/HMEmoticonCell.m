//
//  HMEmoticonCell.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonCell.h"

@implementation HMEmoticonCell

- (void)setEmoticons:(NSArray<HMEmoticon *> *)emoticons {
    _emoticons = emoticons;
    
    NSLog(@"%@", emoticons);
}

@end

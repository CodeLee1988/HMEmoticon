//
//  HMEmoticonCell.h
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticon;

/// 表情页 Cell，每个表情包含 20 个表情 + 1 个删除按钮
@interface HMEmoticonCell : UICollectionViewCell

/// 表情数组
@property (nonatomic, nonnull) NSArray <HMEmoticon *> *emoticons;

@end

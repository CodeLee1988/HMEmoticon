//
//  HMEmoticonManager.h
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMEmoticonPackage.h"

/// 表情工具类 - 提供表情视图的所有数据及处理逻辑
@interface HMEmoticonManager : NSObject

/// 表情管理器单例
+ (nonnull instancetype)sharedManager;

/// 返回 section 对应的表情包中包含表情页数
///
/// @param section 表情分组下标
///
/// @return 对应页数
- (NSInteger)numberOfPagesInSection:(NSInteger)section;

/// 表情包数组
@property (nonatomic, nonnull) NSMutableArray <HMEmoticonPackage *>*packages;

@end

//
//  HMEmoticonManager.h
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 表情工具类 - 提供表情视图的所有数据及处理逻辑
@interface HMEmoticonManager : NSObject

/// 表情管理器单例
+ (nonnull instancetype)sharedManager;

/// 表情包数组
@property (nonatomic, nonnull) NSMutableArray *packages;

@end

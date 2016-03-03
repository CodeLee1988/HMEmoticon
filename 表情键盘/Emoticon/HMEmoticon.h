//
//  HMEmoticon.h
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 表情模型
@interface HMEmoticon : NSObject

/// 表情类型 0 图片/1 emoji
@property (nonatomic, assign) NSInteger type;
/// 表情描述文字
@property (nonatomic, copy, nonnull) NSString *chs;
/// 表情图片
@property (nonatomic, copy, nonnull) NSString *png;
/// emoji 编码
@property (nonatomic, copy, nonnull) NSString *code;
/// emoji 字符串
@property (nonatomic, copy, nonnull) NSString *emoji;
/// 使用次数
@property (nonatomic, assign) NSInteger times;

+ (nonnull instancetype)emoticonWithDict:(NSDictionary * _Nonnull)dict;

@end

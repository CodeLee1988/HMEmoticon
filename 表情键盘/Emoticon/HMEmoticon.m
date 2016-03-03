//
//  HMEmoticon.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticon.h"

@implementation HMEmoticon

#pragma mark - 构造函数
+ (instancetype)emoticonWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    NSArray *keys = @[@"type", @"chs", @"dir", @"png", @"code", @"times"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end

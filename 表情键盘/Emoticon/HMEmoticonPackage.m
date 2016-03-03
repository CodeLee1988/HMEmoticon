//
//  HMEmoticonPackage.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonPackage.h"
#import "HMEmoticon.h"

@implementation HMEmoticonPackage

#pragma mark - 构造函数
+ (instancetype)packageWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
        // 创建表情数组
        _emoticonsList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description {
    NSArray *keys = @[@"groupName", @"directory", @"emoticonsList"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end

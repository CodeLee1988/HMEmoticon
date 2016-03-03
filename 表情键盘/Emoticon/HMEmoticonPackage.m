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
+ (instancetype)emoticonPackageWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        _groupName = dict[@"group_name_cn"];
        
        // 创建表情数组
        _emoticonsList = [[NSMutableArray alloc] init];
        
        NSArray *array = dict[@"emoticons"];
        // 遍历字典生成完整的表情数组
        for (NSDictionary *dict in array) {
            HMEmoticon *em = [HMEmoticon emoticonWithDict:dict];
            
            [_emoticonsList addObject:em];
        }
    }
    return self;
}

- (NSString *)description {
    NSArray *keys = @[@"groupName", @"emoticonsList"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end

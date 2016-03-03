//
//  HMEmoticon.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticon.h"
#import "NSBundle+HMEmoticon.h"

@implementation HMEmoticon

#pragma mark - 计算型属性 
- (NSString *)imagePath {
    
    if (_type == 1) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@/%@", _directory, _png];
}

#pragma mark - 构造函数
+ (instancetype)emoticonWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSString *)description {
    NSArray *keys = @[@"type", @"chs", @"png", @"directory", @"imagePath", @"code"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end

//
//  HMEmoticonManager.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonManager.h"
#import "NSBundle+HMEmoticon.h"

// 每页显示的表情数量
static NSInteger kEmoticonsCountOfPage = 20;

@implementation HMEmoticonManager

#pragma mark - 单例 & 构造函数
+ (instancetype)sharedManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _packages = [NSMutableArray array];
        
        [self loadPackages];
    }
    return self;
}

#pragma mark - 数据源方法
- (NSInteger)numberOfPagesInSection:(NSInteger)section {
    HMEmoticonPackage *package = _packages[section];
    
    return ((NSInteger)package.emoticonsList.count - 1) / kEmoticonsCountOfPage + 1;
}

- (NSArray *)emoticonsWithIndexPath:(NSIndexPath *)indexPath {
    HMEmoticonPackage *package = self.packages[indexPath.section];
    
    NSInteger location = indexPath.item * kEmoticonsCountOfPage;
    NSInteger length = kEmoticonsCountOfPage;
    
    // 判断是否越界
    if ((location + length) > package.emoticonsList.count) {
        length = package.emoticonsList.count - location;
    }
    
    NSRange range = NSMakeRange(location, length);
    
    return [package.emoticonsList subarrayWithRange:range];
}

#pragma mark - 最近使用表情
- (void)addRecentEmoticon:(HMEmoticon *)emoticon {
    NSLog(@"%s", __FUNCTION__);
    
    // 0. 表情计数 ++
    emoticon.times++;
    
    // 1. 判断表情是否已经存在
    if (![_packages[0].emoticonsList containsObject:emoticon]) {
        [_packages[0].emoticonsList addObject:emoticon];
    }
    
    // 2. 排序
    [_packages[0].emoticonsList sortUsingComparator:^NSComparisonResult(HMEmoticon *obj1, HMEmoticon *obj2) {
        return obj1.times < obj2.times;
    }];
}

#pragma mark - 加载表情包数据
- (void)loadPackages {
    // 1. 读取 emoticons.plist
    NSString *path = [[NSBundle hm_emoticonBundle] pathForResource:@"emoticons.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    // 2. 遍历数组，生成 packages 模型
    for (NSDictionary *dict in array) {
        [_packages addObject:[HMEmoticonPackage packageWithDict:dict]];
    }
}

@end

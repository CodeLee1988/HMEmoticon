//
//  HMEmoticonManager.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonManager.h"
#import "NSBundle+HMEmoticon.h"

/// 每页显示的表情数量
static NSInteger kEmoticonsCountOfPage = 20;
/// 默认用户标识符号
NSString *const HMEmoticonDefaultUserIdentifier = @"cn.itcast.DefaultUser";
/// 表情文件名
NSString *const HMEmoticonFileName = @".emoticons.json";

@implementation HMEmoticonManager {
    NSMutableArray <HMEmoticon *> *_recentEmoticonList;
}

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
    // 0. 表情计数 ++
    emoticon.times++;
    
    // 1. 判断表情是否已经存在
    if (![_recentEmoticonList containsObject:emoticon]) {
        [_recentEmoticonList addObject:emoticon];
    }
    
    // 2. 排序
    [_recentEmoticonList sortUsingComparator:^NSComparisonResult(HMEmoticon *obj1, HMEmoticon *obj2) {
        return obj1.times < obj2.times;
    }];
    
    // 3. 更新最近表情包
    [self updateRecentPackage];
    
    // 4. 保存表情包
    [self saveRecentEmoticonList];
}

/// 更新最近表情包数组
- (void)updateRecentPackage {
    NSInteger length = _recentEmoticonList.count < kEmoticonsCountOfPage ? _recentEmoticonList.count : kEmoticonsCountOfPage;
    
    _packages[0].emoticonsList = [_recentEmoticonList subarrayWithRange:NSMakeRange(0, length)].mutableCopy;
}

/// 保存最近表情数组
- (void)saveRecentEmoticonList {
    
    NSMutableArray *jsonDict = [NSMutableArray array];
    for (HMEmoticon *emoticon in _recentEmoticonList) {
        [jsonDict addObject:[emoticon dictionary]];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:NULL];
    [data writeToFile:[self filePathForRecentEmoticon] atomically:YES];
}

/// 加载最近表情数组
///
/// @return 最近表情数组
- (NSMutableArray <HMEmoticon *>*)loadRecentEmoticonList {
    
    NSData *data = [NSData dataWithContentsOfFile:[self filePathForRecentEmoticon]];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chs CONTAINS %@ OR code CONTAINS %@", dict[@"chs"], dict[@"code"]];
        
        for (NSInteger i = 1; i < _packages.count; i++) {
            HMEmoticonPackage *package = _packages[i];
            
            NSArray *filter = [package.emoticonsList filteredArrayUsingPredicate:predicate];

            if (filter.count == 1) {
                [arrayM addObject:filter[0]];
                break;
            }
        }
    }
    
    return arrayM;
}

/// 最近表情文件路径
- (NSString *)filePathForRecentEmoticon {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [[dir stringByAppendingPathComponent:self.userIdentifier] stringByAppendingString:HMEmoticonFileName];
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
    
    // 3. 加载最近使用表情列表
    _recentEmoticonList = [self loadRecentEmoticonList];
    
    // 4. 更新最近表情包
    [self updateRecentPackage];
}

#pragma mark - 懒加载属性
- (NSString *)userIdentifier {
    if (_userIdentifier == nil) {
        _userIdentifier = HMEmoticonDefaultUserIdentifier;
    }
    return _userIdentifier;
}

@end

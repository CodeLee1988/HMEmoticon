//
//  HMEmoticonInputView.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonInputView.h"
#import "HMEmoticonToolbar.h"
#import "UIImage+HMEmoticon.h"

/// 表情 Cell 可重用标识符号
NSString *const HMEmoticonCellIdentifier = @"HMEmoticonCellIdentifier";

@interface HMEmoticonInputView() <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation HMEmoticonInputView

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:HMEmoticonCellIdentifier
                                  forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return cell;
}

#pragma mark - 设置界面
- (void)prepareUI {
    // 1. 设置尺寸
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 258;
    self.frame = rect;
    CGFloat toolbarHeight = 42;
    
    // 2. 基本属性设置
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage hm_imageNamed:@"emoticon_keyboard_background"]];
    
    // 3. 添加工具栏
    HMEmoticonToolbar *toolbar = [[HMEmoticonToolbar alloc] init];
    [self addSubview:toolbar];
    
    // 设置工具栏位置
    CGRect toolbarRect = self.bounds;
    toolbarRect.origin.y = toolbarRect.size.height - toolbarHeight;
    toolbarRect.size.height = toolbarHeight;
    toolbar.frame = toolbarRect;
    
    // 4. 添加 collectionView
    CGRect collectionViewRect = self.bounds;
    collectionViewRect.size.height -= toolbarHeight;
    UICollectionView *collectionView = [[UICollectionView alloc]
                                        initWithFrame:collectionViewRect
                                        collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self addSubview:collectionView];
    
    // 设置 collectionView
    collectionView.backgroundColor = [UIColor clearColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HMEmoticonCellIdentifier];
}

@end

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
#import "HMEmoticonManager.h"
#import "HMEmoticonCell.h"

/// 表情 Cell 可重用标识符号
NSString *const HMEmoticonCellIdentifier = @"HMEmoticonCellIdentifier";

#pragma mark - 表情键盘布局
@interface HMEmoticonKeyboardLayout : UICollectionViewFlowLayout

@end

@implementation HMEmoticonKeyboardLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

@end

#pragma mark - 表情输入视图
@interface HMEmoticonInputView() <UICollectionViewDataSource, UICollectionViewDelegate, HMEmoticonToolbarDelegate>

@end

@implementation HMEmoticonInputView {
    UICollectionView *_collectionView;
    HMEmoticonToolbar *_toolbar;
    UIPageControl *_pageControl;
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
        [_collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
        [self updatePageControlWithIndexPath:indexPath];
    }
    return self;
}

#pragma mark - HMEmoticonToolbarDelegate
- (void)emoticonToolbarDidSelectSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    
    [_collectionView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionLeft
                                    animated:NO];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [HMEmoticonManager sharedManager].packages.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[HMEmoticonManager sharedManager] numberOfPagesInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HMEmoticonCell *cell = [collectionView
                            dequeueReusableCellWithReuseIdentifier:HMEmoticonCellIdentifier
                            forIndexPath:indexPath];
    
    cell.emoticons = [[HMEmoticonManager sharedManager] emoticonsWithIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint center = scrollView.center;
    center.x += scrollView.contentOffset.x;
    
    NSArray *indexPaths = [_collectionView indexPathsForVisibleItems];
    
    NSIndexPath *targetPath = nil;
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
        
        if (CGRectContainsPoint(cell.frame, center)) {
            targetPath = indexPath;
            break;
        }
    }
    
    if (targetPath != nil) {
        [self updatePageControlWithIndexPath:targetPath];
        [_toolbar selectSection:targetPath.section];
    }
}

- (void)updatePageControlWithIndexPath:(NSIndexPath *)indexPath {
    _pageControl.numberOfPages = [[HMEmoticonManager sharedManager] numberOfPagesInSection:indexPath.section];
    _pageControl.currentPage = indexPath.item;
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
    _toolbar = [[HMEmoticonToolbar alloc] init];
    [self addSubview:_toolbar];
    
    // 设置工具栏位置
    CGRect toolbarRect = self.bounds;
    toolbarRect.origin.y = toolbarRect.size.height - toolbarHeight;
    toolbarRect.size.height = toolbarHeight;
    _toolbar.frame = toolbarRect;
    
    _toolbar.delegate = self;
    
    // 4. 添加 collectionView
    CGRect collectionViewRect = self.bounds;
    collectionViewRect.size.height -= toolbarHeight;
    _collectionView = [[UICollectionView alloc]
                       initWithFrame:collectionViewRect
                       collectionViewLayout:[[HMEmoticonKeyboardLayout alloc] init]];
    [self addSubview:_collectionView];
    
    // 设置 collectionView
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[HMEmoticonCell class] forCellWithReuseIdentifier:HMEmoticonCellIdentifier];
    
    // 5. 分页控件
    _pageControl = [[UIPageControl alloc] init];
    [self addSubview:_pageControl];
    
    // 设置分页控件
    _pageControl.hidesForSinglePage = YES;
    _pageControl.userInteractionEnabled = NO;
    
    [_pageControl setValue:[UIImage hm_imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    [_pageControl setValue:[UIImage hm_imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    
    // 自动布局
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_toolbar
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:0.0]];
}

@end

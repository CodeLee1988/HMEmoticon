//
//  HMEmoticonTextView.h
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface HMEmoticonTextView : UITextView
/// 占位文本
@property (nonatomic, copy) IBInspectable NSString *placeholder;
/// 最大输入文本长度
@property (nonatomic) IBInspectable NSInteger maxInputLength;
@end

//
//  ViewController.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "HMEmoticonTextView.h"
#import "HMEmoticonInputView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet HMEmoticonTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 设置用户标示 - 用于保存最近使用表情
    [HMEmoticonManager sharedManager].userIdentifier = @"刀哥";
    
    // 2. 设置表情输入视图
    _textView.useEmoticonInputView = YES;
    
    // 3. 监听键盘通知
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillChanged:)
     name:UIKeyboardWillChangeFrameNotification
     object:nil];
    
    // 4. 通过表情描述字符串设置属性字符串
    NSString *text = @"[爱你]啊[笑哈哈]";
    NSAttributedString *attributeText = [[HMEmoticonManager sharedManager]
                                         emoticonStringWithString:text
                                         font:_textView.font];
    _textView.attributedText = attributeText;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
    
    NSLog(@"%@", _textView.inputView);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听方法
/// 切换输入视图
- (IBAction)switchInputView:(id)sender {
    _textView.useEmoticonInputView = !_textView.isUseEmoticonInputView;
}

/// 显示转换后的表情符号文本，可以用户网络传输
- (IBAction)showText:(id)sender {
    NSLog(@"%@", _textView.emoticonText);
}

- (void)keyboardWillChanged:(NSNotification *)notification {
    
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSInteger curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    _bottomConstraint.constant = self.view.bounds.size.height - rect.origin.y;
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:curve];
        
        [self.view layoutIfNeeded];
    }];
}

@end

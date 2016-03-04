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
@property (strong, nonatomic) IBOutlet HMEmoticonTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text = @"hello";
    
    __weak typeof(self) weakSelf = self;
    _textView.inputView = [[HMEmoticonInputView alloc] initWithSelectedEmoticon:^(HMEmoticon * _Nullable emoticon, BOOL isRemoved) {
        [weakSelf.textView inputEmoticon:emoticon isRemoved:isRemoved];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

- (IBAction)showText:(id)sender {
    NSLog(@"%@", _textView.emoticonText);
}

@end

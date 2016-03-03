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

@interface ViewController () {
    __weak IBOutlet HMEmoticonTextView *_textView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text = @"hello";
    
    _textView.inputView = [[HMEmoticonInputView alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

@end

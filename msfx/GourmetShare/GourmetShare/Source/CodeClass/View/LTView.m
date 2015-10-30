//
//  LTView.m
//  LoginSystem
//
//  Created by y_小易 on 14-8-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LTView.h"

@implementation LTView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_setupSubviews];
    }
    return self;
}

- (void)p_setupSubviews
{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _inputField.borderStyle = UITextBorderStyleRoundedRect;
    _inputField.text = @"";
    _inputField.textAlignment = NSTextAlignmentCenter;

    _inputField.backgroundColor = [UIColor clearColor];
    [self addSubview:_inputField];

}

//初始化方法，显示的文字
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholderText imageName:(NSString *)imageNmae;
{
    self = [self initWithFrame:frame];
    if (self) {
        if ([placeholderText isEqualToString:@"---"]) {
            self.inputField.userInteractionEnabled = NO;
        }
        self.inputField.placeholder = placeholderText;
    }
    
    return self;
}


//获取输入框的内容
- (NSString *)inputFieldText
{
    return _inputField.text;
}

-(void)outputFileText:(NSString *)text
{
    _inputField.text = text;
}

//输入框是否 密码格式
- (void)setSecureTextEnabled:(BOOL)isSecureText
{
    _inputField.secureTextEntry = isSecureText;
}

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate
{
    _inputField.delegate = fieldDelegate;
}

//textfield回收键盘
- (void)recyleKeyboard
{
    [_inputField resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  LTView.h
//  LoginSystem
//
//  Created by y_小易 on 14-8-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTView : UIView

@property (nonatomic,retain,readonly) UITextField *inputField;

//初始化方法，指定label上显示的文字
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholderText imageName:(NSString *)imageNmae;

//获取输入框的内容
- (NSString *)inputFieldText;

//设置输入框内容
-(void)outputFileText:(NSString *)text;

//输入框是否 密码格式
- (void)setSecureTextEnabled:(BOOL)isSecureText;

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate;

//textfield回收键盘
- (void)recyleKeyboard;

@end

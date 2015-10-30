//
//  LoginView.m
//  GourmetShare
//
//  Created by jang on 15/10/20.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "LoginView.h"
#import "LTView.h"
@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    self.userNameLT = [[LTView alloc]initWithFrame:CGRectMake(0, kScreenHeight/4, kScreenWidth, kScreenHeight/13) placeholder:@"用户名/邮箱" imageName:@""];
    [self addSubview:_userNameLT];
    
    self.backgroundColor = [UIColor whiteColor];
    self.passWordLT = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLT.frame), CGRectGetMaxY(self.userNameLT.frame), CGRectGetWidth(self.userNameLT.frame), CGRectGetHeight(self.userNameLT.frame)) placeholder:@"密     码" imageName:@""];
    [_passWordLT setSecureTextEnabled:YES];
    [self addSubview:_passWordLT];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame = CGRectMake(CGRectGetMinX(self.passWordLT.frame)+40, CGRectGetMaxY(self.passWordLT.frame)+40,  CGRectGetWidth(self.bounds)/2 -50, 45);
    [self.loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [_loginButton.layer setMasksToBounds:YES];
    [_loginButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_loginButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    
    [_loginButton.layer setBorderColor:[[UIColor blueColor] CGColor]];//边框颜色
    [self addSubview:_loginButton];
    
    self.registButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registButton.frame = CGRectMake(CGRectGetMaxX(self.loginButton.frame)+20, CGRectGetMinY(self.loginButton.frame), CGRectGetWidth(self.loginButton.frame), CGRectGetHeight(self.loginButton.frame));
    [self.registButton setTitle:@"注 册" forState:UIControlStateNormal];
    _registButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [_registButton.layer setMasksToBounds:YES];
    [_registButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_registButton.layer setBorderWidth:1.0]; //边框宽度
    
    [_registButton.layer setBorderColor:[[UIColor blueColor] CGColor]];//边框颜色
    [self addSubview:_registButton];
    
    self.changeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.changeButton.frame = CGRectMake(kScreenWidth/19, kScreenHeight*0.94, 150, kScreenHeight*0.04);
    [self.changeButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    _changeButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [_changeButton.layer setMasksToBounds:YES];
    [_changeButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [self addSubview:_changeButton];
}



@end

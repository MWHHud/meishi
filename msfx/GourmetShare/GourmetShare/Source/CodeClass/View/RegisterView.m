//
//  RegisterView.m
//  GourmetShare
//
//  Created by jang on 15/10/20.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "RegisterView.h"
#import "LTView.h"
@implementation RegisterView

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
    
    self.backgroundColor = [UIColor whiteColor];
    self.userNameText = [[LTView alloc]initWithFrame:CGRectMake(0, kScreenHeight/5.3, kScreenWidth, kScreenHeight/15) placeholder:@"用  户  名" imageName:@""];
    [self addSubview:_userNameText];
    
    self.passWordText = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameText.frame), CGRectGetMaxY(self.userNameText.frame)+30, CGRectGetWidth(self.userNameText.frame), CGRectGetHeight(self.userNameText.frame))  placeholder:@"密     码" imageName:@""];
    [_passWordText setSecureTextEnabled:YES];
    [self addSubview:_passWordText];
    
    self.confirmText = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.passWordText.frame), CGRectGetMaxY(self.passWordText.frame)+30, CGRectGetWidth(self.passWordText.frame), CGRectGetHeight(self.passWordText.frame)) placeholder:@"确认密码" imageName:@""];
    [_confirmText setSecureTextEnabled:YES];
    [self addSubview:_confirmText];
    
    self.emailText = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.confirmText.frame), CGRectGetMaxY(self.confirmText.frame)+30, CGRectGetWidth(self.confirmText.frame), CGRectGetHeight(self.confirmText.frame)) placeholder:@"邮     箱" imageName:@""];
    [self addSubview:_emailText];
    
    
    self.registButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registButton.frame = CGRectMake(CGRectGetMinX(self.emailText.frame)+60, CGRectGetMaxY(self.emailText.frame) + 40, CGRectGetWidth(self.bounds) - CGRectGetMinX(_emailText.frame) *2-120, CGRectGetHeight(self.emailText.frame));
    [self.registButton setTitle:@"注  册" forState:UIControlStateNormal];
    _registButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [_registButton.layer setMasksToBounds:YES];
    [_registButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_registButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    
    [_registButton.layer setBorderColor:[[UIColor blueColor] CGColor]];//边框颜色
    
    [self addSubview:_registButton];
    
    self.scrollEnabled = NO;
}

//键盘显示
- (void)adjustSubviewsWithKeyboardShow
{
    
    self.contentSize = CGSizeMake(self.bounds.size.width, kScreenHeight*1.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset = CGPointMake(0, kScreenHeight*0.3);
        
    }];
    self.scrollEnabled = YES;
}

//键盘消失
- (void)adjustSubviewsWithKeyboardHide
{
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset = CGPointMake(0, -kScreenHeight*0.07);
        
    }];
    self.scrollEnabled = NO;
    
}
- (void)changeWithKeyboardHide
{
    self.contentSize = CGSizeMake(self.bounds.size.width, kScreenHeight*1.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset = CGPointMake(0, -kScreenHeight*0.04);
        
    }];
    self.scrollEnabled = YES;
}

@end

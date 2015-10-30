//
//  MySelfView.m
//  GourmetShare
//
//  Created by jang on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MySelfView.h"
#import "LTView.h"
@implementation MySelfView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setView];
    }
    return self;
}

-(void)p_setView
{
    
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-kScreenWidth/8, kScreenHeight/9, kScreenWidth/4, kScreenWidth/4)];
    self.headImage.layer.cornerRadius = kScreenWidth/8;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.image = [UIImage imageNamed:@"3.jpg"];
    [self addSubview:_headImage];
    
    self.nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/15, CGRectGetMaxY(self.headImage.frame)+kScreenHeight/20, kScreenWidth/4, kScreenHeight/19)];
    self.nicknameLabel.text = @"昵       称:";
    [self addSubview:_nicknameLabel];
    
    self.nicknameFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nicknameLabel.frame), CGRectGetMinY(self.nicknameLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.nicknameLabel.frame)+10) placeholder:@"---" imageName:nil];
    [self addSubview:_nicknameFiled];
    
    self.emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nicknameLabel.frame), CGRectGetMaxY(self.nicknameLabel.frame) + kScreenHeight/25, CGRectGetWidth(self.nicknameLabel.frame), CGRectGetHeight(self.nicknameLabel.frame))];
    self.emailLabel.text = @"邮       箱:";
    [self addSubview:_emailLabel];
    
    self.emailFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.emailLabel.frame), CGRectGetMinY(self.emailLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.emailLabel.frame)+10) placeholder:@"---" imageName:nil];
    [self addSubview:_emailFiled];
    
    self.genderLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.emailLabel.frame), CGRectGetMaxY(self.emailLabel.frame) + kScreenHeight/25, CGRectGetWidth(self.emailLabel.frame), CGRectGetHeight(self.emailLabel.frame))];
    self.genderLabel.text = @"性       别:";
    [self addSubview:_genderLabel];
    
    self.genderFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.genderLabel.frame), CGRectGetMinY(self.genderLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.genderLabel.frame)+10) placeholder:@"---" imageName:nil];
    [self addSubview:_genderFiled];
    
    
    self.hobbyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.genderLabel.frame), CGRectGetMaxY(self.genderLabel.frame) + kScreenHeight/25, CGRectGetWidth(self.genderLabel.frame), CGRectGetHeight(self.genderLabel.frame))];
    self.hobbyLabel.text = @"爱       好:";
    [self addSubview:_hobbyLabel];
    
    self.hobbyFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.hobbyLabel.frame), CGRectGetMinY(self.hobbyLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.hobbyLabel.frame)+10) placeholder:@"---" imageName:nil];
    [self addSubview:_hobbyFiled];
    
    
    self.likeFoodLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.hobbyLabel.frame), CGRectGetMaxY(self.hobbyLabel.frame) + kScreenHeight/25, CGRectGetWidth(self.hobbyLabel.frame), CGRectGetHeight(self.hobbyLabel.frame))];
    self.likeFoodLabel.text = @"爱吃的菜:";
    [self addSubview:_likeFoodLabel];
    
    self.likeFoodFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.likeFoodLabel.frame), CGRectGetMinY(self.likeFoodLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.likeFoodLabel.frame)+10) placeholder:@"---" imageName:nil];
    [self addSubview:_likeFoodFiled];
    
    
    self.skillLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.likeFoodLabel.frame), CGRectGetMaxY(self.likeFoodLabel.frame) + kScreenHeight/25, CGRectGetWidth(self.likeFoodLabel.frame), CGRectGetHeight(self.likeFoodLabel.frame))];
    self.skillLabel.text = @"会做的菜:";
    [self addSubview:_skillLabel];
    
    self.skillFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.skillLabel.frame), CGRectGetMinY(self.skillLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.skillLabel.frame)+10) placeholder:@"---" imageName:nil];
    [self addSubview:_skillFiled];
    self.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*1.4);
    
}

//键盘显示
- (void)adjustSubviewsWithKeyboardShow
{
    self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + kScreenHeight*0.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset = CGPointMake(0, kScreenHeight*0.4);
        
    }];
}

//键盘消失
- (void)adjustSubviewsWithKeyboardHide
{
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset = CGPointMake(0, -kScreenHeight*0.09);
        
    }];
    
}

- (void)changeWithKeyboardHide
{
    self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + kScreenHeight*0.3);
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset = CGPointMake(0, 0);
        
    }];
}

@end

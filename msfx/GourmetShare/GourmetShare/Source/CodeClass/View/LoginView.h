//
//  LoginView.h
//  GourmetShare
//
//  Created by jang on 15/10/20.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTView;
@interface LoginView : UIView
@property (nonatomic,strong)LTView *userNameLT;
@property (nonatomic,strong)LTView *passWordLT;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *registButton;
@property (nonatomic,strong)UIButton *changeButton;
@end

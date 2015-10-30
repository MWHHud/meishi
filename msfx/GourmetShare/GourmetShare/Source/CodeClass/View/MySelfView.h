//
//  MySelfView.h
//  GourmetShare
//
//  Created by jang on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTView;
@interface MySelfView : UIScrollView

@property (nonatomic,strong)UIImageView *headImage;

@property (nonatomic,strong)UILabel *nicknameLabel;
@property (nonatomic,strong)LTView *nicknameFiled;

@property (nonatomic,strong)UILabel *emailLabel;
@property (nonatomic,strong)LTView *emailFiled;

@property (nonatomic,strong)UILabel *genderLabel;
@property (nonatomic,strong)LTView *genderFiled;

@property (nonatomic,strong)UILabel *hobbyLabel;
@property (nonatomic,strong)LTView *hobbyFiled;

@property (nonatomic,strong)UILabel *likeFoodLabel;
@property (nonatomic,strong)LTView *likeFoodFiled;

@property (nonatomic,strong)UILabel *skillLabel;
@property (nonatomic,strong)LTView *skillFiled;

//键盘显示
- (void)adjustSubviewsWithKeyboardShow;
//键盘消失
- (void)adjustSubviewsWithKeyboardHide;

- (void)changeWithKeyboardHide;
@end

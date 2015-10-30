//
//  MainView.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIScrollView
// 主循环滚动图
@property (nonatomic,strong)SDCycleScrollView *mainCycleScrollView;

// 分组名
@property (nonatomic,strong)UILabel *titleLabel1;
// "更多"按钮
@property (nonatomic,strong)UIButton *moreButton1;
// 三组图片及图片标题
@property (nonatomic,strong)UIImageView *oneImageView1;
@property (nonatomic,strong)UILabel *oneLabel1;

@property (nonatomic,strong)UIImageView *twoImageView1;
@property (nonatomic,strong)UILabel *twoLabel1;

@property (nonatomic,strong)UIImageView *threeImageView1;
@property (nonatomic,strong)UILabel *threeLabel1;


// 分组名
@property (nonatomic,strong)UILabel *titleLabel2;
// "更多"按钮
@property (nonatomic,strong)UIButton *moreButton2;
// 三组图片及图片标题
@property (nonatomic,strong)UIImageView *oneImageView2;
@property (nonatomic,strong)UILabel *oneLabel2;

@property (nonatomic,strong)UIImageView *twoImageView2;
@property (nonatomic,strong)UILabel *twoLabel2;

@property (nonatomic,strong)UIImageView *threeImageView2;
@property (nonatomic,strong)UILabel *threeLabel2;

@end

//
//  MyScrollView.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetWidth([[UIScreen mainScreen]bounds]) * 3 / 4)];
    self.titleImage.backgroundColor = [UIColor lightGrayColor];
    self.titleImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_titleImage];
    
    self.backImage1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleImage.frame), CGRectGetMaxY(self.titleImage.frame) + 20, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetWidth([[UIScreen mainScreen]bounds]))];
    self.backImage1.backgroundColor = [UIColor whiteColor];
    self.backImage1.layer.cornerRadius = 10;
    [self addSubview:_backImage1];
    
    self.line1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 5, 30)];
    self.line1.backgroundColor = [UIColor cyanColor];
    [self.backImage1 addSubview:_line1];
    
    self.title1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line1.frame) + 10, CGRectGetMinY(self.line1.frame), CGRectGetWidth(self.backImage1.frame) - 90, CGRectGetHeight(self.line1.frame))];
    self.title1.text = @"美食食谱";
    [self.backImage1 addSubview:_title1];
    
    self.moreButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreButton1.frame = CGRectMake(CGRectGetMaxX(self.title1.frame), CGRectGetMinY(self.title1.frame), 70, CGRectGetHeight(self.title1.frame));
    [self.moreButton1 setTitle:@"更多＞" forState:UIControlStateNormal];
    [self.backImage1 addSubview:_moreButton1];
    
    self.oneImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.line1.frame), CGRectGetMaxY(self.line1.frame) + 5, CGRectGetWidth(self.backImage1.frame) / 2 - 10, CGRectGetHeight(self.backImage1.frame) / 2 - CGRectGetHeight(self.line1.frame) - 20)];
    [self.backImage1 addSubview:_oneImageView1];
    
    self.oneLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.oneImageView1.frame), CGRectGetMaxY(self.oneImageView1.frame), CGRectGetWidth(self.oneImageView1.frame), CGRectGetHeight(self.oneImageView1.frame) / 5)];
//    self.oneLabel1.backgroundColor = [UIColor lightGrayColor];
    self.oneLabel1.font = [UIFont systemFontOfSize:15];
    [self.backImage1 addSubview:_oneLabel1];
    
    self.twoImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.oneImageView1.frame) + 10, CGRectGetMinY(self.oneImageView1.frame), CGRectGetWidth(self.oneImageView1.frame), CGRectGetHeight(self.oneImageView1.frame))];
    [self.backImage1 addSubview:_twoImageView1];
    
    self.twoLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.twoImageView1.frame), CGRectGetMaxY(self.twoImageView1.frame), CGRectGetWidth(self.twoImageView1.frame), CGRectGetHeight(self.oneLabel1.frame))];
    self.twoLabel1.font = [UIFont systemFontOfSize:15];
    [self.backImage1 addSubview:_twoLabel1];
    
    self.threeImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.oneImageView1.frame), CGRectGetMaxY(self.oneLabel1.frame), CGRectGetWidth(self.oneImageView1.frame), CGRectGetHeight(self.oneImageView1.frame))];
    [self.backImage1 addSubview:_threeImageView1];
    
    self.threeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.threeImageView1.frame), CGRectGetMaxY(self.threeImageView1.frame), CGRectGetWidth(self.oneLabel1.frame), CGRectGetHeight(self.oneLabel1.frame))];
    [self.backImage1 addSubview:_threeLabel1];
    
    self.fourImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.threeImageView1.frame) + 10, CGRectGetMinY(self.threeImageView1.frame), CGRectGetWidth(self.threeImageView1.frame), CGRectGetHeight(self.threeImageView1.frame))];
    [self.backImage1 addSubview:_fourImageView1];
    
    self.fourLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.fourImageView1.frame), CGRectGetMaxY(self.fourImageView1.frame), CGRectGetWidth(self.oneLabel1.frame), CGRectGetHeight(self.oneLabel1.frame))];
    [self.backImage1 addSubview:_fourLabel1];
    
    
    
    
    self.backImage2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleImage.frame), CGRectGetMaxY(self.backImage1.frame) + 20, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetWidth([[UIScreen mainScreen]bounds]))];
    self.backImage2.backgroundColor = [UIColor whiteColor];
    self.backImage2.layer.cornerRadius = 10;
    [self addSubview:_backImage2];
    
    self.line2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 5, 30)];
    self.line2.backgroundColor = [UIColor cyanColor];
    [self.backImage2 addSubview:_line2];
    
    self.title2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.line2.frame) + 10, CGRectGetMinY(self.line2.frame), CGRectGetWidth(self.backImage2.frame) - 90, CGRectGetHeight(self.line2.frame))];
    self.title2.text = @"用户分享";
    [self.backImage2 addSubview:_title2];
    
    self.moreButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreButton2.frame = CGRectMake(CGRectGetMaxX(self.title2.frame), CGRectGetMinY(self.title2.frame), 70, CGRectGetHeight(self.title2.frame));
    [self.moreButton2 setTitle:@"更多＞" forState:UIControlStateNormal];
    [self.backImage2 addSubview:_moreButton2];
    
    self.oneImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.line2.frame), CGRectGetMaxY(self.line2.frame) + 5, CGRectGetWidth(self.backImage2.frame) / 2 - 10, CGRectGetHeight(self.backImage2.frame) / 2 - CGRectGetHeight(self.line2.frame) - 20)];
    [self.backImage2 addSubview:_oneImageView2];
    
    self.oneLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.oneImageView2.frame), CGRectGetMaxY(self.oneImageView2.frame), CGRectGetWidth(self.oneImageView2.frame), CGRectGetHeight(self.oneImageView2.frame) / 5)];

    //    self.oneLabel1.backgroundColor = [UIColor lightGrayColor];
    self.oneLabel2.font = [UIFont systemFontOfSize:15];
    [self.backImage2 addSubview:_oneLabel2];
    
    self.twoImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.oneImageView2.frame) + 10, CGRectGetMinY(self.oneImageView2.frame), CGRectGetWidth(self.oneImageView2.frame), CGRectGetHeight(self.oneImageView2.frame))];
    [self.backImage2 addSubview:_twoImageView2];
    
    self.twoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.twoImageView2.frame), CGRectGetMaxY(self.twoImageView2.frame), CGRectGetWidth(self.twoImageView2.frame), CGRectGetHeight(self.oneLabel2.frame))];

    self.twoLabel2.font = [UIFont systemFontOfSize:15];
    [self.backImage2 addSubview:_twoLabel2];
    
    self.threeImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.oneImageView2.frame), CGRectGetMaxY(self.oneLabel2.frame), CGRectGetWidth(self.oneImageView2.frame), CGRectGetHeight(self.oneImageView2.frame))];
    [self.backImage2 addSubview:_threeImageView2];
    
    self.threeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.threeImageView2.frame), CGRectGetMaxY(self.threeImageView2.frame), CGRectGetWidth(self.oneLabel2.frame), CGRectGetHeight(self.oneLabel2.frame))];

    [self.backImage2 addSubview:_threeLabel2];
    
    self.fourImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.threeImageView2.frame) + 10, CGRectGetMinY(self.threeImageView2.frame), CGRectGetWidth(self.threeImageView2.frame), CGRectGetHeight(self.threeImageView2.frame))];
    [self.backImage2 addSubview:_fourImageView2];
    
    self.fourLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.fourImageView2.frame), CGRectGetMaxY(self.fourImageView2.frame), CGRectGetWidth(self.oneLabel2.frame), CGRectGetHeight(self.oneLabel2.frame))];

    [self.backImage2 addSubview:_fourLabel2];
}

@end

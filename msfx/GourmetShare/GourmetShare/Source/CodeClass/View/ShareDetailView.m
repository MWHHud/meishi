//
//  ShareDetailView.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "ShareDetailView.h"

@implementation ShareDetailView

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.backScroll = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.backScroll.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backScroll];
    
    self.shareImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX([[UIScreen mainScreen]bounds]) - 140, 20, 120, 210)];
    self.shareImage.layer.borderWidth = 1;
    self.shareImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.backScroll addSubview:_shareImage];
    
    self.myButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myButton.frame = CGRectMake(70, CGRectGetMinY(self.shareImage.frame) + 30, 70, 30);
    self.myButton.backgroundColor = [UIColor lightGrayColor];
    self.myButton.layer.cornerRadius = 5;
    [self.myButton setTitle:@"选择图片" forState:UIControlStateNormal];
    [self.backScroll addSubview:_myButton];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.myButton.frame), CGRectGetMaxY(self.myButton.frame) + 50, CGRectGetWidth(self.myButton.frame), CGRectGetHeight(self.myButton.frame))];
    self.nameLabel.text = @"菜名";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;

    [self.backScroll addSubview:_nameLabel];
    
    self.nameText = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame) + 20, CGRectGetWidth([[UIScreen mainScreen]bounds]) - CGRectGetWidth(self.shareImage.frame) - 60, CGRectGetHeight(self.nameLabel.frame))];

    self.nameText.layer.borderWidth = 1;
    self.nameText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.nameText.layer.cornerRadius = 5;
    [self.backScroll addSubview:_nameText];
    
    self.materLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameText.frame), CGRectGetMaxY(self.shareImage.frame) + 10, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, CGRectGetHeight(self.nameLabel.frame))];

    self.materLabel.text = @"食材和配料";
    [self.backScroll addSubview:_materLabel];
    
    self.materialText = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.materLabel.frame),CGRectGetMaxY(self.materLabel.frame) + 5 , CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 100)];

    self.materialText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.materialText.layer.borderWidth = 1;
    self.materialText.layer.cornerRadius = 5;
    [self.backScroll addSubview:_materialText];
    
    self.stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.materialText.frame), CGRectGetMaxY(self.materialText.frame) + 5, CGRectGetWidth(self.materLabel.frame), CGRectGetHeight(self.materLabel.frame))];
    self.stepLabel.text = @"制作步骤";

    [self.backScroll addSubview:_stepLabel];
    
    self.stepText = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.stepLabel.frame), CGRectGetMaxY(self.stepLabel.frame) + 5, CGRectGetWidth(self.materialText.frame), CGRectGetHeight(self.materialText.frame)+200)];

    self.stepText.layer.borderWidth = 1;
    self.stepText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.stepText.layer.cornerRadius = 5;
    [self.backScroll addSubview:_stepText];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareButton.frame = CGRectMake(CGRectGetMaxX([[UIScreen mainScreen]bounds]) / 2 - 35, CGRectGetMaxY(self.stepText.frame) + 10, 70, 30);
    [self.shareButton setTitle:@"分享/保存" forState:UIControlStateNormal];
    self.shareButton.backgroundColor = [UIColor lightGrayColor];
    self.shareButton.layer.cornerRadius = 5;
    [self.backScroll addSubview:_shareButton];
    
    
    
}

@end

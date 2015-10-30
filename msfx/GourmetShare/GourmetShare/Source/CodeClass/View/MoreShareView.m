//
//  MoreShareView.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MoreShareView.h"

@implementation MoreShareView

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
    
    self.back = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self addSubview:_back];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX([[UIScreen mainScreen]bounds]) / 2 - 75, 20, 150, 30)];

    self.nameLabel.textAlignment = UITextAlignmentCenter;
    self.nameLabel.text = @"菜名";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.back addSubview:_nameLabel];
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(self.nameLabel.frame), 70, CGRectGetHeight(self.nameLabel.frame))];
    self.name.text = @"菜名:";
    [self.back addSubview:_name];
    
    self.myImage = [[UIImageView alloc]initWithFrame:CGRectMake(10 , CGRectGetMaxY(self.nameLabel.frame) + 10, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 200)];
    self.myImage.backgroundColor = [UIColor lightGrayColor];
    [self.back addSubview:_myImage];
    
    self.mater = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.myImage.frame) + 10, CGRectGetWidth(self.nameLabel.frame), CGRectGetHeight(self.nameLabel.frame))];
    self.mater.text = @"食材和配料";

    self.mater.numberOfLines = 0;
    self.mater.textAlignment = NSTextAlignmentCenter;
    [self.back addSubview:_mater];
    
    self.materLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.myImage.frame), CGRectGetMaxY(self.mater.frame) + 10, CGRectGetWidth(self.myImage.frame), 100)];

    self.materLabel.numberOfLines = 0;
    self.materLabel.layer.borderWidth = 1;
    self.materLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.materLabel.layer.cornerRadius = 5;
    [self.back addSubview:_materLabel];
    
    self.step = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.mater.frame), CGRectGetMaxY(self.materLabel.frame) + 10, CGRectGetWidth(self.mater.frame), CGRectGetHeight(self.mater.frame))];
    self.step.text = @"制作步骤";
    self.step.textAlignment = NSTextAlignmentCenter;

    [self.back addSubview:_step];
    
    self.stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.materLabel.frame), CGRectGetMaxY(self.step.frame) + 10,CGRectGetWidth(self.materLabel.frame) , 300)];

    self.stepLabel.numberOfLines = 0;
    self.stepLabel.layer.cornerRadius = 5;
    self.stepLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.stepLabel.layer.borderWidth = 1;
    [self.back addSubview:_stepLabel];
}
@end

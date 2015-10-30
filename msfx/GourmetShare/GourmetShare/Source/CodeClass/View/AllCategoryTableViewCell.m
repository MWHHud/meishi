//
//  AllCategoryTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import "AllCategoryTableViewCell.h"

@implementation AllCategoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.contentView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:0.3];
    
    self.categoryButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.categoryButton1.frame = CGRectMake(CGRectGetMaxX(self.categoryLabel.frame) + 10, 30, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 6 - 5, 30);
    self.categoryButton1.layer.cornerRadius = 5;
    self.categoryButton1.layer.borderWidth = 1;
    self.categoryButton1.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.categoryButton1 setTintColor:[UIColor blackColor]];
    [self.categoryButton1 setTitle:@"菜谱" forState:UIControlStateNormal];
    [self.contentView addSubview:_categoryButton1];
    
    self.categoryButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.categoryButton2.frame = CGRectMake(CGRectGetMaxX(self.categoryButton1.frame) + 10, CGRectGetMinY(self.categoryButton1.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) / 6 - 5, 30);
    self.categoryButton2.layer.cornerRadius = 5;
    self.categoryButton2.layer.borderWidth = 1;
    self.categoryButton2.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.categoryButton2 setTintColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryButton2];
    
    self.categoryButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.categoryButton3.frame = CGRectMake(CGRectGetMaxX(self.categoryButton2.frame) + 10, CGRectGetMinY(self.categoryButton1.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) / 6 - 5, 30);
    self.categoryButton3.layer.cornerRadius = 5;
    self.categoryButton3.layer.borderWidth = 1;
    self.categoryButton3.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.categoryButton3 setTintColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryButton3];
    
    self.categoryButton4 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.categoryButton4.frame = CGRectMake(CGRectGetMinX(self.categoryButton1.frame), CGRectGetMaxY(self.categoryButton1.frame) + 20, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 6 - 5, 30);
    self.categoryButton4.layer.cornerRadius = 5;
    self.categoryButton4.layer.borderWidth = 1;
    self.categoryButton4.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.categoryButton4 setTintColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryButton4];
    
    self.categoryButton5 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.categoryButton5.frame = CGRectMake(CGRectGetMaxX(self.categoryButton4.frame) + 10, CGRectGetMinY(self.categoryButton4.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) / 6 - 5, 30);
    self.categoryButton5.layer.cornerRadius = 5;
    self.categoryButton5.layer.borderWidth = 1;
    self.categoryButton5.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.categoryButton5 setTintColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryButton5];
    
    self.categoryButton6 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.categoryButton6.frame = CGRectMake(CGRectGetMaxX(self.categoryButton5.frame) + 10, CGRectGetMinY(self.categoryButton4.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) / 6 - 5, 30);

    self.categoryButton6.layer.cornerRadius = 5;
    self.categoryButton6.layer.borderWidth = 1;
    self.categoryButton6.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.categoryButton6 setTintColor:[UIColor blackColor]];
    [self.contentView addSubview:_categoryButton6];
    
}

-(UILabel *)categoryLabel
{
    if (_categoryLabel == nil) {
        _categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3, 20)];
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        _categoryLabel.font = [UIFont systemFontOfSize:19];
        [self addSubview:_categoryLabel];
    }
    return _categoryLabel;
}


@end

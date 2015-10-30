//
//  NewsTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX([[UIScreen mainScreen]bounds]) - 110, 15, 90, 70)];
    self.titleImage.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleImage];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15,CGRectGetWidth([[UIScreen mainScreen]bounds]) - CGRectGetWidth(self.titleImage.frame) - 50, 70)];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
}

@end

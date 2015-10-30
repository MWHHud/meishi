//
//  MySelfImageTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MySelfImageTableViewCell.h"

@implementation MySelfImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.MyImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX([[UIScreen mainScreen]bounds]) / 2 - 50, 50, 100, 100)];
    self.MyImage.layer.cornerRadius = 50;
    self.MyImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_MyImage];
}

@end

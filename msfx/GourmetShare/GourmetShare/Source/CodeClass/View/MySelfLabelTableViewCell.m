//
//  MySelfLabelTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MySelfLabelTableViewCell.h"
#import "LTView.h"
@implementation MySelfLabelTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 - 20, 30)];

    [self.contentView addSubview:_titleLabel];
    
    self.textFiled = [[LTView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+10, CGRectGetMinY(self.titleLabel.frame)-5, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 3 * 2 - 30, CGRectGetHeight(self.titleLabel.frame)+10) placeholder:nil imageName:nil];

    [self.contentView addSubview:_textFiled];
}


@end

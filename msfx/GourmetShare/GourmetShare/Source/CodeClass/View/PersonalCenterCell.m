//
//  PersonalCenterCell.m
//  GourmetShare
//
//  Created by jang on 15/10/27.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "PersonalCenterCell.h"

@implementation PersonalCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(3, 5, self.frame.size.height, self.frame.size.height)];
    self.titleImage.layer.cornerRadius = self.frame.size.height/2;
    self.titleImage.layer.masksToBounds = YES;
    [self addSubview:_titleImage];
    
    self.titleName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleImage.frame)+20, 10, 100, 30)];
    [self addSubview:_titleName];
}

@end

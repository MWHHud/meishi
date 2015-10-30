//
//  ImtroTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/16.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "ImtroTableViewCell.h"

@implementation ImtroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    

    
    self.imtroLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 200)];

    self.imtroLabel.numberOfLines = 0;
    [self.contentView addSubview:_imtroLabel];
    }

@end

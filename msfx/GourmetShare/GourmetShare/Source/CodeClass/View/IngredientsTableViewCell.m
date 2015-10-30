//
//  IngredientsTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/16.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "IngredientsTableViewCell.h"

@implementation IngredientsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;

}

-(void)p_setup
{
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]) / 2 - 30, 30)];

    [self.contentView addSubview:_nameLabel];
    
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), CGRectGetMinY(self.nameLabel.frame), CGRectGetWidth([[UIScreen mainScreen]bounds]) / 2 - 30, 30)];

    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_numLabel];
}
@end

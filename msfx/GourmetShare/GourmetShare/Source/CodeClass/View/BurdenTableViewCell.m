//
//  BurdenTableViewCell.m
//  GourmetShare
//
//  Created by 马文豪 on 15/10/16.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "BurdenTableViewCell.h"

@implementation BurdenTableViewCell
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
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

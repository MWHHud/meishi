//
//  myshareTableViewCell.m
//  GourmetShare
//
//  Created by 马文豪 on 15/10/26.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "myshareTableViewCell.h"

@implementation myshareTableViewCell
-(UIImageView *)picture
{
    if (_picture == nil) {
        _picture = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        [self.contentView addSubview:_picture];
        
    }
    
    return _picture;
}
-(UILabel *)name
{
    if (_name == nil) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picture.frame)+10, 10, kScreenWidth-100, 80)];
        [self.contentView addSubview:_name];
    }
    return _name;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

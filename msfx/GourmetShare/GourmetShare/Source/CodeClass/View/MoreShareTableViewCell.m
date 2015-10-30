//
//  MoreShareTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "MoreShareTableViewCell.h"

@implementation MoreShareTableViewCell

-(UIImageView *)myImage
{
    if (_myImage == nil) {
        _myImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 100)];

        _myImage.layer.cornerRadius = 50;
        _myImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_myImage];
    }
    return _myImage;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.myImage.frame) + 20, CGRectGetMinY(self.myImage.frame) + 10, CGRectGetWidth([[UIScreen mainScreen]bounds]) - CGRectGetWidth(self.myImage.frame) - 30, 30)];

        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UILabel *)user
{
    if (_user == nil) {
        _user = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + 20, 40, CGRectGetHeight(self.nameLabel.frame))];

        _user.text = @"作者:";
        [self.contentView addSubview:_user];
    }
    return _user;
}

-(UILabel *)userLabel
{
    if (_userLabel == nil) {
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.user.frame) + 10, CGRectGetMinY(self.user.frame), CGRectGetWidth(self.nameLabel.frame) - CGRectGetWidth(self.user.frame) - 10, CGRectGetHeight(self.nameLabel.frame))];

        [self.contentView addSubview:_userLabel];
    }
    return _userLabel;
}
@end

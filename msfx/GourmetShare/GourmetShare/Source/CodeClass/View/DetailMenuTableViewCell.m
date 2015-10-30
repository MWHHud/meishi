//
//  DetailMenuTableViewCell.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "DetailMenuTableViewCell.h"

@implementation DetailMenuTableViewCell

-(UILabel *)menuLabel
{
    
    if (_menuLabel == nil) {
        _menuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.contentView.size.width-100, self.contentView.size.height)];
        [self.contentView addSubview:_menuLabel];
    }
    return _menuLabel;
}
-(UIImageView *)menuimage
{
    if (_menuimage == nil) {
        _menuimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-100, 10, 80, 80)];
        [self.contentView addSubview:_menuimage];
    }
    return _menuimage;
    
}
@end

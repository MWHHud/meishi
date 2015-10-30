//
//  CategoryDetailTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 jang. All rights reserved.
//

#import "CategoryDetailTableViewCell.h"

@implementation CategoryDetailTableViewCell

-(UILabel *)detailLabel
{
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.contentView.size.width, self.contentView.size.height)];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}


@end

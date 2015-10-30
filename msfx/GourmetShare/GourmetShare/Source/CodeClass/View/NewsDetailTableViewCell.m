//
//  NewsDetailTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "NewsDetailTableViewCell.h"

@implementation NewsDetailTableViewCell
// 内容
-(UILabel *)newsLabel
{
    if (_newsLabel == nil) {
        _newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 50)];
        [self.contentView addSubview:_newsLabel];
    }
    return _newsLabel;
}
@end

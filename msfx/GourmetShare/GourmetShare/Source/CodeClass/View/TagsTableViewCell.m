//
//  TagsTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/16.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "TagsTableViewCell.h"

@implementation TagsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    
    self.tagsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth([[UIScreen mainScreen]bounds ]) - 20, 200)];
        self.tagsLabel.numberOfLines = 0;
    [self.contentView addSubview:_tagsLabel];
    
}


@end

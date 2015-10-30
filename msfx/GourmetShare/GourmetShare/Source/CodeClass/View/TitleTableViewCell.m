//
//  TitleTableViewCell.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/16.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}


-(void)p_setup
{

    
    self.albumsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 200)];
    [self.contentView addSubview:_albumsImage];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.albumsImage.frame), CGRectGetWidth(self.albumsImage.frame), 20)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectButton.frame = CGRectMake(CGRectGetMaxX(self.albumsImage.frame) - 50, CGRectGetMaxY(self.albumsImage.frame) - 50, 40, 40);
    [self.collectButton setBackgroundImage:[UIImage imageNamed:@"home_songlist_unlove_hl.tiff"] forState:UIControlStateNormal];
    [self.albumsImage addSubview:_collectButton];
    
}

@end

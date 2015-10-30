//
//  PersonalCenterHeadCell.m
//  GourmetShare
//
//  Created by jang on 15/10/27.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "PersonalCenterHeadCell.h"

@implementation PersonalCenterHeadCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    self.backImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.6)];
    self.backImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"center.jpg"]];
    [self addSubview:_backImageView];
    
    self.headImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headImageView.frame = CGRectMake(kScreenWidth/2-kScreenWidth/8, kScreenHeight/13, kScreenWidth/4, kScreenWidth/4);
    self.headImageView.layer.cornerRadius = kScreenWidth/8;
    self.headImageView.layer.masksToBounds = YES;
    
    [self.backImageView addSubview:_headImageView];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.headImageView.frame), CGRectGetMaxY(self.headImageView.frame) + 15, kScreenWidth/4, kScreenWidth/15)];

    self.nameLable.textAlignment = UITextAlignmentCenter;
    [self.backImageView addSubview:_nameLable];
}
@end

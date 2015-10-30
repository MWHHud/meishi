//
//  LeftSortsView.m
//  GourmetShare
//
//  Created by jang on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "LeftSortsView.h"

@implementation LeftSortsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    self.backgroundColor = [UIColor clearColor];
    self.headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.headButton.frame = CGRectMake(kScreenWidth/16, kScreenHeight/10 , kScreenWidth/5, kScreenWidth/5);
    self.headButton.layer.masksToBounds = YES;
    self.headButton.layer.cornerRadius = self.headButton.frame.size.height/2;
    
    [self addSubview:_headButton];
    
    self.headName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headButton.frame)+10, CGRectGetMinY(self.headButton.frame)+(kScreenWidth/5 -kScreenWidth/14)/2, kScreenWidth/4, kScreenWidth/14)];
    [self addSubview:_headName];
    
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight/4, kScreenWidth, kScreenHeight)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.scrollEnabled = NO;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableview];
}

@end

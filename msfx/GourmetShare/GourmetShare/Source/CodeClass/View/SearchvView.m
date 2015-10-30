//
//  SearchvView.m
//  GourmetShare
//
//  Created by 马文豪 on 15/10/26.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "SearchvView.h"

@implementation SearchvView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
    }
    return self;
}

-(void)setView
{
    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 60)];
    [self addSubview:_search];
    self.searchList = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.search.frame), kScreenWidth, kScreenHeight-124) style:UITableViewStylePlain];
    [self addSubview:_searchList];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

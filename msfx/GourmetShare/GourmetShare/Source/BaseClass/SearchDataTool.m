//
//  SearchDataTool.m
//  GourmetShare
//
//  Created by jang on 15/10/26.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "SearchDataTool.h"
static SearchDataTool *sd;
@implementation SearchDataTool
//单例初始化工具类
+(SearchDataTool *)shareSearchData
{
    static dispatch_once_t once_tonke;
    if (sd == nil) {
        dispatch_once(&once_tonke, ^{
            sd = [[SearchDataTool alloc]init];
        });
    }
    return sd;
}

//搜索
-(void)searchWithKeyword:(NSString *)keyWord PassValue:(PassValue)passValue
{
    self.query = [AVQuery queryWithClassName:@"postStuff"];
    [_query selectKeys:@[@"title", @"sid"]];
    [_query whereKey:@"title" containsString:keyWord];
    _query.limit = 20;
    [_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSMutableArray *tempArr = [NSMutableArray array];
            for (AVQuery *q in objects) {
                StuffModle *s = [[StuffModle alloc]init];
                s.sid = [q valueForKey:@"sid"];
                s.title = [q valueForKey:@"title"];
                [tempArr addObject:s];
            }
            passValue(tempArr);
        } else {
           
        }
    }];
}
@end

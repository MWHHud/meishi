//
//  GetFavouriteDataTool.m
//  GourmetShare
//
//  Created by jang on 15/10/22.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "GetFavouriteDataTool.h"
static GetFavouriteDataTool *gf;
@implementation GetFavouriteDataTool
//单例初始化工具类
+(GetFavouriteDataTool *)shareFavouriteData
{
    static dispatch_once_t once_token;
    if (gf == nil) {
        dispatch_once(&once_token, ^{
            gf = [[GetFavouriteDataTool alloc]init];
        });
    }
    return gf;
}

-(BOOL)podFavouriteWith:(StuffModle *)stuff UserName:(NSString *)userName
{
    AVQuery *query = [AVQuery queryWithClassName:@"postFavourite"];
    [query whereKey:@"userName" equalTo:userName];
    [query whereKey:@"sid" equalTo:stuff.sid];
    AVObject *q = [query getFirstObject];
    if ([q valueForKey:@"sid"] ==nil) {
        self.postFavourite = [AVObject objectWithClassName:@"postFavourite"];
        [_postFavourite setObject:userName forKey:@"userName"];
        [_postFavourite setObject:stuff.albums forKey:@"albums"];
        [_postFavourite setObject:stuff.burden forKey:@"burden"];
        [_postFavourite setObject:stuff.sid forKey:@"sid"];
        [_postFavourite setObject:stuff.imtro forKey:@"imtro"];
        [_postFavourite setObject:stuff.ingredients forKey:@"ingredients"];
        [_postFavourite setObject:stuff.steps forKey:@"steps"];
        [_postFavourite setObject:stuff.tags forKey:@"tags"];
        [_postFavourite setObject:stuff.title forKey:@"title"];
        return [_postFavourite save];

    }
    return YES;
}

-(void)getFavouriteWithUserName:(NSString *)userName PassValue:(PassValue)passVallue
{
    NSMutableArray *tempArr = [NSMutableArray array];
    AVQuery *query = [AVQuery queryWithClassName:@"postFavourite"];
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            for (AVQuery *q in objects) {
                StuffModle *s = [[StuffModle alloc]init];
                s.albums = [q valueForKey:@"albums"];
                s.burden = [q valueForKey:@"burden"];
                s.sid = [q valueForKey:@"sid"];
                s.imtro = [q valueForKey:@"imtro"];
                s.ingredients = [q valueForKey:@"ingredients"];
                NSMutableArray *stArr = [NSMutableArray array];
                for (StepModle *st in [q valueForKey:@"steps"]) {
                    [stArr addObject:st];
                }
                s.steps = stArr;
                s.tags = [q valueForKey:@"tags"];
                s.title = [q valueForKey:@"title"];
                [tempArr addObject:s];
            }
            passVallue(tempArr);
        } else {

        }
    }];
}

-(void)deleteFavouriteWith:(StuffModle *)stuff UserName:(NSString *)userName
{
    AVQuery *query = [AVQuery queryWithClassName:@"postFavourite"];
    [query whereKey:@"userName" equalTo:userName];
    [query whereKey:@"sid" equalTo:stuff.sid];
    AVObject *q = [query getFirstObject];
    [q deleteInBackground];
}
@end
